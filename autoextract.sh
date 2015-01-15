#!/bin/bash

ThisFile="$(which $0)"

# search for the line number where script finishes and the tarball starts
LinesToSkip=$(awk '/^__TARFILE_FOLLOWS__/ { print NR + 1; exit 0; }' $0)

# Find the name of the tar root directory and remove any previous copy
ThisReleaseName=$(tail -n +$LinesToSkip $ThisFile | tar -tz | head -1 | sed -e 's/\/.*//')

echo Installing to $ThisReleaseName
rm -rf $ThisReleaseName

# Extract the release
tail -n +$LinesToSkip $ThisFile | tar -xz

# Run any install script that might be present
if [[ -f $ThisReleaseName/bin/install.sh ]]; then
  echo "Running install script found inside package"
  exec $ThisReleaseName/bin/install.sh $@
else
  echo "No install script found, so considering this complete"
fi

exit 0


# Don't stick anything after this
__TARFILE_FOLLOWS__
