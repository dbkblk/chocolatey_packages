#Include %A_ScriptDir%\functions.ahk

; ### Homebank package

; Download file
UrlDownloadToFile, http://homebank.free.fr/downloads.php, %A_ScriptDir%\temp.html
FileRead, html, %A_ScriptDir%\temp.html
FileDelete, %A_ScriptDir%\temp.html

; Parse version
startTxt = -setup.exe">&gt; HomeBank-
startLen := StrLen(startTxt)
stopTxt = -setup.exe</a>
StringGetPos, startPos, html, %startTxt%
StringGetPos, stopPos, html, %stopTxt%

; Gather informations
name = homebank
version := SubStr(html, startPos + startLen + 1, stopPos - (startPos + startLen))
url = http://homebank.free.fr/public/HomeBank-%version%-setup.exe

; Debug
; MsgBox, %name%`n%version%`n%url%

; Update package
IfNotExist, %A_ScriptDir%\packed\%name%\%name%.%version%.nupkg 
{  
  updatePackage(name, version, url)
}