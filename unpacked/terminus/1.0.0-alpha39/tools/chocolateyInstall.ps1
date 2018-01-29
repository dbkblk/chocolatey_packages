$packageName = 'terminus'
$installerType = 'EXE'
$url = 'https://github.com/Eugeny/terminus/releases/download/v1.0.0-alpha.39/terminus-Setup-1.0.0-alpha.39.exe'
$checksum = 'B37728A760D9B4C6CE8FE0ACC952ED35D72C489C66719A8A09D2811E2315807A'
$checkumType = 'sha256'
$silentArgs = '/silent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes