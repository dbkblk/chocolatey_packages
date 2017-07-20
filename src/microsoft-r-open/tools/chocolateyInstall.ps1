$packageName = 'microsoft-r-open'
$installerType = 'EXE'
$url = '{{DownloadUrl}}'
$checksum = '{{Checksum}}'
$checkumType = 'sha256'
$silentArgs = '/quiet'
$validExitCodes = @(0, 1603)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes