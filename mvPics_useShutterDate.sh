#!/bin/bash
#---------------------------------------------------
# Script moves JPG  pictures in this folder to
#  sub-folder named according the time the picture
#  was taken. Used JPG property "exif:DateTimeOriginal"
#
# red, 18.04.2020
#---------------------------------------------------

PATH_PREFIX=./

#Store current directory and change to the script directory
SCRIPTDIR=$(readlink -f $(dirname "$0"))
pushd "${SCRIPTDIR}" > /dev/null

for file in *.JPG *.MOV *.jpg *.mp4
do
    # Get the file's modification year, month and day
    timeStamp=$(identify -verbose ${file} | grep "exif:DateTimeOriginal")

    if [ "" == "${timeStamp}" ] ; then
        echo "-----------------"
        echo "fileName: ${file}"
        echo "-----------------"
    else
        timeStampOnly=$(echo ${timeStamp} | awk -F' ' '{ print $2 }')

        year=$(echo ${timeStampOnly} | awk -F':' '{ print $1 }')
        month=$(echo ${timeStampOnly} | awk -F':' '{ print $2 }')
        day=$(echo ${timeStampOnly} | awk -F':' '{ print $3 }')

        # Assemble directory name
        directoryName="${year}${month}${day}_/"

        # Create the directory and move the file
        mkdir -p ${PATH_PREFIX}${directoryName}
        echo "Move "${file}" ${PATH_PREFIX}${directoryName}"
        mv "${file}" ${PATH_PREFIX}${directoryName}
    fi
done

# Back to the original location
popd > /dev/null
