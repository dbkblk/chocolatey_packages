# Chocolatey package version checking and packing of package
# Written by Hadrien Dussuel
# Before to run this script for the first time, register your API key on Chocolatey.
# Find the API KEY here: https://chocolatey.org/account
# Then enter this command as admin: 
# choco setapikey -k yourAPIkey -s https://push.chocolatey.org/

import os
import subprocess
import glob

packages = os.listdir('src/')
print(packages)

for p in packages:
    print("Checking versions -> " + p)
    distantVersions = subprocess.getoutput('choco search --all -r ' + p).split('\n')

    # Get the packed files
    files = glob.glob("packed\\" + p + "*.nupkg")

    for f in files:

        versionFound = False
        version = f.replace("packed\\" + p + ".", "").replace(".nupkg", "")

        for v in distantVersions:
            current = v.split("|")[1]
            if(current == version):
                versionFound = True

        # If the version is not found, push it
        if not versionFound:
            print("Pushing -> " + p + " | " + version)
            subprocess.getoutput('choco push ' + f)
            subprocess.getoutput('git add src\\' + p + '\\latest.json')
            subprocess.getoutput('git commit -m \"' + p + '|' + version + '\"')

