Menu, Tray, Tip, PackageUpdater
SetWorkingDir, %A_ScriptDir%

; This script will automatically update the packages. It needs "checksum" and "git" to work.
; The result will be a git push to trigger the continuous update

; ### Basic functions

; Check local version string
parseLocal(name)
{
    FileRead, latest, %A_ScriptDir%\src\%name%\latest.ps1
    RegExMatch(latest, "\$version = '([\w\.\-]*)'", v_loc)
    return v_loc1
}

; Debug print
debug()
{
    global v_dist
    global v_loc
    global name
    global url
    MsgBox, %name%`n%v_loc%`n%v_dist%`n%url%
}

; Compare versions and trigger an AppVeyor build by commiting to git
checkVersions()
{
    global v_dist
    global v_loc
    global name
    global url

    IfGreater, v_dist, %v_loc%
    {
        text = $version = '%v_dist%'`n$url = '%url%'
        FileDelete, %A_ScriptDir%\src\%name%\latest.ps1
        FileAppend, %text%, %A_ScriptDir%\src\%name%\latest.ps1
        RunWait, git add %A_ScriptDir%\src\%name%\latest.ps1,,Hide
        RunWait, git commit -m "%name%|%v_dist%",,Hide
        RunWait, git push,,Hide
    }
}

cleanVariables()
{
    global v_dist =
    global v_loc =
    global name =
    global url =
}


; ### Darktable package
name = darktable
v_loc := parseLocal(name)

; Parse distant version
UrlDownloadToFile, https://github.com/darktable-org/darktable/releases/latest, %A_ScriptDir%\temp.html
FileRead, html, %A_ScriptDir%\temp.html
FileDelete, %A_ScriptDir%\temp.html
RegExMatch(html, "release-[\w\.\-]*\/darktable-([\w\.\-]*)-win64.exe", version)
v_dist := version1
url = https://github.com/darktable-org/darktable/releases/download/release-%v_dist%/darktable-%v_dist%-win64.exe

; Create script and clean variables
checkVersions()
cleanVariables()


; ### Homebank package
name = homebank
v_loc := parseLocal(name)

; Parse distant version
UrlDownloadToFile, http://homebank.free.fr/downloads.php, %A_ScriptDir%\temp.html
FileRead, html, %A_ScriptDir%\temp.html
FileDelete, %A_ScriptDir%\temp.html
startTxt = -setup.exe">&gt; HomeBank-
startLen := StrLen(startTxt)
stopTxt = -setup.exe</a>
StringGetPos, startPos, html, %startTxt%
StringGetPos, stopPos, html, %stopTxt%
v_dist := SubStr(html, startPos + startLen + 1, stopPos - (startPos + startLen))
url = http://homebank.free.fr/public/HomeBank-%v_dist%-setup.exe

; Create script and clean variables
checkVersions()
cleanVariables()


; ### Microsoft R Open package
name = microsoft-r-open
v_loc := parseLocal(name)

; Parse distant version
UrlDownloadToFile, https://github.com/Microsoft/microsoft-r-open/releases/latest, %A_ScriptDir%\temp.html
FileRead, html, %A_ScriptDir%\temp.html
FileDelete, %A_ScriptDir%\temp.html
RegExMatch(html, "https://github.com/Microsoft/microsoft-r-open/commits/MRO-([\w\.\-]*).atom", version)
v_dist := version1
url = https://mran.blob.core.windows.net/install/mro/%v_dist%/microsoft-r-open-%v_dist%.exe

; Create script and clean variables
checkVersions()
cleanVariables()

; ### Raw Therapee
name = rawtherapee
v_loc := parseLocal(name)

; Parse distant version
UrlDownloadToFile, http://rawtherapee.com/downloads, %A_ScriptDir%\temp.html
FileRead, html, %A_ScriptDir%\temp.html
FileDelete, %A_ScriptDir%\temp.html
RegExMatch(html, "\/releases_head\/windows\/RawTherapee_([\w\.]*)_WinVista_64.zip", version)
v_dist := version1
url = http://rawtherapee.com/releases_head/windows/RawTherapee_%v_dist%_WinVista_64.zip

; Create script and clean variables
checkVersions()
cleanVariables()

; ### Terminus
name = terminus
v_loc := parseLocal(name)

; Parse distant version
UrlDownloadToFile, https://github.com/Eugeny/terminus/releases/latest, %A_ScriptDir%\temp.html
FileRead, html, %A_ScriptDir%\temp.html
FileDelete, %A_ScriptDir%\temp.html
RegExMatch(html, "terminus\/releases\/download\/v[\w\.\-]*\/terminus-Setup-([\w\.\-]*).exe", version)
v_dist := version1
url = https://github.com/Eugeny/terminus/releases/download/v%v_dist%/terminus-Setup-%v_dist%.exe

; Fix version numbering for Chocolatey
StringReplace, v_dist, v_dist, alpha., alpha
StringReplace, v_dist, v_dist, beta., beta

; Create script and clean variables
checkVersions()
cleanVariables()

; ### Xmind
name = xmind
v_loc := parseLocal(name)

; Parse distant version and url
UrlDownloadToFile, https://github.com/xmindltd/xmind/releases/latest, %A_ScriptDir%\temp.html
FileRead, html, %A_ScriptDir%\temp.html
FileDelete, %A_ScriptDir%\temp.html
RegExMatch(html, "xmindltd\/xmind\/archive\/R([\w\.]*).zip", version)
v_dist := version1

UrlDownloadToFile, http://www.xmind.net/download/win/, %A_ScriptDir%\temp.html
FileRead, html, %A_ScriptDir%\temp.html
FileDelete, %A_ScriptDir%\temp.html
RegExMatch(html, "/xmind\/downloads\/([\w\.\-]*).exe", url)
url = https://www.xmind.net%url%

; Create script and clean variables
checkVersions()
cleanVariables()