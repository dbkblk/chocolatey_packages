$packageName = 'terminus'
$installerType = 'EXE'
$url = 'https://github.com/Eugeny/terminus/releases/download/v1.0.0-alpha.34/terminus-Setup-1.0.0-alpha.34.exe'
$checksum = 'A42ECC73085F0F21C3FBE428C99176A1769D21EB06952976F7A9D744F8DB0EC7'
$checkumType = 'sha256'
$silentArgs = '/silent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes