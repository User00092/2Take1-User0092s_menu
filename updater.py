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

directory = path.expandvars('%APPDATA%\\PopstarDevs\\2Take1Menu\\scripts\\')
main_file = directory+"User0092's Menu.lua"
main_folder = directory+"User0092_menu"
logFileName = str(datetime.now())
logFileName = logFileName.replace(":",".")
logFileName = logFileName.replace(".","-")
logFileName = logFileName+".log"
url = "https://codeload.github.com/User00092/2Take1-User0092s_menu/zip/refs/heads/current"

with open(main_folder+"\\Updater\\Logs\\"+logFileName,"w") as file:
    pass
print("Please wait for a second. This prevents errors when finding the log file.")
time.sleep(1)
def printT(text):
    print(text)
    with open(main_folder+"\\Updater\\Logs\\"+logFileName,"a") as file:
        file.write("\n"+text+"\n")
        file.close()
def download_and_unzip(url, extract_to='.'):
    http_response = urlopen(url)
    zipfile = ZipFile(BytesIO(http_response.read()))
    zipfile.extractall(path=extract_to)

def deleteFile(file):
    os.remove(file)

def DeleteMenu():
    shutil.rmtree(main_folder)
    os.remove(main_file)
    return True
zipFolder = path.expandvars(r'%APPDATA%\\PopstarDevs\\2Take1Menu\\scripts\\2Take1-User0092s_menu-current')
changelog = zipFolder+r"\\CHANGELOG.txt"
# Main 
print("Welcome, to User0092's updater.")

print("\nPlease select an action below:\n")
print("1) Download/repair Current version")
print("2) delete menu")
print("3) See changelog")
action = input("Input: ").lower()

if action == "1":
    fileName = "2Take1-User0092s_menu-current"
    download_and_unzip(url,directory)

elif action == "2":
    fcontinue = input("Are you sure you want to delete all saved data? Y/N: ").lower()
    if fcontinue == "y":
        success = DeleteMenu()
        if success:
            printT("Deleted menu and saved data. This action cannot be undone.\nShutting down soon...")
            time.sleep(10)
            sys.exit()
        else:
            printT("Failure... Menu not deleted\nShutting down soon...")
            time.sleep(10)
            sys.exit()
    elif fcontinue == "n":
        pass
    else:
        pass
elif action == "3":
    printT("Opening changelog in browser...")
    time.sleep(1)
    wb.open("https://pastebin.com/jAWJYNtt")
else:
    printT("Invalid input :: "+str(action))
    #print("Shutting down soon...")
    # time.sleep(10)
    # sys.exit()


# If update or repair, then:
if action != "1":
    sys.exit()

def moveFile(current,destination):
    shutil.move(current,destination)

printT("Attempting to locate zip folder...")



time.sleep(2) # For aesthetics
doesExists = os.path.exists(zipFolder)
if not doesExists:
    printT("Folder not located!")
    time.sleep(5)
    sys.exit()

printT("Found zip folder :: "+ str(zipFolder))


zipMenu = zipFolder+r"\\User0092's Menu.lua"

zipMenuFolder = zipFolder+r"\\User0092_menu"

deletePaths = [
    main_folder+"\\Heist",
    main_folder+"\\Help",
    main_folder+"\\Lib"
]

# update process :: Delete current directories
printT("Deleting old Folders...")
for i in deletePaths:
    doesExists = os.path.exists(i)
    if doesExists:
        files = i
        printT("Found folder :: "+str(files))
        time.sleep(0.5)
        printT("deleting folder :: "+str(files))
        shutil.rmtree(i)
        doesExists = os.path.exists(i)
        time.sleep(0.5)
        if not doesExists:
            printT("Deleted folder :: "+str(files))
        else:
            printT("Cannot delete the folder :: "+str(files))
    time.sleep(1)
time.sleep(2)
printT("Deleting main file :: "+str(main_file))
os.remove(main_file)
doesExists = os.path.exists(main_file)
if not doesExists:
    printT("Deleted main file.")
else:
    printT("Failed to delete the main file...")

# update process :: Move zip files 
printT("Moving new files to directory...")
moveZipPaths = [
    zipMenuFolder+"\\Heist",
    zipMenuFolder+"\\Help",
    zipMenuFolder+"\\Lib"
]
for i in moveZipPaths:
    printT("Moving Folder :: "+str(i))
    shutil.move(i,main_folder)

# update process :: Move new main file
printT("Moving main file :: "+str(zipMenu))
shutil.move(zipMenu,directory)
with open(changelog,"r") as file:
    changelogTEXT = file.read()
    file.close()
printT("Moving Changelog :: "+str(changelog))
shutil.move(changelog,main_folder)
printT("Opening changelog in browser...")
time.sleep(1)
wb.open("https://pastebin.com/jAWJYNtt")
print("\n\n\n")
while action != "done":
    action = input("Enter 'done' to exit: ").lower()
    if action == "done":
        sys.exit()