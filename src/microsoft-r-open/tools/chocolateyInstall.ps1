$packageName = 'microsoft-r-open'
$installerType = 'EXE'
$url = '{{url}}'
$checksum = '{{checksum}}'
$checkumType = 'sha256'
$silentArgs = '/quiet'
$validExitCodes = @(0, 1603, 1626)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" -Url64Bit "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes