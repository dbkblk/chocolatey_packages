$packageName = 'darktable'
$installerType = 'EXE'
$url = 'https://github.com/darktable-org/darktable/releases/download/release-2.4.1/darktable-2.4.1-win64.exe'
$checksum = '0BE1E0DD8DEC61A7CEA41598C52DB258EDAEE8783C543B4311FA0AC56AB43D2A'
$checkumType = 'sha256'
$silentArgs = '/S'
$validExitCodes = @(0)
Install-ChocolateyPackage -PackageName "$packageName" -FileType "$installerType" -SilentArgs "$silentArgs" -Url64bit "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes