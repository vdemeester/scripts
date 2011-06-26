#!/bin/sh
# **sync-music** is a `rsync(1)` based shell script used to synchronize music
# folders between disk and computer.
# Since it is based on `rsync(1)`, it should be possible to add rsync arguments
# to it when executed (e.g. something like `--dry-run`)
#
# Usage 
# -----------------
set -e
#/ Usage: sync-music [-v] <source> <destination> [options]
#/ Synchronize music folders.
#/ 
#/ The sync-music program will use rsync to synchronize the <source> folder 
#/ with the <destination> one. As a trailing shlash `/` has a meaning when used
#/ with rsync, a confirmation will be asked (with an help message)
#/ 
#/ -v : verbose mode (rsync)
expr -- "$*" : ".*--help" >/dev/null && {
    grep '^#/' <"$0" | cut -c4-
    exit 0
}

# First we are going to *search* for the rsync executable.
command -v rsync >/dev/null || {
    echo "$(basename $0): rsync command not found." 1>&2
    exit 1
}

VERBOSE=""
test "$1" = '-v' && {
    VERBOSE="$1"
    shift
}

# Grab `<source>` argument
source="$1"
# Shifting arguments to get the next ofe as $1 (and thus no counting)
shift
# And next is `<destination>`
destination="$1"
shift

# We are now going to test if the given `<source>` and `<destination>` does 
# exists and *are* folders.
if ! test -d $source
then
    echo "$source does not exists or is not a folder"
    exit 1
fi
if ! test -d $destination
then
    echo "$destination does not exists or is not a folder"
    exit 1
fi

# Now the we are sure `<source>` and `<destination>` are *syncable*, we are 
# going to check for the trailing slash on `<source>` and warn the user if it 
# is not present (because it could sound *fishy*).
source_slash=${source%/}
if test "${source}" = "${source_slash}"
then
    echo "Warning : You did not use a trailing slash for $source"
    echo "The trailing slash has a meaning with rsync, you should read the manual before doing anything wrong."
    echo "Are you sure to continue ? (y/N)"
    read yes
    if ! test -z "$yes" && ( test "$yes" = "y" || test "$yes" = "Y" )
    then echo 'You take your own risks !' #do nothing !
    else exit 1
    fi
fi

# This is now the main part. We are building the command line based on what we
# got upfront.
rsync -a \
      $VERBOSE \
      $* \
      --filter=". filter" \
      --delete-excluded \
      $source \
      $destination

