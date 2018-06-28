# Linux Mint Setup

### Introduction

This is Bash script to help me configure Linux Mint computers I work on to have the applications and packages I like to use.

### Usage

* You have to make sure you have an Android Studio ZIP, gitkraken.deb, jdk.tar.gz, and Netbeans.sh for all of this to execute.
* Also make sure that you update the filenames and paths in the Bash script. This assumes in same directory.
* You will also want to change the git config to your username and email

### TODO

This is an always growing list as I expand the work I am doing and the tools I use. Once I find the time and motivation, I would like to find and save the specific configurations for each the applications mentioned also.

### /bin Contents

#### \ GeneralizeRequirementDotTxt.py

Simple script to take a "requirements.txt" file and strip the specific versions from it. Below demonstrates what I mean by this with "example==9.3.4" being a typical entry in a "requirements.txt" file and "example" being the output from my script.

> example==9.3.4 ---> example
