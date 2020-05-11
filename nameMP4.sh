#!/bin/bash
#---------------------------------------------------
# Renames mp4 and mov files according the creation
#  date found in the meta data of the move. New
#  file name:
#   oldFileName_yyyymmdd_hhmmss.oldExtension
#
# red, 11.05.2020
#---------------------------------------------------

#Store current directory and change to the script directory
SCRIPTDIR=$(readlink -f $(dirname "$0"))
pushd "${SCRIPTDIR}" > /dev/null

# Dry run?
doRenamePics=0
if [ $# -eq 1 ] ; then
    if [ "$1" == "--rename" ] ; then
        doRenamePics=1
    fi
fi


for file in *.mp4 *.MP4 *.MOV *.mov ; do
    timeStamp=$(ffprobe ${file} 2>&1 |  grep time | sed -e 's/^[ ]*//' | uniq)
    if [ "" == "${timeStamp}" ] ; then
        echo "-----------------"
        echo "fileName: ${file}"
        echo "-----------------"
    else
        echo '########################################################'
        #echo "timeStamp: ${timeStamp}"
        timeStampOnly=$(echo ${timeStamp} | awk -F':' '{ print $2 }')
        #echo "timeStampOnly: ${timeStampOnly}"

        timeStampOnly=$(echo ${timeStamp} | awk -F':' '{ print $2 }')
        #echo "timeStampOnly: ${timeStampOnly}"

        #date
        year=$(echo ${timeStampOnly} | awk -F'-' '{ print $1 }')
        #echo "year: ${year}"
        month=$(echo ${timeStampOnly} | awk -F'-' '{ print $2 }')
        #echo "month: ${month}"
        daytmp=$(echo ${timeStampOnly} | awk -F'-' '{ print $3 }')
        day=$(echo ${daytmp} | awk -F'T' '{ print $1 }')
        #echo "day: ${day}"

        #time of day
        timeOnlyTemp=$(echo ${timeStamp} | awk -F'T' '{ print $2 }')
        timeOnly=$(echo ${timeOnlyTemp} | awk -F'.' '{ print $1 }')
        #echo "timeOnly ${timeOnly}"
        timeToPrint=$(echo ${timeOnly} | sed 's#:##g')
        #echo "timeToPrint: ${timeToPrint}"

        # Assemble directory name
        baseFileName=$(echo ${file%.*})
        fileExtension=$(echo ${file##*.})
        #echo "baseFileName: ${baseFileName}"
        fileName="${baseFileName}_${year}${month}${day}_${timeToPrint}.${fileExtension}"


        # Create the directory and move the file
        echo "Move '${file}' to '${fileName}'"
        if [ 1 -eq ${doRenamePics} ] ; then
            mv "${file}" ${fileName}
        fi
    fi
done

#summary
echo "-----"
if [ 1 -eq ${doRenamePics} ] ; then
    echo "done"
else
    echo "Dry run, to rename add '--rename'"
fi

# Back to the original location
popd > /dev/null
