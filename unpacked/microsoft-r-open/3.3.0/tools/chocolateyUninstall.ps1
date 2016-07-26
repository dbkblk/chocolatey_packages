$packageName = 'microsoft-r-open'
$packageSearch = "Microsoft R Open for Windows *"
$installerType = 'exe'
$silentArgs = '/silent'
$validExitCodes = @(0,3010)  # http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx