$packageName = 'microsoft-r-open'
$installerType = 'EXE'
$silentArgs = '/quiet'
$validExitCodes = @(0, 1603, 1626)

Uninstall-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" -validExitCodes $validExitCodes 