# Chocolatey package version checking the latest version of packages
# Written by Hadrien Dussuel

import os
import json
import requests
import re
import functions

# Standard routine for package update
def PackageRoutine(name, urlVersion, regex, urlDownload):
    local = functions.GetLocalVersion(name)
    distant = functions.GetDistantVersion(urlVersion, regex)

    print("Checking -> " + name + " | " + local + " | " + distant)

    if(distant != local):
        url = urlDownload.replace("{{version}}", distant)
        print(name + " can be updated to " + distant + " with " + url)
        WriteVersionFile(name, distant, url)
        return True

    return False

# Write the new version in the JSON file
def WriteVersionFile(name, version, url):
    variables = { "name": name, "version": version, "url": url}
    file = "src/" + name + "/latest.json"

    if os.path.isdir("src/" + name) and os.path.exists(file):
        with open(file, 'w') as f:
            json.dump(variables, f)

    return

# Running the routines
PackageRoutine("homebank", "http://homebank.free.fr/downloads.php", r'/public/HomeBank-([\w\.\-]*)-setup.exe', 'http://homebank.free.fr/public/HomeBank-{{version}}-setup.exe')

PackageRoutine("darktable", "https://github.com/darktable-org/darktable/releases/latest", r'release-[\w\.\-]*\/darktable-([\w\.\-]*)-win64.exe', "https://github.com/darktable-org/darktable/releases/download/release-{{version}}/darktable-{{version}}-win64.exe")

PackageRoutine("microsoft-r-open", "https://github.com/Microsoft/microsoft-r-open/releases/latest", r'https://github.com/Microsoft/microsoft-r-open/commits/MRO-([\w\.\-]*).atom', "https: //mran.blob.core.windows.net/install/mro/{{version}}/windows/microsoft-r-open-{{version}}.exe")

PackageRoutine("rawtherapee", "http://rawtherapee.com/downloads", r'\/builds\/windows\/RawTherapee_([\w\.]*)_WinVista_64.zip', "https://rawtherapee.com/shared/builds/windows/RawTherapee_{{version}}_WinVista_64.zip")

PackageRoutine("terminus", "https://github.com/Eugeny/terminus/releases/latest", r'terminus\/releases\/download\/v[\w\.\-]*\/terminus-([\w\.\-]*)-setup.exe', "https://github.com/Eugeny/terminus/releases/download/v{{version}}/terminus-{{version}}-setup.exe")
