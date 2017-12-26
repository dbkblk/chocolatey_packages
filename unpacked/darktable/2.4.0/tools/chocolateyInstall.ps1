$packageName = 'darktable'
$installerType = 'EXE'
$url = 'https://github.com/darktable-org/darktable/releases/download/release-2.4.0/darktable-2.4.0-win64.exe'
$checksum = '{{Checksum}}'
$checkumType = 'sha256'
$silentArgs = '/S'
$validExitCodes = @(0)
Install-ChocolateyPackage -PackageName "$packageName" -FileType "$installerType" -SilentArgs "$silentArgs" -Url64bit "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes