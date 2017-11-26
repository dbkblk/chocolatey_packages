$packageName = 'terminus'
$installerType = 'EXE'
$url = 'https://github.com/Eugeny/terminus/releases/download/v1.0.0-alpha.36/terminus-Setup-1.0.0-alpha.36.exe'
$checksum = 'DB6690F11877147846AD89DF14AD4D8D926F743AD9A781EDA9AB3066010DCC19'
$checkumType = 'sha256'
$silentArgs = '/silent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes