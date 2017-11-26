#Include %A_ScriptDir%\functions.ahk
#Include <JSON>

; Ensure to be in the right relative directory
IfExist, %A_WorkingDir%\microsoft-r-open.ahk
{
  SetWorkingDir, %A_WorkingDir%\..\..
}

; ### Microsoft R Open package

; Get version on github
curl = %A_WorkingDir%\tools\curl\bin\curl.exe
cmd = %curl% -i "https://api.github.com/repos/Microsoft/microsoft-r-open/releases" -o %A_ScriptDir%\temp.json
RunWait, %comspec% /c %cmd%,,Hide

; Parse JSON
FileRead, json_file, %A_ScriptDir%\temp.json
RegExMatch(json_file, "https://github.com/Microsoft/microsoft-r-open/releases/tag/MRO-([\w\.]*)", version)
FileDelete, %A_ScriptDir%\temp.json

; Gather informations
name = microsoft-r-open
version = %version1%
url = https://mran.blob.core.windows.net/install/mro/%version%/microsoft-r-open-%version%.exe

; Debug
;MsgBox, %name%`n%version%`n%url%

; Exit script if version is null
If !version
{
  ExitApp, 1
}

; Update package
IfNotExist, %A_WorkingDir%\packed\%name%\%name%.%version%.nupkg 
{
  TrayTip, Package update, %name% -> %version%, 5, 1
  updatePackage(name, version, url)
}