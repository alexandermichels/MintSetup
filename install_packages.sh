sudo apt-get -y update
sudo apt-get -y upgrade

#install G++
sudo apt-get -y install g++

#install git
sudo apt-get -y install git

#install curl
sudo apt-get -y install curl

#install MiKTeX
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
echo "deb http://miktex.org/download/ubuntu xenial universe" | sudo tee /etc/apt/sources.list.d/miktex.list
sudo apt-get -y update -y
sudo apt-get -y install miktex -y

#install texstudio
sudo apt-get -y -y texstudio

#install R
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
echo "deb http://https://cran.cnr.berkeley.edu//bin/linux/ubuntu stretch -cran34/"  | sudo tee -a /etc/apt/sources.list
sudo apt-get -y update

#install RStudio
sudo apt-get -y install rstudio

#install JDK ? idk if this will work
tar -zxvf jdk-8u161-linux-x64.tar.gz
sudo mkdir -p /opt/java
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk/bin/java 1
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk/bin/java 1
sudo update-alternatives --set java /opt/java/jdk1.8.0_161/bin/java

#install spotify
sudo apt-get -y install spotify-client

#install chromium
sudo apt-get -y install chromium-browser

#install VLC
sudo add-apt-repository ppa:videolan/stable-daily
sudo apt-get -y update
sudo apt-get -y install vlc

#install gitkraken
sudo apt-get -y install ./gitkraken-amd64.deb

#requires Enters
#LinuxBrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
test -d ~/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
test -r ~/.bash_profile && echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.bash_profile
echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.profile
export PATH=$HOME/.linuxbrew/bin:$PATH
hash -r
sudo apt-get -y install linuxbrew-wrapper
brew install hello

#Atom
sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get -y update
sudo apt-get -y install atom


#Netbeans
sudo chmod +x netbeans-8.2-cpp-linux-x64.sh
./netbeans-8.2-cpp-linux-x64.sh

#install Android Studio
sudo apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
sudo unzip -o android-studio-ide-171.4443003-linux.zip -d /usr/local
cd /usr/local/android-studio/bin
./studio.sh

sudo apt-get -y update
sudo apt-get -y upgrade

#Clean
sudo apt-get -y remove thunderbird
sudo apt-get -y remove pidgin
sudo apt-get -y remove hexchat
sudo apt-get -y remove transmission
sudo apt-get -y remove rhythmbox
sudo apt-get -y remove mopidy

sudo apt-get -y autoremove
sudo apt-get -y clean
rm -rf ~/.cache/thumbnails/*

sudo apt-get -y update
sudo apt-get -y upgrade
