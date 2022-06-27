import subprocess
from urllib.request import urlopen
from io import BytesIO
from zipfile import ZipFile
from os import path
from pathlib import Path
import shutil
import os
import time
import sys
from datetime import datetime
import webbrowser as wb
import requests

# Defining variables
directory = path.expandvars('%APPDATA%\\PopstarDevs\\2Take1Menu\\scripts\\')
url = "https://codeload.github.com/User00092/2Take1-User0092s_menu/zip/refs/heads/util-exe"
destination = directory+"User0092_menu\\Utilities"
zipFileD = path.expandvars(r'%APPDATA%\\PopstarDevs\\2Take1Menu\\scripts\\2Take1-User0092s_menu-util-exe')
main_folder = directory+"User0092_menu\\Utilities"
logFileName = str(datetime.now())
logFileName = logFileName.replace(":",".")
logFileName = logFileName.replace(".","-")
logFileName = logFileName+".log"
utilitiesFiles = [
    main_folder+"\\Utilities.py",
    main_folder+"\\Utilities.exe",
    main_folder+"\\Utilities.spec"
]
updaterFiles = [
    zipFileD+"\\Utilities.py",
    zipFileD+"\\Utilities.exe",
    zipFileD+"\\Utilities.spec"
]


# Creating log file
with open(destination+"\\Logs\\"+logFileName,"w") as file:
    pass
time.sleep(2.5)
# Defining functions
def download_and_unzip(url, extract_to='.'):
    http_response = urlopen(url)
    zipfile = ZipFile(BytesIO(http_response.read()))
    zipfile.extractall(path=extract_to)

def printT(text):
    print(text)
    with open(destination+"\\Logs\\"+logFileName,"a") as file:
        file.write("\n"+text+"\n")
        file.close()
# Getting latest version
printT("Downloading executer.\nThis may take a while depending on your internet speeds.\nPlease wait...")
download_and_unzip(url,destination)


# Checking if version was downloaded
exists = os.path.exists(zipFileD+"\\Utilities.py")
if exists:
    printT("Downloaded Utilities.exe :: Successful")
else:
    printT("Downloaded Utilities.exe :: Failed")
    time.sleep(5)
    sys.exit()


# Deleting current 
for i in utilitiesFiles:
    printT("Deleting file :: "+str(i))
    files = i
    os.remove(i)
    doesExists = os.path.exists(files)
    time.sleep(0.5)
    if not doesExists:
        printT("Deleted file :: "+str(files))
    else:
        printT("Filed to delete the file :: "+str(files))
    time.sleep(1.5)


# Moving files
for i in updaterFiles:
    printT("Moving file :: "+str(i))
    files = i
    shutil.move(i,main_folder)
    doesExists = os.path.exists(files)
    time.sleep(0.5)
    if not doesExists:
        printT("Moved file :: "+str(files))
    else:
        printT("Filed to move the file :: "+str(files))
    time.sleep(1.5)


# Verifing operation
printT("Checking operatiton...")
time.sleep(1.5)
for i in utilitiesFiles:
    doesExists = os.path.exists(i)
    if doesExists:
        printT("Operation :: Successful :: moved file :: "+str(i))
    else:
        printT("Operation :: Failed :: failed to move file :: "+str(i))
    time.sleep(1.5)

time.sleep(1)


# clean up
printT("Cleaning up :: "+str(zipFileD))
shutil.rmtree(zipFileD)
time.sleep(1)
printT("Closing Updater.exe in 5 seconds...")
time.sleep(5)
sys.exit()