$packageName = 'microsoft-r-open'
$installerType = 'MSI'
$url = 'https://mran.revolutionanalytics.com/install/mro/3.3.2/microsoft-r-open-3.3.2.msi'
$checksum = 'A00A6E4B5A1103ABB5B186E3EEDA8D67825601E76DAC9299BAFFD1BFDF597915'
$checkumType = 'sha256'
$silentArgs = '/quiet'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes