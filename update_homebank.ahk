#Include tf.ahk

; This script will automatically update the homebank package

name = homebank

; Download file
UrlDownloadToFile, http://homebank.free.fr/downloads.php, temp.html
FileRead, html, temp.html

; Parse version
startTxt = <p>The latest stable release of HomeBank is <strong>
startLen := StrLen(startTxt)
stopTxt = </strong>. See the <a href="ChangeLog">ChangeLog</a>.</p>
StringGetPos, startPos, html, %startTxt%
StringGetPos, stopPos, html, %stopTxt%
version := SubStr(html, startPos + startLen + 1, stopPos - (startPos + startLen))

; Url 
url = http://homebank.free.fr/public/HomeBank-%version%-setup.exe

FileDelete, temp.html

;MsgBox, Name is : %name%`nVersion is : %version% `nUrl is : %url%

; Copy dir
IfExist, unpacked\%name%\%version%
  FileRemoveDir, unpacked\%name%\%version%, 1

FileCreateDir, unpacked\%name%\

IfNotExist, packed\%name%\
  FileCreateDir, packed\%name%\

FileCopyDir, %name%, unpacked\%name%\%version%

; Replace name, version, url
nuspecFile = %A_ScriptDir%\unpacked\%name%\%version%\%name%.nuspec
installFile = %A_ScriptDir%\unpacked\%name%\%version%\tools\chocolateyInstall.ps1
TF_Replace(nuspecFile, "{{PackageVersion}}", version)
TF_Replace(installFile, "{{DownloadUrl}}", url)

; Overwrite existing file
FileDelete, %A_ScriptDir%\unpacked\%name%\%version%\%name%.nuspec
FileDelete, %A_ScriptDir%\unpacked\%name%\%version%\tools\chocolateyInstall.ps1
FileMove, %A_ScriptDir%\unpacked\%name%\%version%\%name%_copy.nuspec, %A_ScriptDir%\unpacked\%name%\%version%\%name%.nuspec
FileMove, %A_ScriptDir%\unpacked\%name%\%version%\tools\chocolateyInstall_copy.ps1, %A_ScriptDir%\unpacked\%name%\%version%\tools\chocolateyInstall.ps1

; Pack the files
RunWait %comspec% /c choco pack .\unpacked\%name%\%version%\%name%.nuspec,,Hide

; Move the file
FileDelete, %A_ScriptDir%\packed\%name%\%name%.%version%.nupkg
FileMove, %A_ScriptDir%\%name%.%version%.nupkg, %A_ScriptDir%\packed\%name%\%name%.%version%.nupkg