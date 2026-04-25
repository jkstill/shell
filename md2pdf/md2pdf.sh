#!/usr/bin/env bash

set -ao pipefail

# walk the directories in the AIHC_REPORTS_DIR 
# convert markdown reports to PDF using pandoc and LaTeX

# where are we?
scriptHome="$(dirname "$(readlink -f "$0")")"

# even though this is not specifically Oracle, this directory is in the oracle subdirectory.

echo "scriptHome: $scriptHome"

mdFileName="$1"

set -u

[[ -z "$mdFileName" ]] && {
	echo "Usage: $0 <markdown_file>"
	exit 1
}

# get path to mdFileName, and check if it exists
if [[ ! -f "$mdFileName" ]]; then
	echo "Markdown file not found: $mdFileName"
	exit 1
fi

mdFileName=$(readlink -f "$mdFileName") || {
	echo "Failed to resolve absolute path for $mdFileName"
	exit 1
}

mdDir=${mdFileName%/*}
if [[ -d "$mdDir" ]]; then
	cd "$mdDir" || {
		echo "Failed to change directory to $mdDir"
		exit 1
	}
else
	echo "Directory not found for markdown file: $mdDir"
	exit 1
fi

# strip path from mdFileName for use in pandoc command
mdFileName=${mdFileName##*/} || {
	echo "Failed to extract filename from path: $mdFileName"
	exit 1
}

#echo "mdFileName: $mdFileName"
#echo "mdDir: $mdDir"
#exit

texFileName="${mdDir}/${mdFileName%.md}.tex"
touch $texFileName || {
	echo "Failed to create LaTeX file: $texFileName"
	exit 1
}

pandoc --lua-filter=$scriptHome/pagebreak.lua -H $scriptHome/grffile.tex -f gfm -s -t latex -i "${mdDir}/${mdFileName}" -o "$texFileName" || {
	ls -l "$texFileName"
	echo "Failed to convert $mdFileName to LaTeX"
	exit 1
}

tmpTexFile=$(mktemp ) || {
	echo "Failed to create temporary file for LaTeX processing."
	exit 1
}

awk '/\\includegraphics/ && !/\\begin{figure}/ { 
	print "\\begin{center}"; 
	print $0; 
	print "\\end{center}"; 
	next 
} 
{print}' < "$texFileName" > $tmpTexFile && \
	{ mv $tmpTexFile "$texFileName"; } || {
		echo "Failed to center images in LaTeX file $texFileName"
		exit 1
	}

# pdflatex will create the filename based on the .tex file name, and use a .pdf extension
pdflatex -interaction=nonstopmode -halt-on-error "$texFileName" > /dev/null 2>&1 || {
	echo "err: $? - Failed to create PDF from LaTeX file $texFileName - Error: $(grep -Ei 'latex\s+error' "${texFileName%.tex}.log")"
	echo "log file: ${texFileName%.tex}.log"
	exit 1
}

#:<<"COMMENT"

for tmpFile in $tmpTexFile; do
	[[ -f "$tmpFile" ]] && {
		rm -f "$tmpFile" || {
			echo "Warning: Failed to remove intermediate file: $tmpFile" >&2
		}
	}
done

#COMMENT

pdfFileName="${texFileName%.tex}.pdf"

echo "tex: $pdfFileName"




