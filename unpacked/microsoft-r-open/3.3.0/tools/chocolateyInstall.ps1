$packageName = 'microsoft-r-open'
$installerType = 'EXE'
$url = 'https://mran.revolutionanalytics.com/install/mro/3.3.0/MRO-3.3.0-win.exe'
$checksum = '6436157EE5C789AF308D0D8F340241F372E1C73DD4F2ED8087E46E72E3131B39'
$checkumType = 'sha256'
$silentArgs = '/silent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes