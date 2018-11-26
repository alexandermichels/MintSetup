# Linux Mint Setup 1.2.0

## Table of Contents
* <a href="#intro">Introduction</a>
* <a href="#usage">Usage</a>
* <a href="#docs">Documentation</a>
* <a href="#todo">TODO</a>
* <a href="#bin">/bin Contents</a>
* <a href="#version">Versioning</a>

## <a id="intro">Introduction</a>

This is Bash script to help me configure [Linux Mint](https://www.linuxmint.com/) computers I work on to have the applications and packages I like to use. This is meant to be as general as possible, but when I need to make a decision, I make it to work for the most recent version of Linux Mint Cinnamon, right now that is [Linux Mint 19 "Tara" Cinnamon](https://www.linuxmint.com/edition.php?id=254).

There are two flavors to this install script, **full** and **lite**. The former is meant to setup a computer with lots of software for development and the later is meant to simply install utilities and remove what I percieve as "bloatware" in Linux Mint. Everything in the Lite version runs in the Full version.


## <a id="usage">Usage</a>

You will also want to change the git config to your username and email! If you decide to use the weekly updater you will need to enter in your email and computer name as well!

By default the setup script will install the lite version without weekly updates:

```bash
$ bash setup.sh
```

For the full version, use the `-f` or `--full` flag:

```bash
$ bash setup.sh -f
$ bash setup.sh --full
```

If you would like to have weekly updates you can use the `-u` or `--updates` flag:
```bash
$ bash setup.sh -u
$ bash setup.sh -updates
```

Lastly, you can do both! You can have weekly update and a full setup, in either order:
```bash
$ bash setup.sh -f -u
$ bash setup.sh -u -f
$ bash setup.sh --full --updates
$ bash setup.sh --updates --full
```

## <a id="docs">Documentation</a>

**Included Software:**
* [Atom](https://atom.io/)
* [CMake](https://cmake.org/)
* [Curl](https://curl.haxx.se/)
* [Deluge](https://deluge-torrent.org/)
* [G++](https://linux.die.net/man/1/g++)
* [Git (and configures a global email and name)](https://git-scm.com/)
* [Google Chrome](https://www.google.com/chrome/)
* [MailUtils](https://mailutils.org/)
* [Pip (for Python 2 and Python 3)](https://pypi.org/project/pip/)
* A variety of "essentials" Python packages
* [Spotify](https://www.spotify.com/us/)
* [Spyder (for Python 2 and Python 3)](https://github.com/spyder-ide/spyder)
* [VLC](https://www.videolan.org/vlc/index.html)

**Both versions remove:**
* [Hexchat](https://hexchat.github.io/)
* [Mopidy](https://www.mopidy.com/)
* [Pidgin](https://pidgin.im/)
* [Rhythmbox](https://wiki.gnome.org/Apps/Rhythmbox)
* [Transmission](https://transmissionbt.com/)
* [Xplayer](https://github.com/linuxmint/xplayer)

#### Full

The full version additionally installs the following:

**Included Packages:**
* [Gradle](https://gradle.org/)
* [Grip (amazing for converting markdown to HTML)](https://github.com/joeyespo/grip)
* [Open MPI (libopenmpi-dev)](https://www.open-mpi.org/)
* [JDK (Oracle Java 8)](https://www.oracle.com/technetwork/java/index.html)
* [Maven](https://maven.apache.org/)
* [Mesa 3D Graphics Library (libosmesa6-dev)](https://mesa3d.org/)
* [MiKTeK (as admin)](https://miktex.org/)
* [PatchELF (utility to modify the dynamic linker and RPATH of ELF executables) (patchelf)](https://nixos.org/patchelf.html)
* [OpenGL API (libgl1-mesa-dev)](https://www.mesa3d.org/)
* [R (with some R packages and essentials)](https://www.r-project.org/)
* [RStudio](https://www.rstudio.com/)
* [TexStudio](https://www.texstudio.org/)

#### Updates

The updates uses [Aptitude](https://linux.die.net/man/8/aptitude) and [Anacron](https://help.ubuntu.com/community/AutoWeeklyUpdateHowTo) to update your system weekly and email you a report.

## <a id="todo">TODO</a>

This is an always growing list as I expand the work I am doing and the tools I use. Once I find the time and motivation, I would like to find and save the specific configurations for each the applications mentioned also.

## <a id="bin">/bin Contents</a>

#### GeneralizeRequirementDotTxt.py

Simple script to take a "requirements.txt" file and strip the specific versions from it. Below demonstrates what I mean by this with "example==9.3.4" being a typical entry in a "requirements.txt" file and "example" being the output from my script.

> example==9.3.4 ---> example

If you want to bring over the Python packages you have installed, run the following command:

```bash
$ pip freeze > requirements.txt
```

For Python 2.X you probably want to probably want to prepend the command with "python -m" and for Python 3.X you would probably want "python3 -m".

## <a id="version">Versioning</a>

* 1.0.x : (March 17th, 2018 - September 11th, 2018) : Just one version to setup
* 1.1.x : (September 12th, 2018 - November 25th, 2018) : Full and Lite versions
* 1.2.x : (November 25th, 2018 - Present) : Added weekly scheduled updates
