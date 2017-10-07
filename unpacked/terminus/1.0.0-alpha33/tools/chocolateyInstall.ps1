$packageName = 'terminus'
$installerType = 'EXE'
$url = 'https://github.com/Eugeny/terminus/releases/download/v1.0.0-alpha.33/terminus-Setup-1.0.0-alpha.33.exe'
$checksum = 'A712C14B9157F57509DD5CB24ACBB534ADED81DC7F11528A7516792AB5ED91D2'
$checkumType = 'sha256'
$silentArgs = '/silent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes