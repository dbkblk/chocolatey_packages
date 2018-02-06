$packageName = 'homebank'
$installerType = 'EXE'
$url = '{{DownloadUrl}}'
$checksum = '{{Checksum}}'
$checkumType = 'sha256'
$silentArgs = '/verysilent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes