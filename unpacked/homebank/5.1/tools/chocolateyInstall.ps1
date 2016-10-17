$packageName = 'homebank'
$installerType = 'EXE'
$url = 'http://homebank.free.fr/public/HomeBank-5.1-setup.exe'
$checksum = '2E12620CEC103CCF167A57475C2BE5AA13EA8518027E93E1ACB16402E961CA3D'
$checkumType = 'sha256'
$silentArgs = '/silent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes