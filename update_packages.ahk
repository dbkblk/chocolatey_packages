Menu, Tray, Tip, PackageUpdater
#include %A_ScriptDir%\lib\tf.ahk

; This script will automatically update the packages

; ## Functions ##
updatePackage(name, version, url)
{
  TrayTip, Package update, %name% -> %version%, 5, 1

  ;MsgBox, Name is : %name%`nVersion is : %version% `nUrl is : %url%
  ; Copy dir
  IfExist, %A_ScriptDir%\unpacked\%name%\%version%
    FileRemoveDir, %A_ScriptDir%\unpacked\%name%\%version%, 1

  FileCreateDir, %A_ScriptDir%\unpacked\%name%\

  IfNotExist, %A_ScriptDir%\packed\%name%\
    FileCreateDir, %A_ScriptDir%\packed\%name%\

  FileCopyDir, %name%, %A_ScriptDir%\unpacked\%name%\%version%

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
  Sleep, 5000
}


; ## Packages ##
; ### Homebank
name = homebank

; Download file
UrlDownloadToFile, http://homebank.free.fr/downloads.php, %A_ScriptDir%\temp.html
FileRead, html, %A_ScriptDir%\temp.html
FileDelete, %A_ScriptDir%\temp.html

; Parse version
startTxt = <p>The latest stable release of HomeBank is <strong>
startLen := StrLen(startTxt)
stopTxt = </strong>. See the <a href="ChangeLog">ChangeLog</a>.</p>
StringGetPos, startPos, html, %startTxt%
StringGetPos, stopPos, html, %stopTxt%
version := SubStr(html, startPos + startLen + 1, stopPos - (startPos + startLen))

; Url 
url = http://homebank.free.fr/public/HomeBank-%version%-setup.exe

IfNotExist, %A_ScriptDir%\packed\%name%\%name%.%version%.nupkg 
{  
  updatePackage(name, version, url)
}

; ### Microsoft R Open & RevoMath
; Download file
UrlDownloadToFile, https://mran.revolutionanalytics.com/download/, %A_ScriptDir%\temp.html
FileRead, html, %A_ScriptDir%\temp.html
FileDelete, %A_ScriptDir%\temp.html

RegExMatch(html, "\/install\/mro\/[\w\.]*\/MRO-([\w\.]*)-win.exe", versionR)
RegExMatch(html, "\/install\/mro\/[\w\.]*\/RevoMath-([\w\.]*).exe", versionRevoMath)

urlR = https://mran.revolutionanalytics.com%versionR%
urlRevoMath = https://mran.revolutionanalytics.com%versionRevoMath%

; MRO
name = microsoft-r-open
version =
url =

IfNotExist, %A_ScriptDir%\packed\%name%\%name%.%versionR1%.nupkg 
{  
  updatePackage(name, versionR1, urlR)
}

; Revomath
name = microsoft-r-mkl
IfNotExist, %A_ScriptDir%\packed\%name%\%name%.%versionRevoMath1%.nupkg 
{  
  updatePackage(name, versionRevoMath1, urlRevoMath)
}
