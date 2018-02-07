$packageName = 'xmind'
$installerType = 'EXE'
$url = 'https://www.xmind.net/xmind/downloads/xmind-8-update6-windows.exe'
$checksum = 'A819E81975B3C478C7DB3CA0858BA8D8DBE3B555DD8D4A0F4C891A7558CA9F7F'
$checkumType = 'sha256'
$silentArgs = '/verysilent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes