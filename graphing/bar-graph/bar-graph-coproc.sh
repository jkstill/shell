#!/usr/bin/env bash

while getopts h:m:M: OPTION
do
	case $OPTION in
		h) height=$OPTARG;;
		m) miny=$OPTARG;;
		M) maxy=$OPTARG
		   maxywidth=${#maxy};;
	esac
done

shift `expr $OPTIND - 1`

FileName=$1

# Initialise arrays
x=()
y=()

# Function 

coproc bc { bc -l; }
coprocPID=$!

printx () {
	current_height=$1

	n=0
	while [[ $n -lt $num ]]
	do

      #echo "(${y[n]}-$miny)/(($maxy-$miny)/$height)" 
      echo "(${y[n]}-$miny)/(($maxy-$miny)/$height)" >&"${bc[1]}"
		read yheight <&"${bc[0]}"

		echo "$yheight < $current_height" >&"${bc[1]}"
		read comparison <&"${bc[0]}"

      if [[ $comparison -eq 0 ]]
      then
          printf "%s" "█"
      else
          printf "%s" " "
      fi
      ((n++))
	done
} 

# Populate array
i=0
while read xval yval
do
	x[i]="$xval"
	y[i]="$yval"
	((i++))
done < $FileName

num=$i

# Set variables

maxxwidth=0
maxywidth=${#}
miny=${miny:=NA}
maxy=${maxy:=NA}
ylabindex=3

# Get min and max values
# For X
for xval in ${x[*]}
do
	# String length
	len=${#xval}
	if [[ $len -gt $maxxwidth ]]
	then
		maxxwidth=$len
	fi
done

# Find out how many x labels we can have
((xlabwidth=maxxwidth+2))
((numxlabs=(num-xlabwidth)/xlabwidth))

# For Y
for yval in ${y[*]}
do
	# String length
	len=${#yval}
	if [[ $len -gt $maxywidth ]]
	then
		maxywidth=$len
	fi

	# Min/Max Value
	if [[ $miny = NA ]] 
	then
		miny=$yval
	fi

	if [[ $maxy = NA ]]
	then
		maxy=$yval
	fi

	declare ycompare


	echo "$yval < $miny" >&"${bc[1]}"
	read ycompare <&"${bc[0]}"

	if [[ $ycompare -eq 1 ]]
	then
		miny=$yval
	fi

	echo "$yval > $maxy" >&"${bc[1]}"
	read ycompare <&"${bc[0]}"

	if [[ $ycompare -eq 1 ]]
	then
		maxy=$yval
	fi
done

# Now build the graph

i=${height:=30}
while [[ $i -ge 0 ]]
do	
	declare ylab

	if [[ $i -eq $height ]]
	then
		# Top Line
		printf "%${maxywidth}.${maxywidth}s %s" $maxy "┬"
		printx $i
	elif [[ $i -gt 0 ]]
	then
		((ymod=i%ylabindex))
		if [[ ymod -eq 0 ]]
		then
			# Print a label
			echo "(($maxy-$miny)/$height)*($i)" >&"${bc[1]}"
			read ylab <&"${bc[0]}"
			ylab=$(printf "%.0f" $ylab)
			printf "%${maxywidth}.${maxywidth}s %s" $ylab "┤"
		else
			printf "%${maxywidth}.${maxywidth}s %s" " " "│"
		fi
		printx $i
	else
		# Base Line
		printf "%${maxywidth}.${maxywidth}s %s" $miny "┼"
		if [[ $numxlabs -eq 0 ]]
		then
			((pen=num-1))
			printf "%0.s─" $(seq 1 $pen)
		else
			xlabcount=0
			while [[ $xlabcount -lt $numxlabs ]]
			do
				((pen=xlabwidth-1))
				printf "%0.s─" $(seq 1 $pen)
				printf "┬"
				((xlabcount++))
			done
			((pen=(num-1)-(xlabwidth*numxlabs)))
			printf "%0.s─" $(seq 1 $pen)
		fi
		printf "┐"
	fi

	printf "\n" 
	((i--))
done

## Lastly Print the X axis labels
printf "%${maxywidth}.${maxywidth}s " " "
printf "%${maxxwidth}.${maxxwidth}s" ${x[0]}
if [[ $numxlabs -eq 0 ]]
then
	((gap=num-maxxwidth))
	printf "%0.s " $(seq 1 $gap)
else
	xlabcount=0
	while [[ $xlabcount -lt $numxlabs ]]
	do
		((xlabcount++))
		((index=xlabcount*xlabwidth))
		printf "  %${maxxwidth}.${maxxwidth}s" ${x[index-1]}
	done
	((gap=num-(xlabwidth*(numxlabs+1))+2))
	printf "%0.s " $(seq 1 $gap)
fi
printf "%s\n" ${x[num-1]}

kill $coprocPID

exit 0

