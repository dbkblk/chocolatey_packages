#Include %A_ScriptDir%\functions.ahk

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
IfNotExist, %A_WorkingDir%\..\..\packed\%name%\%name%.%version%.nupkg 
{
  updatePackage(name, version, url)
}