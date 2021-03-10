
# ansi-color.sh
# Jared Still still@pythian.com jkstill@gmail.com
# Pythian 2018
# 
# This script works with Bash
# it does not work with Korn Shell as ksh seems unable to process color codes
# while tput is useful for cursor manipulation, it is not nearly as useful for setting colors 
# as is setting colors directly with escape codes
# so, there is not a ksh version of this scriopt
#
# show a display of all color combinations to see which are easist to read
# by setting SHOW_COLORS to any value
# eg.
#    SHOW_COLORS=bozo bash ansi-color.sh
#
# for more codes:
# https://misc.flogisoft.com/bash/tip_colors_and_formatting

# source this file

declare -A colors

colors[default]=1
colors[black]=1
colors[red]=1
colors[green]=1
colors[yellow]=1
colors[blue]=1
colors[magenta]=1
colors[cyan]=1
colors[lightGray]=1
colors[darkGray]=1
colors[lightRed]=1
colors[lightGreen]=1
colors[lightYellow]=1
colors[lightBlue]=1
colors[lightMagenta]=1
colors[lightCyan]=1
colors[white]=1


# this is here only for displaying colors with SHOW_COLORS environment variable set
# set it to any value
# SHOW_COLORS=bozo bash ansi-color.sh

declare -a colorNum
colorNum[0]=default
colorNum[1]=black
colorNum[2]=red
colorNum[3]=green
colorNum[4]=yellow
colorNum[5]=blue
colorNum[6]=magenta
colorNum[7]=cyan
colorNum[8]=lightGray
colorNum[9]=darkGray
colorNum[10]=lightRed
colorNum[11]=lightGreen
colorNum[12]=lightYellow
colorNum[13]=lightBlue
colorNum[14]=lightMagenta
colorNum[15]=lightCyan
colorNum[16]=white


# control

# reset all attributes
_RESET='\e[0m'

reset () {
	echo -ne $_RESET
}

# Foregrournd

declare -A ansiCodes

ansiCodes[defaultFG]="\e[39m"
ansiCodes[blackFG]="\e[30m"
ansiCodes[redFG]="\e[31m"
ansiCodes[greenFG]="\e[32m"
ansiCodes[yellowFG]="\e[33m"
ansiCodes[blueFG]="\e[34m"
ansiCodes[magentaFG]="\e[35m"
ansiCodes[cyanFG]="\e[36m"
ansiCodes[lightGrayFG]="\e[37m"
ansiCodes[darkGrayFG]="\e[90m"
ansiCodes[lightRedFG]="\e[91m"
ansiCodes[lightGreenFG]="\e[92m"
ansiCodes[lightYellowFG]="\e[93m"
ansiCodes[lightBlueFG]="\e[94m"
ansiCodes[lightMagentaFG]="\e[95m"
ansiCodes[lightCyanFG]="\e[96m"
ansiCodes[whiteFG]="\e[97m"

# Background
ansiCodes[defaultBG]="\e[49m"
ansiCodes[blackBG]="\e[40m"
ansiCodes[redBG]="\e[41m"
ansiCodes[greenBG]="\e[42m"
ansiCodes[yellowBG]="\e[43m"
ansiCodes[blueBG]="\e[44m"
ansiCodes[magentaBG]="\e[45m"
ansiCodes[cyanBG]="\e[46m"
ansiCodes[lightGrayBG]="\e[47m"
ansiCodes[darkGrayBG]="\e[100m"
ansiCodes[lightRedBG]="\e[101m"
ansiCodes[lightGreenBG]="\e[102m"
ansiCodes[lightYellowBG]="\e[103m"
ansiCodes[lightBlueBG]="\e[104m"
ansiCodes[lightMagentaBG]="\e[105m"
ansiCodes[lightCyanBG]="\e[106m"
ansiCodes[whiteBG]="\e[107m"

