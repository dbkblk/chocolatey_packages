$packageName = 'terminus'
$installerType = 'EXE'
$url = 'https://github.com/Eugeny/terminus/releases/download/v1.0.0-alpha.27/Terminus.Setup.1.0.0-alpha.27.exe'
$checksum = 'A9BA08CB89F3F9A1601B9551CDD9C1FC78D914F2916EBA7899281755E1506679'
$checkumType = 'sha256'
$silentArgs = '/silent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes