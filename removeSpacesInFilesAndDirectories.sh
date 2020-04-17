#!/bin/bash
#---------------------------------------------------
# Removes spaces in files and directories. Replaces
#  the spaces by _.
#
# red, 18.04.2020
#---------------------------------------------------

#Store current directory and change to the script directory
# Change into the script directory
SCRIPTDIR=$(readlink -f $(dirname "$0"))
pushd "${SCRIPTDIR}" > /dev/null

# Process this directory and all sub-directories
find . -depth -name "* *" -execdir rename 's/ /_/g' "{}" \;

# Back to the original location
popd > /dev/null
