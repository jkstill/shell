
# ansi-color.sh
# Jared Still still@pythian.com jkstill@gmail.com
# Pythian 2018

# see for more codes:
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


# this is here only for test
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
}

colorPrint () {

	local "${@}"

	bg=${bg:-'yellow'}
	fg=${fg:-'black'}
	msg=${msg:-'NA'}

	if [[ -z ${colors[$fg]} ]]; then
		echo "Warning: colorPrint called with unknown foreground color '$fg' - using default"
		fg='default'
	fi

	if [[ -z ${colors[$bg]} ]]; then
		echo "Warning: colorPrint called with unknown background color '$bg' - using default"
		bg='default'
	fi

	#${fg}FG
	#${bg}BG
	setColor ${fg}FG
	setColor ${bg}BG
	printf "$msg"
	reset
	printf "\n"

}


#: <<'DISABLE-TEST'

colorPrint fg=red bg=white msg="This is a test message in red font on white background"
colorPrint fg=blue bg=white msg="This is a test message blue font on white background"
colorPrint fg=black bg=yellow msg="This is a test message black font on yellow background"
colorPrint fg=black bg=lightGreen msg="This is a test message black font on light green background"
colorPrint fg=white bg=magenta msg="This is a test message white font on magenta background"
colorPrint fg=black bg=cyan msg="This is a test message black font on cyan background"

t="this is a line with a linefeed\nthere it was!"

colorPrint fg=white bg=magenta msg="$t"

bgCount=${#colors[@]}
(( bgCount-- ))
fgCount=$bgCount

echo fgCount: $fgCount
echo bgCount: $bgCount

for bgIDX in $( seq 0 $bgCount )
do

	for fgIDX in $( seq 0 $fgCount )
	do
		if [[ $fgIDX -ne $bgIDX ]]; then
			#echo "foreground: ${colorNum[$fgIDX]}"
			#echo "background: ${colorNum[$bgIDX]}"

			colorPrint fg="${colorNum[$fgIDX]}" bg="${colorNum[$bgIDX]}" msg="${colorNum[$fgIDX]} text on ${colorNum[$bgIDX]} background"
		fi
	done

done

echo "-- end of testing --"

#DISABLE-TEST



