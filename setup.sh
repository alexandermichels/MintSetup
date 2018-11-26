#!/usr/bin/env bash

fullinstallation="false";
if [ $1 = "-f" ] || [ $1 = "--full" ]; then
    fullinstallation="true";
    echo "Full installation selected."
else
    echo "Lite installation will proceed by default."
fi

sudo apt -y update
sudo apt -y upgrade

#install pip
sudo apt install -y python-pip
sudo apt install -y python3-pip
sudo pip install --upgrade pip

#a bunch of "essentials" for python3
sudo apt -y install python3 python-dev python3-dev build-essential libssl-dev libffi-dev libxml2-dev libxslt1-dev zlib1g-dev
sudo python3 -m pip install setuptools wheel
#install Spyder
sudo apt -y install spyder
sudo apt -y install spyder3

#install G++
sudo apt -y install g++

# install cmake
sudo apt install -y cmake

#install git
sudo apt -y install git
git config --global user.name "alexandermichels"
git config --global user.email alexandercm4297@gmail.com
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

#install spotify
sudo apt -y install spotify-client

#install Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt -y update
sudo apt -y install google-chrome-stable

#install curl
sudo apt -y install curl

#install VLC
sudo add-apt-repository ppa:videolan/stable-daily
sudo apt -y update
sudo apt -y install vlc

#install deluge
sudo apt -y install deluge


if [ $fullinstallation == "true" ]; then
    # htop
    sudo apt install -y htop

    # pytest
    sudo apt install -y python-pytest

    # OpenGL API, Mesa Off-screen rendering extension, and other fun stuff for [mujoco-py](https://github.com/openai/mujoco-py#install-mujoco)
    sudo apt install -y libosmesa6-dev libgl1-mesa-dev libopenmpi-dev patchelf

    # VirtualEnv
    sudo pip install virtualenv
    # Atom
    sudo add-apt-repository ppa:webupd8team/atom
    sudo apt -y update
    sudo apt -y install atom

    # install MiKTeX
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
    echo "deb [arch=amd64] http://miktex.org/download/ubuntu bionic universe" | sudo tee /etc/apt/sources.list.d/miktex.list
    sudo apt -y update
    sudo apt -y install miktex
    sudo miktexsetup --shared=yes finish
    sudo initexmf --admin --set-config-value [MPM]AutoInstall=1
    sudo apt -y install -y texlive-latex-extra
    sudo mpm --admin --verbose --package-level=complete --upgrade

    # install texstudio
    sudo apt -y install texstudio

    # install JDK
    sudo echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu bionic main" | tee -a     /etc/apt/sources.list
    sudo echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu bionic main" | tee -a /etc/apt/sources.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
    sudo apt update
    sudo apt -y install oracle-java8-installer
    sudo apt install -y oracle-java8-set-default
    #add .desktop file

    #Gradle
    sudo add-apt-repository ppa:cwchien/gradle
    sudo apt -y update
    sudo apt upgrade -y gradle

    #Maven
    sudo apt -y install maven

    #Grip
    sudo pip install grip

    #install R
    sudo apt install -y r-base-code
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
    echo "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/"  | sudo tee -a /etc/apt/sources.list
    sudo apt -y update
    sudo apt -y install r-base r-base-dev r-recommended r-doc-html r-doc-pdf ess
    sudo R -e 'install.packages("mosaic", repos="http://cran.us.r-project.org")'
    sudo R -e 'install.packages("rmarkdown", repos="http://cran.us.r-project.org")'
    sudo R -e 'install.packages("Lock5Data", repos="http://cran.us.r-project.org")'
    sudo R -e 'install.packages("ggformula", repos="http://cran.us.r-project.org")'

    #install RStudio
    sudo apt -y install rstudio
fi

sudo apt -y update
sudo apt -y upgrade

#Clean
sudo apt -y remove pidgin
sudo apt -y remove hexchat
sudo apt -y remove transmission-gtk
sudo apt -y remove rhythmbox
sudo apt -y remove mopidy
sudo apt -y remove xplayer
sudo apt -y purge pidgin
sudo apt -y purge hexchat
sudo apt -y purge transmission-gtk
sudo apt -y purge rhythmbox
sudo apt -y purge mopidy
sudo apt -y purge xplayer

sudo apt -y autoremove
sudo apt -y clean
rm -rf ~/.cache/thumbnails/*

sudo apt -y update
sudo apt -y upgrade
