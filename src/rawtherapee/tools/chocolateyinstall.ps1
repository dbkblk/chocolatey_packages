$packageName = 'rawtherapee'
$installerType = 'EXE'
$url64 = '{{url}}'
$checksumZip = '{{checksum}}'
$checksum64 = '{{checksumExe}}'
$checkumType = 'sha256'
$silentArgs = '/verysilent'
$validExitCodes = @(0)

# Get and unzip $env:TEMP
Get-ChocolateyWebFile -PackageName $packageName -FileFullPath "$env:TEMP\{{ZipName}}.zip" -Url64Bit "$url64" -checksum64 "$checksumZip"  -checksumType $checkumType
Get-ChocolateyUnzip -FileFullPath "$env:TEMP\{{ZipName}}.zip" -Destination "$env:TEMP\rawtherapee\temp\"
Install-ChocolateyPackage -PackageName $packageName -FileType "$installerType" -SilentArgs "$silentArgs" -Url64bit "$env:TEMP\rawtherapee\temp\RawTherapee_*_WinVista_64.exe" -checksum $checksum64 -checksumType $checkumType -validExitCodes $validExitCodes

 # To fix
 # Version
 # 64 bits only
 # Delete file