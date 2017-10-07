$packageName = 'microsoft-r-open'
$installerType = 'EXE'
$url = 'https://mran.microsoft.com/install/mro/3.4.1/microsoft-r-open-3.4.1.exe'
$checksum = '04F7BE3AAF393937B2EDB536F1A3C7F279145B3AEB6E5EEFDF9BEE1AC137AFC6'
$checkumType = 'sha256'
$silentArgs = '/quiet'
$validExitCodes = @(0, 1603, 1626)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" -Url64Bit "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes