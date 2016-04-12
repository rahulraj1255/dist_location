#!/bin/bash
d=0
declare -a line
declare -a dist
origin=IITB
while read loc[$d]
do
	d=$((d+1));
done
k=0
l=0
while [[ $l < $d ]]
do
	wget "https://maps.googleapis.com/maps/api/directions/json?origin=$origin\&destination=${loc[$l]}"
	file=$(find -type f -name "*$source*${loc[$l]}*")
	#echo $file $l_______
	for i in {1..33} 
	do
		read line
 		if [[ "$line" == "" ]] ; then
			dist[$k]="n"
			break
		fi
		s=$( echo $line | grep text)
		if [[ "$s" == "$line" ]]
			then
			break
		fi
	#	echo $line
	done <$file
	echo $line
	
	if [[ "${dist[$k]}" == "n" ]] ; then
		k=$((k+1))
		#echo ------------$k-------------------$l--------------------
		l=$((l+1))	
		continue
	fi
	line=($(echo $line))
	line=${line[2]}
	line=$( echo $line | sed 's/,//' )
	dist[$k]=${line:1}
	#echo ${dist[$k]}
	k=$((k+1))
	#echo ------------$k-------------------$l--------------------
	l=$((l+1))
done

k=0
l=0
i=0
x=0
while [[ $x < $d ]]
	do
		if [[ ${dist[$x]} == "n" ]] ; then
			if [[ i != 1 ]] ; then
				echo "Not Found"
			fi
			dist[$x]=""
			echo " ${loc[$x]} "
			i=1
		fi
		x=$((x+1))
	done
x=0
while [[ $x < $d ]]
do
	a=0
	min=${dist[0]}
	l=0
	while [[ $l < $d ]]
	do
		if [[ $min == "" || ( ( ${dist[$k]} != "" ) && ( $min > ${dist[$k]} ) ) ]] ; then
			min=${dist[$l]}
			a=$l
		fi

	  #   echo ${dist[$l]}."asd"
		l=$((l+1))
	done
	if [[ $min == "" ]] ; then
		exit 0
	fi
	echo ${loc[$a]} ":" $min
	dist[$a]=""
	x=$((x+1))
done
