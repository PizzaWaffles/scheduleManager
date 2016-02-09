#!/bin/bash

source config.data

tmpFolder=$workingDir"tmp/"
fileName=$tmpFolder"agenda.data"
logFile=$tmpFolder"currentLog.log"

mkdir $tmpFolder
touch $fileName
touch $logFile
echo "-Start-" > $logFile

gcalcli -v --calendar "$destSchedule" delete "$number" --iamaexpert >> $logFile

echo "" > $fileName

for t in $searchKey; do
	gcalcli --calendar "$sourceCalendar" search "$t" | grep "$t" | sed 's/\x1b\[[0-9;]*m//g' >> $fileName
	echo "$t" >> $logFile
done
#exit 1

curYear=$(date +%Y)
curMonth=$(date +%m)
curDay=$(date +%d)

while read -r line; do
	if [ "$line" != "" ]; then
		year=$(echo $line | cut -c1-4)
		month=$(echo $line | cut -c6-7)
		day=$(echo $line | cut -c9-10)
		text=$(echo $line | cut -c12-)
		#text=${text//"Daniel"/""}
		if [ "$year" -ge "$curYear" ] && [ "$month" -ge "$curMonth" ] && [ "$day" -ge "$curDay" ]; then
			echo "Adding----"$line >> $logFile
			gcalcli --calendar "$destCalendar" --title "$text" --when "$month/$day/$year" --duration 1 --where "Work" --description "$number" --reminder 180 add --allday >> $logFile

		fi
	fi

done < "$fileName"

echo "Done" >> $logFile
exit 0
