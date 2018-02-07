$packageName = 'rawtherapee'
$installerType = 'EXE'
$url64 = 'http://rawtherapee.com/releases_head/windows/RawTherapee_5.3_WinVista_64.zip'
$checksumZip = '45D3B69A62226F570B6193E6E5CF8AF193D95BED211E310AA8FC4D6780197696'
$checksum64 = '87CCBC19BDE55E859A30D0B6573147AB16039C4A8C7DE785A6FA302430A4A281'
$checkumType = 'sha256'
$silentArgs = '/verysilent'
$validExitCodes = @(0)

# Get and unzip $env:TEMP
Get-ChocolateyWebFile -PackageName $packageName -FileFullPath "$env:TEMP\RawTherapee_5.3_WinVista_64.zip" -Url64Bit "$url64" -checksum64 "$checksumZip"  -checksumType $checkumType
Get-ChocolateyUnzip -FileFullPath "$env:TEMP\RawTherapee_5.3_WinVista_64.zip" -Destination "$env:TEMP\rawtherapee\temp\"
Install-ChocolateyPackage -PackageName $packageName -FileType "$installerType" -SilentArgs "$silentArgs" -Url64bit "$env:TEMP\rawtherapee\temp\RawTherapee_*_WinVista_64.exe" -checksum $checksum64 -checksumType $checkumType -validExitCodes $validExitCodes

 # To fix
 # Version
 # 64 bits only
 # Delete file