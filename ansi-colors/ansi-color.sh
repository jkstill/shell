
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

# control

# reset all attributes
_RESET='\e[0m'

reset () {
	echo -ne $_RESET
}

# Foregrournd
_DEFAULT_FG="\e[39m"
_BLACK_FG="\e[30m"
_RED_FG="\e[31m"
_GREEN_FG="\e[32m"
_YELLOW_FG="\e[33m"
_BLUE_FG="\e[34m"
_MAGENTA_FG="\e[35m"
_CYAN_FG="\e[36m"
_LIGHT_GRAY_FG="\e[37m"
_DARK_GRAY_FG="\e[90m"
_LIGHT_RED_FG="\e[91m"
_LIGHT_GREEN_FG="\e[92m"
_LIGHT_YELLOW_FG="\e[93m"
_LIGHT_BLUE_FG="\e[94m"
_LIGHT_MAGENTA_FG="\e[95m"
_LIGHT_CYAN_FG="\e[96m"
_WHITE_FG="\e[97m"

defaultFG () { 
	echo -ne $_DEFAULT_FG 
}

blackFG () { 
	echo -ne $_BLACK_FG 
}

redFG () { 
	echo -ne $_RED_FG 
}

greenFG () { 
	echo -ne $_GREEN_FG 
}

yellowFG () { 
	echo -ne $_YELLOW_FG 
}

blueFG () { 
	echo -ne $_BLUE_FG 
}

magentaFG () { 
	echo -ne $_MAGENTA_FG
}

cyanFG () { 
	echo -ne $_CYAN_FG 
}

lightGrayFG () { 
	echo -ne $_LIGHT_GRAY_FG 
}

darkGrayFG () { 
	echo -ne $_DARK_GRAY_FG 
}

lightRedFG () { 
	echo -ne $_LIGHT_RED_FG  
}

lightGreenFG () { 
	echo -ne $_LIGHT_GREEN_FG 
}

lightYellowFG () { 
	echo -ne $_LIGHT_YELLOW_FG 
}

lightBlueFG () { 
	echo -ne $_LIGHT_BLUE_FG 
}

lightMagentaFG () { 
	echo -ne $_LIGHT_MAGENTA_FG 
}

lightCyanFG () { 
	echo -ne $_LIGHT_CYAN_FG 
}

whiteFG () { 
	
	echo -ne $_WHITE_FG 
}


# Background
_DEFAULT_BG="\e[49m"
_BLACK_BG="\e[40m"
_RED_BG="\e[41m"
_GREEN_BG="\e[42m"
_YELLOW_BG="\e[43m"
_BLUE_BG="\e[44m"
_MAGENTA_BG="\e[45m"
_CYAN_BG="\e[46m"
_LIGHT_GRAY_BG="\e[47m"
_DARK_GRAY_BG="\e[100m"
_LIGHT_RED_BG="\e[101m"
_LIGHT_GREEN_BG="\e[102m"
_LIGHT_YELLOW_BG="\e[103m"
_LIGHT_BLUE_BG="\e[104m"
_LIGHT_MAGENTA_BG="\e[105m"
_LIGHT_CYAN_BG="\e[106m"
_WHITE_BG="\e[107m"

defaultBG () { 
	echo -ne $_DEFAULT_BG 
}

blackBG () { 
	echo -ne $_BLACK_BG 
}

redBG () { 
	echo -ne $_RED_BG 
}

greenBG () { 
	echo -ne $_GREEN_BG 
}

yellowBG () { 
	echo -ne $_YELLOW_BG 
}

blueBG () { 
	echo -ne $_BLUE_BG 
}

magentaBG () { 
	echo -ne $_MAGENTA_BG
}

cyanBG () { 
	echo -ne $_CYAN_BG 
}

lightGrayBG () { 
	echo -ne $_LIGHT_GRAY_BG 
}

darkGrayBG () { 
	echo -ne $_DARK_GRAY_BG 
}

lightRedBG () { 
	echo -ne $_LIGHT_RED_BG  
}

lightGreenBG () { 
	echo -ne $_LIGHT_GREEN_BG 
}

lightYellowBG () { 
	echo -ne $_LIGHT_YELLOW_BG 
}

lightBlueBG () { 
	echo -ne $_LIGHT_BLUE_BG 
}

lightMagentaBG () { 
	echo -ne $_LIGHT_MAGENTA_BG 
}

lightCyanBG () { 
	echo -ne $_LIGHT_CYAN_BG 
}

whiteBG () { 
	
	echo -ne $_WHITE_BG 
}

colorPrint () {

	local "${@}"

	bg=${bg:-'yellow'}
	fg=${fg:-'black'}
	msg=${msg:-'NA'}

	if [[ ${colors[$fg]} -ne 1 ]]; then
		echo "Warning: colorPrint called with unknown foreground color '$fg' - using default"
		fg='default'
	fi

	if [[ ${colors[$bg]} -ne 1 ]]; then
		echo "Warning: colorPrint called with unknown background color '$bg' - using default"
		bg='default'
	fi

	${fg}FG
	${bg}BG
	printf "$msg"
	reset
	printf "\n"

}

colorPrint fg=red bg=white msg="This is a test message in red font on white background"
colorPrint fg=blue bg=white msg="This is a test message blue font on white background"
colorPrint fg=black bg=yellow msg="This is a test message black font on yellow background"
colorPrint fg=black bg=lightGreen msg="This is a test message black font on light green background"
colorPrint fg=white bg=magenta msg="This is a test message white font on magenta background"

t="this is a line with a linefeed\nthere it was!"

colorPrint fg=white bg=magenta msg="$t"

echo "-- end of testing --"




