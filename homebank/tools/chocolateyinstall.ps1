$packageName = 'homebank'
$installerType = 'EXE'
$url = '{{DownloadUrl}}'
$silentArgs = '/silent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes