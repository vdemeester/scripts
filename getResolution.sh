xdpyinfo | awk '/dimensions:/ {print $2}' | cut -d"x" -f1
