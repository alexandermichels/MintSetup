#!/usr/bin/env bash
if [ $1 = "-f" ] || [ $1 = "--full" ]; then
    echo "Full installation selected."
else
    echo "Lite installation will proceed by default."
fi

sudo apt-get -y update
sudo apt-get -y upgrade

#install pip
apt install -y python-pip
apt install -y python3-pip
sudo pip install --upgrade pip

#a bunch of "essentials" for python3
sudo apt-get -y install python3 python-dev python3-dev build-essential libssl-dev libffi-dev libxml2-dev libxslt1-dev zlib1g-dev
sudo python3 -m pip install setuptools wheel
#install Spyder
sudo apt-get -y install spyder
sudo apt-get -y install spyder3

#install G++
sudo apt-get -y install g++

#install git
sudo apt-get -y install git
git config --global user.name "alexandermichels"
git config --global user.email alexandercm4297@gmail.com
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

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

if [ $1 = "-f" ] || [ $1 = "--full" ]; then
    #Atom
    sudo add-apt-repository ppa:webupd8team/atom
    sudo apt-get -y update
    sudo apt-get -y install atom

    #install MiKTeX
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
    echo "deb [arch=amd64] http://miktex.org/download/ubuntu bionic universe" | sudo tee /etc/apt/sources.list.d/miktex.list
    sudo apt-get -y update
    sudo apt-get -y install miktex
    sudo miktexsetup --shared=yes finish
    sudo initexmf --admin --set-config-value [MPM]AutoInstall=1
    sudo apt-get -y install -y texlive-latex-extra
    sudo mpm --admin --verbose --package-level=complete --upgrade

    #install texstudio
    sudo apt-get -y install texstudio

    #install JDK
    sudo echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu bionic main" | tee -a     /etc/apt/sources.list
    sudo echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu bionic main" | tee -a /etc/apt/sources.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
    sudo apt-get update
    sudo apt-get -y install oracle-java8-installer
    #add .desktop file

    #Grip
    sudo pip install grip

    #install R
    sudo apt install -y r-base-code
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
    echo "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/"  | sudo tee -a /etc/apt/sources.list
    sudo apt-get -y update
    sudo apt-get -y install r-base r-base-dev r-recommended r-doc-html r-doc-pdf ess
    sudo R -e 'install.packages("mosaic", repos="http://cran.us.r-project.org")'
    sudo R -e 'install.packages("rmarkdown", repos="http://cran.us.r-project.org")'
    sudo R -e 'install.packages("Lock5Data", repos="http://cran.us.r-project.org")'
    sudo R -e 'install.packages("ggformula", repos="http://cran.us.r-project.org")'

    #install RStudio
    sudo apt-get -y install rstudio
fi

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
