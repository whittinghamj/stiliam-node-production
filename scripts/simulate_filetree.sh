find /mnt/nas01/plex/tv -type d -exec mkdir -p dest/{} \; \
       -o -type f -exec touch /{} \;

