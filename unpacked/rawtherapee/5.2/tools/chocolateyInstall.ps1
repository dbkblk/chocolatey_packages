$packageName = 'rawtherapee'
$installerType = 'EXE'
$url64 = 'http://rawtherapee.com/releases_head/windows/RawTherapee_5.2_WinVista_64.zip'
$checksumZip = 'EAFB89F930716EA4AE3019CC5FA65E537362E8ED9F682B15CBDA37B01CFEEF80'
$checksum64 = 'ACF0AD762F55467683811A7D32DC595E587A8DFD29FE86E818544DAD89F7DD23'
$checkumType = 'sha256'
$silentArgs = '/verysilent'
$validExitCodes = @(0)

# Get and unzip $env:TEMP
Get-ChocolateyWebFile -PackageName $packageName -FileFullPath "$env:TEMP\RawTherapee_5.2_WinVista_64.zip" -Url64Bit "$url64" -checksum64 "$checksumZip"  -checksumType $checkumType
Get-ChocolateyUnzip -FileFullPath "$env:TEMP\RawTherapee_5.2_WinVista_64.zip" -Destination "$env:TEMP\rawtherapee\temp\"
Install-ChocolateyPackage -PackageName $packageName -FileType "$installerType" -SilentArgs "$silentArgs" -Url64bit "$env:TEMP\rawtherapee\temp\RawTherapee_*_WinVista_64.exe" -checksum $checksum64 -checksumType $checkumType -validExitCodes $validExitCodes

 # To fix
 # Version
 # 64 bits only
 # Delete file