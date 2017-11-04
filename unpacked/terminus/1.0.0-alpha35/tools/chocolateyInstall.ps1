$packageName = 'terminus'
$installerType = 'EXE'
$url = 'https://github.com/Eugeny/terminus/releases/download/v1.0.0-alpha.35/terminus-Setup-1.0.0-alpha.35.exe'
$checksum = '4A4C81BF3A45EBE0B481FD2E17E95627EEA46CDDD34C971139EC225DAF2CA823'
$checkumType = 'sha256'
$silentArgs = '/silent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes