$packageName = 'microsoft-r-open'
$installerType = 'EXE'
$url = 'https://mran.microsoft.com/install/mro/3.4.1/microsoft-r-open-3.4.1.exe'
$checksum = '829B543B4F664142C37453511C157ED39ADCED55216A08753A7ED4154123583D'
$checkumType = 'sha256'
$silentArgs = '/quiet'
$validExitCodes = @(0, 1603)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" -Url64Bit "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" -Url64Bit "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes