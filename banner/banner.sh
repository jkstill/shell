#!/usr/bin/env bash

# banners and sub-banners


declare -A bannerString=(
    ['#']='####################################################################################################'
    ['#info']='## '

    ['=']='   ===================================================================================================='
    ['=info']='   == '

    ['-']='      ----------------------------------------------------------------------------------------------------'
    ['-info']='      -- '

    ['%']='         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
    ['%info']='         %% '

    ['~']='            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    ['~info']='            ~~ '
)

declare -A bannerDepth=(
    [1]='#'
    [2]='='
    [3]='-'
    [4]='%'
    [5]='~'
)

depthKeys="${!bannerDepth[@]}"


banner () {
    local depth=$1; shift
    #[[ $depth =~ [$depthKeys] ]] || { echo "'$depth' is an invalid depth for banner"; exit 1; }
	 # or just a warning if you prefer
    [[ $depth =~ [$depthKeys] ]] || { echo "'$depth' is an invalid depth for banner" 1>&2; return 1; }

    echo
    echo "${bannerString[${bannerDepth[$depth]}]}"
    echo "${bannerString[${bannerDepth[$depth]}'info']} $*"
    echo "${bannerString[${bannerDepth[$depth]}]}"
    echo
}

for i in {1..6}; do
	 banner $i "this is banner level $i"
	 rc=$?
	 if [[ $rc -ne 0 ]]; then
	     echo "Error: banner function returned $rc" 1>&2
	 fi
done
