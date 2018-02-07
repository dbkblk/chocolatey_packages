#Include %A_ScriptDir%\functions.ahk

; Ensure to be in the right relative directory
IfExist, %A_WorkingDir%\xmind.ahk
{
  SetWorkingDir, %A_WorkingDir%\..\..
}

; ### Xmind package

; Download github page
UrlDownloadToFile, https://github.com/xmindltd/xmind/releases/latest, %A_ScriptDir%\temp.html
FileRead, html, %A_ScriptDir%\temp.html
FileDelete, %A_ScriptDir%\temp.html

; Parse version
RegExMatch(html, "xmindltd\/xmind\/archive\/R([\w\.]*).zip", version)

; Download Xmind download page
UrlDownloadToFile, http://www.xmind.net/download/win/, %A_ScriptDir%\temp.html
FileRead, html, %A_ScriptDir%\temp.html
FileDelete, %A_ScriptDir%\temp.html

RegExMatch(html, "/xmind\/downloads\/([\w\.\-]*).exe", url)

; Post-parsing


; Gather informations
name = xmind
version := version1
url = https://www.xmind.net/xmind/downloads/%url1%.exe

; Exit script if version is null
If !version
{
  ExitApp, 1
}

; Debug
; MsgBox, %name%`n%version%`n%url%

; Update package
IfNotExist, %A_WorkingDir%\packed\%name%\%name%.%version%.nupkg 
{  
  TrayTip, Package update, %name% -> %version%, 5, 1
  updatePackage(name, version, url)
}