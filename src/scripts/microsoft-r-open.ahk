#Include %A_ScriptDir%\functions.ahk

; Ensure to be in the right relative directory
IfExist, %A_WorkingDir%\microsoft-r-open.ahk
{
  SetWorkingDir, %A_WorkingDir%\..\..
}

; ### Microsoft R Open package

; Download file
UrlDownloadToFile, https://mran.microsoft.com/download/, %A_ScriptDir%\temp.html
FileRead, html, %A_ScriptDir%\temp.html
FileDelete, %A_ScriptDir%\temp.html

; Parse version
RegExMatch(html, "\/install\/mro\/[\w\.]*\/microsoft-r-open-([\w\.]*).exe", version)

; Gather informations
name = microsoft-r-open
version = %version1%
url = https://mran.microsoft.com/install/mro/%version%/microsoft-r-open-%version%.exe

; Debug
; MsgBox, %name%`n%version%`n%url%

; Update package
IfNotExist, %A_WorkingDir%\packed\%name%\%name%.%version%.nupkg 
{
  TrayTip, Package update, %name% -> %version%, 5, 1
  updatePackage(name, version, url)
}