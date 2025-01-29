#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <port> <command>"
    exit 1
fi

PORT="$1"
shift
COMMAND="$@"   

CONFIG_FILE="/tmp/proxychains_${PORT}.conf"

# Create the proxychains configuration file
echo "[ProxyList]" > "$CONFIG_FILE"
echo "socks5 127.0.0.1 $PORT" >> "$CONFIG_FILE"

# run proxychains with the command over the specific configurations 
proxychains4 -q -f "$CONFIG_FILE" $COMMAND
