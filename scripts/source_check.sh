#!/bin/bash

(( UID != 0 )) && { echo "Error: you MUST be logged in as root."; exit 1; }

if fuser -v /dev/$1 > /dev/null 2>&1; then
    printf "busy"
else
    printf "available"
fi