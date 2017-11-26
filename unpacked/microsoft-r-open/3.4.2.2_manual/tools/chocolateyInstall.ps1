$packageName = 'microsoft-r-open'
$installerType = 'EXE'
$url = 'https://mran.blob.core.windows.net/install/mro/3.4.2/microsoft-r-open-3.4.2.exe'
$checksum = '6EE89D8642D3A153E5C4295E5028B6E70F657B1768B10E23CB5D7DA8A9C7552D'
$checkumType = 'sha256'
$silentArgs = '/quiet'
$validExitCodes = @(0, 1603, 1626)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" -Url64Bit "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes