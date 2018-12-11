#!/usr/bin/env bash

sudo apt dist-upgrade -y
sudo apt update -y
sudo apt upgrade -y

#install curl
sudo apt install -y curl

curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
sudo apt update -y
sudo apt install -y plexmediaserver


#sonarr
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update -y
sudo apt install -y mediainfo libmono-cil-dev
sudo apt install -y sqlite3 libsqlite3-dev

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0xa236c58f409091a18aca53cbebff6b99d9b78493
echo "deb http://apt.sonarr.tv/ master main" | sudo tee /etc/apt/sources.list.d/sonarr.list

sudo apt update -y
sudo apt install -y nzbdrone
sudo mono --debug /opt/NzbDrone/NzbDrone.exe

# radarr
sudo apt update -y
cd /opt
sudo curl -L -O $( curl -s https://api.github.com/repos/Radarr/Radarr/releases | grep linux.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 )
sudo tar -xvzf Radarr.*.linux.tar.gz

#start plex, sonarr, and radarr on start
