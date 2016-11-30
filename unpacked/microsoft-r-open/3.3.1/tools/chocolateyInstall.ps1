$packageName = 'microsoft-r-open'
$installerType = 'MSI'
$url = 'https://mran.revolutionanalytics.com/install/mro/3.3.1/microsoft-r-open-3.3.1.msi'
$checksum = 'B366F7188D2DA214CC0D068295DF0FE2902CACE113BAEA65AF8AAF69010E3A27'
$checkumType = 'sha256'
$silentArgs = '/quiet'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes