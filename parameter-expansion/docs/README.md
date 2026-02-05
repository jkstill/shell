
For most:
pdflatex -file-line-error -interaction=nonstopmode -halt-on-error somefile.tex


If a TOC is created, you need to run the above command twice to get the correct page numbers in the TOC.

or use latexmk:
 latexmk -pdf -file-line-error -interaction=nonstopmode -halt-on-error bash-parameter-expansion-general.tex


