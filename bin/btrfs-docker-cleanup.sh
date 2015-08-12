#!/bin/bash
set -e
# Script to clean the /var/lib/docker subvolume when using docker with btrfs storage driver
if command -v btrfs > /dev/null 2>&1; then
    root="$(df "/var/lib/docker" | awk 'NR>1 { print $NF }')"

    for subvol in $(btrfs subvolume list -o "$root/" 2>/dev/null | awk -F' path ' '{ print $2 }' | sort -r); do
        subvolDir="${subvol#root}"
        ( set -x; btrfs subvolume delete "$subvolDir" )
    done
fi
