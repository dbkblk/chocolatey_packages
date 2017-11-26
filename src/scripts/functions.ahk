; ## Functions ##
updatePackage(name, version, url, url64 = "")
{
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
  installFile := RegExReplace(installFile, "{{DownloadUrl}}", url)
  If sha
    installFile := RegExReplace(installFile, "{{Checksum}}", sha)

  If sha64
    installFile := RegExReplace(installFile, "{{Checksum64}}", sha64)

  If url64
    installFile := RegExReplace(installFile, "{{DownloadUrl64}}", url64)


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

  ; Create a file on the desktop
  filename = %name% - %version%
  FileAppend, Chocolatey: %name% was updated to %version%, %A_Desktop%\%filename%
}