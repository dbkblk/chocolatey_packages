$packageName = 'microsoft-r-mkl'
$installerType = 'EXE'
$url = 'https://mran.revolutionanalytics.com/install/mro/3.3.0/RevoMath-3.3.0.exe'
$checksum = '6C8BE1DCABEE8BFC7FE2ACD7C174DC09FACF0C17F9E362AAA48257A42FCA6BF5'
$checkumType = 'sha256'
$silentArgs = '/silent'
$validExitCodes = @(0)

$scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $scriptPath "$($packageName)Install.ahk"
$ahkProc = Start-Process -FilePath $ahkExe `
                           -ArgumentList $ahkFile `
                           -PassThru
$ahkId = $ahkProc.Id
Write-Debug "$ahkExe start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID:`t$ahkId"                        
Write-Debug "$Env:ChocolateyInstall\helpers\functions"

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes