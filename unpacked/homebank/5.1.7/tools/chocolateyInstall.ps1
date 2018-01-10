$packageName = 'homebank'
$installerType = 'EXE'
$url = 'http://homebank.free.fr/public/HomeBank-5.1.7-setup.exe'
$checksum = '1DCA72E8A3AD88B657B2D1F5497180EB0A9BF10C5093AC8DF4D13A2AE85D77E9'
$checkumType = 'sha256'
$silentArgs = '/verysilent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes