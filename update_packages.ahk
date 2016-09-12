Menu, Tray, Tip, PackageUpdater

; This script will automatically update the packages. It needs "checksum" to work.

; ## Functions ##
updatePackage(name, version, url, url64 = "")
{
  TrayTip, Package update, %name% -> %version%, 5, 1

  ; Generate checksum from url for 32 bits and 64bits
  cacheDir = C:\cache
  SplitPath, url, fileName
  cacheName = %cacheDir%\%name%\%version%\%fileName%
  IfNotExist, %cacheName%
  {
      FileCreateDir, %cacheDir%\%name%\%version%
      UrlDownloadToFile, %url%, %cacheName%
      FileAppend,`n, %cacheName%.ignore,UTF-16
  }  
  RunWait, %comspec% /c checksum -t sha256 -f "%cacheName%" > %A_Temp%\file_checksum,,Hide
  Loop, Read, %A_Temp%\file_checksum
  {
    if A_LoopReadLine
      sha = %A_LoopReadLine%
  }
  FileDelete, %A_Temp%\file_checksum
  if url64
  {
    SplitPath, url64, fileName
    cacheName = %cacheDir%\%name%\%version%\%fileName%
    IfNotExist, %cacheName%
    {
        UrlDownloadToFile, %url64%, %cacheName%
        FileAppend,`n, %cacheName%.ignore,UTF-16
    }  
    RunWait, %comspec% /c checksum -t sha256 -f "%cacheName%" > %A_Temp%\file_checksum,,Hide
    Loop, Read, %A_Temp%\file_checksum
    {
      if A_LoopReadLine
        sha64 = %A_LoopReadLine%
    }
    FileDelete, %A_Temp%\file_checksum
  }

  ;MsgBox, Name is : %name%`nVersion is : %version% `nUrl is : %url%
  ; Copy dir
  IfExist, %A_ScriptDir%\unpacked\%name%\%version%
    FileRemoveDir, %A_ScriptDir%\unpacked\%name%\%version%, 1

  FileCreateDir, %A_ScriptDir%\unpacked\%name%\

  IfNotExist, %A_ScriptDir%\packed\%name%\
    FileCreateDir, %A_ScriptDir%\packed\%name%\

  FileCopyDir, src\%name%, %A_ScriptDir%\unpacked\%name%\%version%

  ; Replace name, version, url
  FileRead, nuspecFile, %A_ScriptDir%\src\%name%\%name%.nuspec
  FileRead, installFile, %A_ScriptDir%\src\%name%\tools\chocolateyInstall.ps1
  nuspecFile := RegExReplace(nuspecFile, "{{PackageVersion}}", version)
  installFile := RegExReplace(installFile, "{{DownloadUrl}}", url)
  If sha
    installFile := RegExReplace(installFile, "{{Checksum}}", sha)

  If sha64
    installFile := RegExReplace(installFile, "{{Checksum64}}", sha64)

  If url64
    installFile := RegExReplace(installFile, "{{DownloadUrl64}}", url64)


  ; Overwrite existing file
  FileDelete, %A_ScriptDir%\unpacked\%name%\%version%\%name%.nuspec
  FileDelete, %A_ScriptDir%\unpacked\%name%\%version%\tools\chocolateyInstall.ps1
  FileAppend, %nuspecFile%, %A_ScriptDir%\unpacked\%name%\%version%\%name%.nuspec
  FileAppend, %installFile%, %A_ScriptDir%\unpacked\%name%\%version%\tools\chocolateyInstall.ps1

  ; Pack the files
  RunWait %comspec% /c choco pack .\unpacked\%name%\%version%\%name%.nuspec,,Hide

  ; Move the file
  FileDelete, %A_ScriptDir%\packed\%name%\%name%.%version%.nupkg
  FileMove, %A_ScriptDir%\%name%.%version%.nupkg, %A_ScriptDir%\packed\%name%\%name%.%version%.nupkg
  Sleep, 5000
}

; ## Packages ##
; ### Homebank
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

; Gather informations
name = homebank
version := SubStr(html, startPos + startLen + 1, stopPos - (startPos + startLen))
url = http://homebank.free.fr/public/HomeBank-%version%-setup.exe

; Update package
IfNotExist, %A_ScriptDir%\packed\%name%\%name%.%version%.nupkg 
{  
  updatePackage(name, version, url)
}

; ### Microsoft R Open
; Download file
UrlDownloadToFile, https://mran.revolutionanalytics.com/download/, %A_ScriptDir%\temp.html
FileRead, html, %A_ScriptDir%\temp.html
FileDelete, %A_ScriptDir%\temp.html

; Parse version
RegExMatch(html, "\/install\/mro\/[\w\.]*\/microsoft-r-open-([\w\.]*).msi", version)

; Gather informations
name = microsoft-r-open
version = %version1%
url = https://mran.revolutionanalytics.com/install/mro/%version%/microsoft-r-open-%version%.msi

; Update package
IfNotExist, %A_ScriptDir%\packed\%name%\%name%.%version%.nupkg 
{
  updatePackage(name, version, url)
}
