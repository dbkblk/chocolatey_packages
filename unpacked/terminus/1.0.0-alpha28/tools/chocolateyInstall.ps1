$packageName = 'terminus'
$installerType = 'EXE'
$url = 'https://github.com/Eugeny/terminus/releases/download/v1.0.0-alpha.28/Terminus.Setup.1.0.0-alpha.28.exe'
$checksum = 'F1C2A9B247995996D7135BF41659A32CE1ECC2B851C9FC847226030322F678FF'
$checkumType = 'sha256'
$silentArgs = '/silent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes