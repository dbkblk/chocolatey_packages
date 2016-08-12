$packageName = 'qgis' 
$installerType = 'exe' 
$url = 'http://qgis.org/downloads/QGIS-OSGeo4W-2.16.1-2-Setup-x86.exe'
$url64 = 'http://qgis.org/downloads/QGIS-OSGeo4W-2.16.1-2-Setup-x86_64.exe'
$checksum = '906E9B1B06C6AF2FA4E8BF14B584A056E44016E0A8348495DDD2CDC8AD443043'
$checksum64 = '77E7481E0B2F5794E98710F139692B5F79F41B41845F61489533B8397D07A6C6'
$checkumType = 'sha256'
$silentArgs = '/S' 
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -checksum $checksum -checksumType $checkumType -checksum64 $checksum64 -checksumType64 $checkumType -validExitCodes $validExitCodes
