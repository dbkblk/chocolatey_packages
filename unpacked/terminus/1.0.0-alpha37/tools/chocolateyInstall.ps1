$packageName = 'terminus'
$installerType = 'EXE'
$url = 'https://github.com/Eugeny/terminus/releases/download/v1.0.0-alpha.37/terminus-Setup-1.0.0-alpha.37.exe'
$checksum = '2441B0FD8BFB21D397C92664C1F0AFF5749B58E795C5A415A240881EFF32A86B'
$checkumType = 'sha256'
$silentArgs = '/silent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes