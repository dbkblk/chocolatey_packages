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
RegExMatch(html, "terminus\/releases\/download\/v[\w\.\-]*\/Terminus.Setup.([\w\.\-]*).exe", version)

; Gather informations
name = terminus
version := version1
url = https://github.com/Eugeny/terminus/releases/download/v%version%/Terminus.Setup.%version%.exe

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