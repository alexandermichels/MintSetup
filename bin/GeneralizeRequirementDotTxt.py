# -*- coding: utf-8 -*-
"""
Created on Wed Jun 27 23:37:23 2018

@author: alex
"""

req = open("requirements.txt", "r+")
txt = req.read().strip()
lines = txt.split()
print(lines)
file = ""
for line in lines:
    string = line[:line.find("=")]
    print(string)
    file = file + string + "\n"

print(file)
req.seek(0)
req.write(file)
req.truncate()
req.close()