; ### Raw Therapee
; Download file
UrlDownloadToFile, http://rawtherapee.com/downloads/, %A_ScriptDir%\temp.html
FileRead, html, %A_ScriptDir%\temp.html
FileDelete, %A_ScriptDir%\temp.html

; Parse version
RegExMatch(html, "\/releases_head\/windows\/RawTherapee_([\w\.]*)_WinVista_64.zip", version)

; Gather informations
name = rawtherapee
version = %version1%
zipName = RawTherapee_%version%_WinVista_64
url = http://rawtherapee.com/releases_head/windows/RawTherapee_%version%_WinVista_64.zip

; Debug
; MsgBox, %name%`n%version%`n%url%
; FileDelete, %A_ScriptDir%\..\..\packed\rawtherapee\rawtherapee.5.2.nupkg

; Update package (using custom routine because the standard function doesn't work with zip files)
IfNotExist, %A_WorkingDir%\..\..\packed\%name%\%name%.%version%.nupkg 
{
  ; Settings
  cacheDir = C:\cache
  TrayTip, Package update, %name% -> %version%, 5, 1

  ; Getting checksum of executable file
  SplitPath, url, fileName
  cacheName = %cacheDir%\%name%\%version%\%fileName%
  IfNotExist, %cacheName%
  {
      FileCreateDir, %cacheDir%\%name%\%version%
      UrlDownloadToFile, %url%, %cacheName%
      FileAppend,`n, %cacheName%.ignore,UTF-16
  }
  SetWorkingDir, %cacheDir%\%name%\%version%\
  RunWait, %comspec% /c 7z x -y RawTherapee_%version%_WinVista_64.zip,,Hide
  RunWait, %comspec% /c checksum -t sha256 -f "%zipName%.exe" > %A_Temp%\file_checksum,,Hide
  Loop, Read, %A_Temp%\file_checksum
  {
    if A_LoopReadLine
      checksumPackage = %A_LoopReadLine%
  }
  FileDelete, %A_Temp%\file_checksum
  FileDelete, *.txt
  FileDelete, *.exe
  SetWorkingDir, %A_ScriptDir%\..\..

  ; Adding extra zip checksum
  SetWorkingDir, %cacheDir%\%name%\%version%\
  RunWait, %comspec% /c checksum -t sha256 -f "%zipName%.zip" > %A_Temp%\file_checksum,,Hide
  Loop, Read, %A_Temp%\file_checksum
  {
    if A_LoopReadLine
      checksumZip = %A_LoopReadLine%
  }

  SetWorkingDir, %A_ScriptDir%\..\..
  ; Copy dir
  IfExist, %A_WorkingDir%\unpacked\%name%\%version%
    FileRemoveDir, %A_WorkingDir%\unpacked\%name%\%version%, 1

  FileCreateDir, %A_WorkingDir%\unpacked\%name%\

  IfNotExist, %A_WorkingDir%\packed\%name%\
    FileCreateDir, %A_WorkingDir%\packed\%name%\

  FileCopyDir, %A_WorkingDir%\src\%name%, %A_WorkingDir%\unpacked\%name%\%version%

  ; Replace name, version, url
  FileRead, nuspecFile, %A_WorkingDir%\src\%name%\%name%.nuspec
  FileRead, installFile, %A_WorkingDir%\src\%name%\tools\chocolateyInstall.ps1
  nuspecFile := RegExReplace(nuspecFile, "{{PackageVersion}}", version)
  installFile := RegExReplace(installFile, "{{ChecksumZip}}", checksumZip)
  installFile := RegExReplace(installFile, "{{Checksum}}", checksumPackage)
  installFile := RegExReplace(installFile, "{{ZipName}}", zipName)
  installFile := RegExReplace(installFile, "{{ZipName}}", zipName)
  installFile := RegExReplace(installFile, "{{DownloadUrl64}}", url)


  ; Overwrite existing file
  FileDelete, %A_WorkingDir%\unpacked\%name%\%version%\%name%.nuspec
  FileDelete, %A_WorkingDir%\unpacked\%name%\%version%\tools\chocolateyInstall.ps1
  FileAppend, %nuspecFile%, %A_WorkingDir%\unpacked\%name%\%version%\%name%.nuspec
  FileAppend, %installFile%, %A_WorkingDir%\unpacked\%name%\%version%\tools\chocolateyInstall.ps1

  ; Pack the files
  RunWait %comspec% /c choco pack .\unpacked\%name%\%version%\%name%.nuspec,,Hide

  ; Move the file
  FileDelete, %A_WorkingDir%\packed\%name%\%name%.%version%.nupkg
  FileMove, %A_WorkingDir%\%name%.%version%.nupkg, %A_WorkingDir%\packed\%name%\%name%.%version%.nupkg
  Sleep, 5000
}