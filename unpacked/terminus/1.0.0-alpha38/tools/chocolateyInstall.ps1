$packageName = 'terminus'
$installerType = 'EXE'
$url = 'https://github.com/Eugeny/terminus/releases/download/v1.0.0-alpha.38/terminus-Setup-1.0.0-alpha.38.exe'
$checksum = '854D5984D3D4BFC0AC3C9777523B0B9B0BBDAE235C7A15EA3638EABF8D124012'
$checkumType = 'sha256'
$silentArgs = '/silent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes