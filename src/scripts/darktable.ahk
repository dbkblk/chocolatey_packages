#Include %A_ScriptDir%\functions.ahk

; Ensure to be in the right relative directory
IfExist, %A_WorkingDir%\darktable.ahk
{
  SetWorkingDir, %A_WorkingDir%\..\..
}

; ### Darktable package

; Download file
UrlDownloadToFile, https://github.com/darktable-org/darktable/releases/latest, %A_ScriptDir%\temp.html
FileRead, html, %A_ScriptDir%\temp.html
FileDelete, %A_ScriptDir%\temp.html

; Parse version
RegExMatch(html, "release-[\w\.\-]*\/darktable-([\w\.\-]*)-win64.exe", version)
; https://github.com/darktable-org/darktable/releases/download/release-2.4.0/darktable-2.4.0-win64.exe

; Gather informations
name = darktable
version := version1
url = https://github.com/darktable-org/darktable/releases/download/release-%version%/darktable-%version%-win64.exe

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