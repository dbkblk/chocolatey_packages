$packageName = 'homebank'
$installerType = 'EXE'
$url = '{{url}}'
$checksum = '{{checksum}}'
$checkumType = 'sha256'
$silentArgs = '/verysilent /allusers'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -checksum $checksum -checksumType $checkumType -validExitCodes $validExitCodes
