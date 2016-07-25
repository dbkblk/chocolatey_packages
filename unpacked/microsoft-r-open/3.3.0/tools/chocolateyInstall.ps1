$packageName = 'microsoft-r-open'
$installerType = 'EXE'
$url = 'https://mran.revolutionanalytics.com/install/mro/3.3.0/MRO-3.3.0-win.exe'
$silentArgs = '/silent'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes