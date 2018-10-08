#!/usr/bin/env bash
sudo apt-get -y update
sudo apt-get -y upgrade

#install pip
apt install -y python-pip
apt install -y python3-pip
sudo pip install --upgrade pip

#a bunch of "essentials" for python3
sudo apt-get install python3 python-dev python3-dev build-essential libssl-dev libffi-dev libxml2-dev libxslt1-dev zlib1g-dev
sudo python3 -m pip install setuptools wheel
#Spyder
sudo apt-get -y install spyder
sudo apt-get -y install spyder3

#install G++
sudo apt-get -y install g++

#install git
sudo apt-get -y install git
git config --global user.name "alexandermichels"
git config --global user.email alexandercm4297@gmail.com

#install spotify
sudo apt-get -y install spotify-client


#install Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get -y update
sudo apt-get -y install google-chrome-stable

#install curl
sudo apt-get -y install curl

#install VLC
sudo add-apt-repository ppa:videolan/stable-daily
sudo apt-get -y update
sudo apt-get -y install vlc

#install deluge
sudo apt-get -y install deluge

#Atom
sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get -y update
sudo apt-get -y install atom
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

sudo apt-get -y update
sudo apt-get -y upgrade

#Clean
sudo apt-get -y remove pidgin
sudo apt-get -y remove hexchat
sudo apt-get -y remove transmission-gtk
sudo apt-get -y remove rhythmbox
sudo apt-get -y remove mopidy
sudo apt-get -y remove xplayer
sudo apt-get -y purge pidgin
sudo apt-get -y purge hexchat
sudo apt-get -y purge transmission-gtk
sudo apt-get -y purge rhythmbox
sudo apt-get -y purge mopidy
sudo apt-get -y purge xplayer

sudo apt-get -y autoremove
sudo apt-get -y clean
rm -rf ~/.cache/thumbnails/*

sudo apt-get -y update
sudo apt-get -y upgrade