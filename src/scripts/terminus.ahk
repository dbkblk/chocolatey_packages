#Include %A_ScriptDir%\functions.ahk

; Ensure to be in the right relative directory
IfExist, %A_WorkingDir%\terminus.ahk
{
  SetWorkingDir, %A_WorkingDir%\..\..
}

; ### Homebank package

; Download file
UrlDownloadToFile, https://github.com/Eugeny/terminus/releases/latest, %A_ScriptDir%\temp.html
FileRead, html, %A_ScriptDir%\temp.html
FileDelete, %A_ScriptDir%\temp.html

; Parse version
RegExMatch(html, "terminus\/releases\/download\/v[\w\.\-]*\/terminus-Setup-([\w\.\-]*).exe", version)
; https://github.com/Eugeny/terminus/releases/download/v1.0.0-alpha.33/terminus-Setup-1.0.0-alpha.33.exe

; Gather informations
name = terminus
version := version1
url = https://github.com/Eugeny/terminus/releases/download/v%version%/terminus-Setup-%version%.exe

; Exit script if version is null
If !version
{
  ExitApp, 1
}

; Fix version numbering for Chocolatey
StringReplace, version, version, alpha., alpha
StringReplace, version, version, beta., beta

; Debug
; MsgBox, %name%`n%version%`n%url%

; Update package
IfNotExist, %A_WorkingDir%\packed\%name%\%name%.%version%.nupkg 
{  
  TrayTip, Package update, %name% -> %version%, 5, 1
  updatePackage(name, version, url)
}