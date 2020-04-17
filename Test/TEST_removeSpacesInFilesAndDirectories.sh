#!/bin/bash
#---------------------------------------------------
# Tests the script "removeSpacesInFilesAndDirectories.sh"
#
# red, 18.04.2020
#---------------------------------------------------

PATH_PREFIX=./

#Store current directory and change to the script directory
# Change into the script directory
SCRIPTDIR=$(readlink -f $(dirname "$0"))
pushd "${SCRIPTDIR}" > /dev/null

# Create new test environment
rm -f removeSpacesInFilesAndDirectories.sh
rm -rf test_removeSpacesInFilesAndDirectories
mkdir -p test_removeSpacesInFilesAndDirectories


# Create a few directories and files to test
cd test_removeSpacesInFilesAndDirectories
mkdir -p "Test01/Test   02"
touch "Test01/Test   02/file     with spaces.txt"
mkdir -p "noSpaces"
touch "noSpaces/notSpacesFile.txt"
mkdir -p "lot spaces in/this dir and test/it recursive"
touch "lot spaces in/this dir and test/it recursive/file w space.txt"
touch "lot spaces in/this dir and test/it recursive/fileWoSpace.txt"

# Get the script under test
cp ../../removeSpacesInFilesAndDirectories.sh .

# Run the test
echo "--- Directories before the test ---"
find -name "*"
echo "--- Directories before the test ---"
echo ""
bash removeSpacesInFilesAndDirectories.sh
echo ""
echo "--- Directories after the test ---"
find -name "*"
echo "--- Directories after the test ---"

# Back to the original location
popd > /dev/null
