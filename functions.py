import os
import json
import requests
import re
import hashlib
import pathlib

# Return the locally recorded known version
def GetLocalVersion(packageName):
    # Check the package source directory
    if os.path.isdir("src/" + packageName) and os.path.exists("src/" + packageName + "/latest.json"):
        with open("src/" + packageName + "/latest.json") as f:
            j = json.load(f)
            return j["version"]

    else:
        print(packageName + " JSON file not found.")
        return ""

# Return the distant version string, based on a URL and regular expression
def GetDistantVersion(url, regExpr):
    page = requests.get(url, allow_redirects=True).content
    version = re.search(regExpr, page.decode("utf-8")).group(1)
    return version

# Return the locally recorded known version
def GetLocalData(packageName):
    # Check the package source directory
    if os.path.isdir("src/" + packageName) and os.path.exists("src/" + packageName + "/latest.json"):
        with open("src/" + packageName + "/latest.json") as f:
            j = json.load(f)
            return j

    else:
        print(packageName + " JSON file not found.")
        return ""

# Return the SHA256 checksum of the file
def GetFileChecksum(filePath):
    with open("tmp/tmpfile","rb") as f:
        bytes = f.read() # read entire file as bytes
        return hashlib.sha256(bytes).hexdigest()

# Return the file content in a string
def GetFileContent(filePath):
    return pathlib.Path(filePath).read_text("utf-8")

# Create a new file from content
def WriteFileContent(filePath, content):
    with open(filePath, "w", encoding="utf-8") as f:
        f.write(content)
    return