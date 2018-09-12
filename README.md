# Linux Mint Setup

### Introduction
----------------

This is Bash script to help me configure Linux Mint computers I work on to have the applications and packages I like to use.

### Usage
---------

<<<<<<< HEAD
* You have to make sure you have an Android Studio ZIP, gitkraken.deb, jdk.tar.gz, and Netbeans.sh for all of this to execute.
=======
* You have to make sure you have an gitkraken.deb and jdk.tar.gz for all of this to execute.
>>>>>>> 104b7da6d6d3b190825a9f2468b67ea442363a99
* Also make sure that you update the filenames and paths in the Bash script. This assumes in same directory.
* You will also want to change the git config to your username and email

### TODO
--------

This is an always growing list as I expand the work I am doing and the tools I use. Once I find the time and motivation, I would like to find and save the specific configurations for each the applications mentioned also.

### /bin Contents
-----------------

##### GeneralizeRequirementDotTxt.py

Simple script to take a "requirements.txt" file and strip the specific versions from it. Below demonstrates what I mean by this with "example==9.3.4" being a typical entry in a "requirements.txt" file and "example" being the output from my script.

> example==9.3.4 ---> example

If you want to bring over the Python packages you have installed, run the following command:

```
$ pip freeze > requirements.txt
```

For Python 2.X you probably want to probably want to prepend the command with "python -m" and for Python 3.X you would probably want "python3 -m".
