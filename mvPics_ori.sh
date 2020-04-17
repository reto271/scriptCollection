#!/bin/bash
#---------------------------------------------------
# Script moves pictures from the temp folder to
#  folders according the date.
#
# red, 14.04.2015
#---------------------------------------------------

PATH_PREFIX=../

#Store current directory and change to the script directory
currentDirectory=$(pwd)
scriptDirectory=$(dirname $0)
cd ${scriptDirectory}

for file in *.JPG *.MOV *.jpg *.mp4
do
    # Get the file's modification year, month and day
    #mac - year=$(stat -f "%Sm" -t "%Y" "$file")
    #mac - month=$(stat -f "%Sm" -t "%m" "$file")
    #mac - day=$(stat -f "%Sm" -t "%d" "$file")
    year=$(stat -c "%y" "$file" | awk -F'-' '{ print $1 }')
    month=$(stat -c "%y" "$file" | awk -F'-' '{ print $2 }')
    day=$(stat -c "%y" "$file" | awk -F'-' '{ print $3 }' | awk -F' ' '{ print $1 }')

     # Assemble directory name
     directoryName="${year}${month}${day}_"
     echo "Move '${file}' to '${PATH_PREFIX}${directoryName}'"

    # Create the directory and move the file
    mkdir -p ${PATH_PREFIX}${directoryName}
    mv "${file}" ${PATH_PREFIX}${directoryName}
done

#Restore original directory
cd ${currentDirectory}
