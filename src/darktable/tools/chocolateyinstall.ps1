$packageName = 'darktable'
$installerType = 'EXE'
$url = '{{url}}'
$checksum = '{{checksum}}'
$checkumType = 'sha256'
$silentArgs = '/S'
$validExitCodes = @(0)
Install-ChocolateyPackage -PackageName "$packageName" -FileType "$installerType" -SilentArgs "$silentArgs" -Url64bit "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes