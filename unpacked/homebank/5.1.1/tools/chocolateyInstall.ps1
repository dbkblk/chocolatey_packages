$packageName = 'homebank'
$installerType = 'EXE'
$url = 'http://homebank.free.fr/public/HomeBank-5.1.1-setup.exe'
$checksum = 'E7332C81BA60101F3B5CD1D7920AE6EAF1B3D2D188A5EFE9228C0387A48DE068'
$checkumType = 'sha256'
$silentArgs = '/silent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes