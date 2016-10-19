$packageName = 'homebank'
$installerType = 'EXE'
$url = 'http://homebank.free.fr/public/HomeBank-5.1-setup.exe'
$checksum = '223D333697320DB1F54051852CEFFB63354EFF9E859347D3B14B83FFEE393EC0'
$checkumType = 'sha256'
$silentArgs = '/silent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes