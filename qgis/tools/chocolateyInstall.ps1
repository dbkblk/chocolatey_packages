$packageName = 'qgis' 
$installerType = 'exe' 
$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrl64}}'
$checksum = '{{Checksum}}'
$checksum64 = '{{Checksum64}}'
$checkumType = 'sha256'
$silentArgs = '/S' 
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -checksum $checksum -checksumType $checkumType -checksum64 $checksum64 -checksumType64 $checkumType -validExitCodes $validExitCodes
