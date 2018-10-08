# Linux Mint Setup

## Introduction

This is Bash script to help me configure [Linux Mint](https://www.linuxmint.com/) computers I work on to have the applications and packages I like to use. This is meant to be as general as possible, but when I need to make a decision, I make it to work for the most recent version of Linux Mint Cinnamon, right now that is [Linux Mint 19 "Tara" Cinnamon](https://www.linuxmint.com/edition.php?id=254).

There are two flavors to this install script, `setup_full.sh` and `setup_lite.sh`. The former is meant to setup a computer with lots of software for development and the later is meant to simply install utilities and remove what I percieve as "bloatware" in Linux Mint. Everything in the Lite version runs in the Full version.


## Usage

You will also want to change the git config to your username and email! To run you can simply use:

> bash setup_lite.sh

> bash setup_full.sh

## Documentation

#### setup_full.sh

Both versions remove:
* Hexchat
* Mopidy
* Pidgin
* Rhythmbox
* Transmission
* Xplayer

**Included Packages:**
* Atom
* Curl
* Deluge
* G++
* Git (and configures a global email and name and sets a 1 hour cache)
* Google Chrome
* Grip (amazing for converting markdown to HTML)
* JDK (Oracle Java 8)
* MiKTeK (as admin)
* Pip (for Python 2 and Python 3)
* A variety of "essentials" Python packages
* R (with some R packages and essentials)
* RStudio
* Spotify
* Spyder (for Python 2 and Python 3)
* TexStudio
* VLC

#### setup_lite.sh

**Included Packages:**
* Atom
* Curl
* Deluge
* G++
* Git (and configures a global email and name)
* Google Chrome
* Pip (for Python 2 and Python 3)
* A variety of "essentials" Python packages
* Spotify
* Spyder (for Python 2 and Python 3)
* VLC

## TODO

Add links to all of the packages mentioned.

This is an always growing list as I expand the work I am doing and the tools I use. Once I find the time and motivation, I would like to find and save the specific configurations for each the applications mentioned also.

## /bin Contents

#### GeneralizeRequirementDotTxt.py

Simple script to take a "requirements.txt" file and strip the specific versions from it. Below demonstrates what I mean by this with "example==9.3.4" being a typical entry in a "requirements.txt" file and "example" being the output from my script.

> example==9.3.4 ---> example

If you want to bring over the Python packages you have installed, run the following command:

```bash
$ pip freeze > requirements.txt
```

For Python 2.X you probably want to probably want to prepend the command with "python -m" and for Python 3.X you would probably want "python3 -m".
