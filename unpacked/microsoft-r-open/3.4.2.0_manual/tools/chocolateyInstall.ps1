$packageName = 'microsoft-r-open'
$installerType = 'EXE'
$url = 'https://mran.microsoft.com/install/mro/3.4.2/microsoft-r-open-3.4.2.exe'
$checksum = '6ee89d8642d3a153e5c4295e5028b6e70f657b1768b10e23cb5d7da8a9c7552d'
$checkumType = 'sha256'
$silentArgs = '/quiet'
$validExitCodes = @(0, 1603, 1626)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" -Url64Bit "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes