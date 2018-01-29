$packageName = 'microsoft-r-open'
$installerType = 'EXE'
$url = 'https://mran.blob.core.windows.net/install/mro/3.4.3/microsoft-r-open-3.4.3.exe'
$checksum = 'C8D50172EC8173CEF503A616F9EF310DC5B274AC045EA71B9C8AED248098CBDD'
$checkumType = 'sha256'
$silentArgs = '/quiet'
$validExitCodes = @(0, 1603, 1626)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" -Url64Bit "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes