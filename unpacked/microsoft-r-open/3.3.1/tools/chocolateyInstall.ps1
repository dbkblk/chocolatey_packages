$packageName = 'microsoft-r-open'
$installerType = 'MSI'
$url = 'https://mran.revolutionanalytics.com/install/mro/3.3.1/microsoft-r-open-3.3.1.msi'
$checksum = '0A99D2C9AA1465D25D9CB8C0DFFF07E73A13C6746A45FFD03B79C85258599747'
$checkumType = 'sha256'
$silentArgs = '/quiet'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes