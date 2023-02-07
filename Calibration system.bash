#!/bin/bash
# The following Code is developed based on MacOS13.1, some modificatoin is required for Windows system
# Import the data from the CSV file
# first we will need to convert the file from excel to css file, then we will be able to excuse steps below
cd ~/Desktop
# install gnumeric function is required to run function sscovert is command not find 
ssconvert /Users/cristiano/Desktop/birthdays.xlsx /Users/cristiano/Desktop/birthdays.csv

# Skill the first row of table since that is lagend
tail -n +2 /Users/cristiano/Desktop/birthdays.csv > /Users/cristiano/Desktop/birthdays_without_header.csv

# The path of this file should be matching to where this file been saved to. 
data=$(awk -F, '{print $1,$2}' birthdays_without_header.csv)

while true; do
    # Get the current date
    current_date=$(date +%Y/%m/%d)

    # Iterate through the rows of the imported data
    while read -r line; do
        name=$(echo "$line" | awk '{print $1}')
        birthday=$(echo "$line" | awk '{print $2}')
        
        # Compare the current date with the birthday
        if [ "$current_date" == "$birthday" ]; then
            # Send an email notification
            osascript -e 'display notification "Happy birthday '$name'! 
            " with title "Birthday Reminder"'

        fi
    done <<< "$data"
    sleep 86400
done