setColor () {
	#echo "ansi Color: $1"
	echo -ne ${ansiCodes[$1]}
	# can also be done with printf, but echo is used as it is a bash built in
	#printf "%b" "${ansiCodes[$1]}"
}

: << 'colorPrint-Docs'

 call colorPrint as shown:

 colorPrint fg=<color> bg=<color> lf=[0|1] msg='text to display'

 any parameters that are not specified will be set to default values

 fg: foreground color
 bg: background color
 lf: 
   0 - no linefeed 
	1 - linefeed
 msg: text to print

colorPrint-Docs

colorPrint () {

	declare "${@}"

	declare bg=${bg:-'yellow'}
	declare fg=${fg:-'black'}
	declare msg=${msg:-''}
	declare lf=${lf:-1}

	# get setting for  'set -u'  and save
	# seen in 'set -o' as 'nounset'
	# the '$-' variable contains a letter for each setting enabled with set -something
	# this operations removes the 'u' if it exists, and compares to the full string
	# if they are different then the parameter was set
	#
	# set to 0 if on
	# set to 1 if off

	[[ ${-/u} != ${-} ]] && nounset=0 || nounset=1

	# do not exit on unbound variables
	# this allows checking for the existing of this value in the array
	set +u

	if [[ -z ${colors[$fg]} ]]; then
		# colors hard coded as recursive call does not work properly
		printf "${ansiCodes[darkGrayBG]}${ansiCodes[lightYellowFG]}Warning: colorPrint called with unknown foreground color '$fg' - using default${_RESET}\n"
		fg='default'
	fi

	if [[ -z ${colors[$bg]} ]]; then
		printf "${ansiCodes[darkGrayBG]}${ansiCodes[lightYellowFG]}Warning: colorPrint called with unknown background color '$bg' - using default${_RESET}\n"
		bg='default'
	fi

	[[ $nounset -eq 0 ]] && set -u

	setColor ${fg}FG
	setColor ${bg}BG
	printf "$msg"

	reset
	[[ $lf -gt 0 ]] && printf "\n"

}


# execute with
# SHOW_COLORS=1 bash ansi-color.sh
SHOW_COLORS=${SHOW_COLORS:-''}

if [[ -n $SHOW_COLORS ]]; then

#colorPrint fg=red bg=white msg="This is a test message in red font on white background"
#colorPrint fg=blue bg=white msg="This is a test message blue font on white background"
#colorPrint fg=black bg=yellow msg="This is a test message black font on yellow background"
#colorPrint fg=black bg=lightGreen msg="This is a test message black font on light green background"
#colorPrint fg=white bg=magenta msg="This is a test message white font on magenta background"
#colorPrint fg=black bg=cyan msg="This is a test message black font on cyan background"

#t="this is a line with a linefeed\nthere it was!"
#colorPrint fg=white bg=magenta msg="$t"

bgCount=${#colors[@]}
(( bgCount-- ))
fgCount=$bgCount

echo fgCount: $fgCount
echo bgCount: $bgCount

# 0: all background colors on separate lines
# 1: each backround color on one line
lineFeeds=0

for bgIDX in $( seq 0 $bgCount )
do

	for fgIDX in $( seq 0 $fgCount )
	do
		if [[ $fgIDX -ne $bgIDX ]]; then
			#echo "foreground: ${colorNum[$fgIDX]}"
			#echo "background: ${colorNum[$bgIDX]}"

			if [[ $lineFeeds -eq 0 ]]; then
				separator=' | '
			else
				separator=''
			fi
			
			colorPrint lf=$lineFeeds fg="${colorNum[$fgIDX]}" bg="${colorNum[$bgIDX]}" msg="${colorNum[$fgIDX]} text on ${colorNum[$bgIDX]} background${separator}"
		fi
	done

	[[ $lineFeeds -eq 0 ]] && colorPrint lf=1

done

echo "-- end of testing --"

fi


