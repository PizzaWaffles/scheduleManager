#!/bin/bash

workingDir="/home/pi/scheduleManager/"
sourceCalendar="HACH Global Calendar"
destCalendar="Work Schedule"
searchKey="Daniel"


number="545619" #number used to find events created by 'scheduleManager'
tmpFolder="$workingDirtmp/"
fileName="$tmpFolderagenda.data"
logFile="$tmpFoldercurrentLog.log"

mkdir $tmpFolder
touch $fileName
touch $logFile
echo "-Start-" > $logFile

gcalcli --calendar "$destSchedule" delete "$number" --iamaexpert >> $logFile
gcalcli --calendar "$sourceCalendar" search "$searchKey" | grep "$searchKey" | sed 's/\x1b\[[0-9;]*m//g' > $fileName

curYear=$(date +%Y)
curMonth=$(date +%m)
curDay=$(date +%d)

while read line; do
	if [ "$line" != "" ]; then
		year=$(echo $line | cut -c1-4)
		month=$(echo $line | cut -c6-7)
		day=$(echo $line | cut -c9-10)
		text=$(echo $line | cut -c12-)
		text=${text//"Daniel"/""}
		if [ "$year" -ge "$curYear" ] && [ "$month" -ge "$curMonth" ] && [ "$day" -ge "$curDay" ]; then
			echo "Adding----"$line >> $logFile
			gcalcli --calendar "$destCalendar" --title "$text" --when "$month/$day/$year" --duration 1 --where "Work" --description "$number" --reminder 180 add --allday >> $logFile

		fi
	fi

done < $fileName
