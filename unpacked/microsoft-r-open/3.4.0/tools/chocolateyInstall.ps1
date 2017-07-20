$packageName = 'microsoft-r-open'
$installerType = 'EXE'
$url = 'https://mran.revolutionanalytics.com/install/mro/3.4.0/microsoft-r-open-3.4.0.exe'
$checksum = '2C203421A9779E3F68066A6AB5CBF747C435DD54EC9B8454670BBA7362B62623'
$checkumType = 'sha256'
$silentArgs = '/quiet'
$validExitCodes = @(0, 1603)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes