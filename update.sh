#!/bin/bash

# vars
VERSION=$(cat /opt/stiliam-node/version.txt)


# bash git update script
echo "Update Script v"$VERSION


# check for updates
cd /opt/stiliam-node/
# git --git-dir=/opt/stiliam-node/.git pull -q origin master


# make folders
mkdir -p /var/www/html/play/channels
mkdir -p /var/www/html/play/vod
mkdir -p /var/www/html/play/tv_series
mkdir -p /var/www/html/play/247_channels


# set permissions
chmod 777 /var/www/html/play/channels
# chmod 777 /var/www/html/play/channels/*
chmod 777 /var/www/html/play/vod
# chmod 777 /var/www/html/play/vod/*
chmod 777 /var/www/html/play/tv_series
# chmod 777 /var/www/html/play/tv_series/*
chmod 777 /var/www/html/play/247_channels
# chmod 777 /var/www/html/play/247_channels/*


# copy files for http server
cp /opt/stiliam-node/version.txt /var/www/html/node_version.txt
cp /opt/stiliam-node/www/stream_progress.php /var/www/html
cp /opt/stiliam-node/www/stream.php /var/www/html
cp /opt/stiliam-node/www/streams.php /var/www/html
cp /opt/stiliam-node/www/index.html /var/www/html
cp /opt/stiliam-node/www/phpinfo.php /var/www/html
cp /opt/stiliam-node/www/ffmpeg_progress.php /var/www/html
cp /opt/stiliam-node/www/api.php /var/www/html
cp /opt/stiliam-node/www/test.php /var/www/html
cp /opt/stiliam-node/config.json /var/www/html

cp /opt/stiliam-node/www/stream_channel.php /var/www/html
cp /opt/stiliam-node/www/stream_channel_247.php /var/www/html
cp /opt/stiliam-node/www/stream_vod.php /var/www/html
cp /opt/stiliam-node/www/stream_vod_tv.php /var/www/html

cp /opt/stiliam-node/www/stream_admin_channel.php /var/www/html
cp /opt/stiliam-node/www/stream_admin_channel_247.php /var/www/html
cp /opt/stiliam-node/www/stream_admin_vod.php /var/www/html
cp /opt/stiliam-node/www/stream_admin_vod_tv.php /var/www/html

cp /opt/stiliam-node/www/customer_dev.php /var/www/html
cp /opt/stiliam-node/www/system_stats.php /var/www/html
cp /opt/stiliam-node/www/scan_folder_folders.php /var/www/html
cp /opt/stiliam-node/www/scan_folder_files.php /var/www/html
cp /opt/stiliam-node/www/filebrowser.php /var/www/html
cp /opt/stiliam-node/www/filebrowser.php /var/www/html/play/vod
cp /opt/stiliam-node/www/filebrowser.php /var/www/html/play/tv_series
cp /opt/stiliam-node/www/filebrowser.php /var/www/html/play/247_channels
cp -R /opt/stiliam-node/www/speedtest /var/www/html


# set permissions to everyone for php files
chmod 777 /var/www/html/*.php


# grant sudo access
sudo_status=$(cat /etc/sudoers | grep www-data | wc -l)
if [ "$sudo_status" -eq "0" ]; then
   echo "Adding www-data to sudo group.";
   echo "www-data    ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
fi
sudo_status=$(cat /etc/sudoers | grep whittinghamj | wc -l)
if [ "$sudo_status" -eq "0" ]; then
   echo "Adding whittinghamj to sudo group.";
   echo "whittinghamj    ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
fi


# check for nginx offline
nginx_status=$(ps aux | grep nginx | grep -v 'grep' | wc -l)
if [ "$nginx_status" -eq "0" ]; then
   echo "Starting NGINX Streaming Server.";
   /usr/local/nginx/sbin/nginx
fi


# finished
echo "Update Complete"
echo " "
