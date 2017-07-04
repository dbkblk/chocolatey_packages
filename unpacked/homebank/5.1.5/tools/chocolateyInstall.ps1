$packageName = 'homebank'
$installerType = 'EXE'
$url = 'http://homebank.free.fr/public/HomeBank-5.1.5-setup.exe'
$checksum = 'D698FB6363AAD79704C5B84E0F308A5DF993DBF3FAC76CEB1711B332797F53C2'
$checkumType = 'sha256'
$silentArgs = '/silent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes