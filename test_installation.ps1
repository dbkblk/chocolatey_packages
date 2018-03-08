# Get informations about the package to test
$commit = (Get-ChildItem env:APPVEYOR_REPO_COMMIT_MESSAGE).Value
$name = $commit.split('|')[0]
$Dir = Get-ChildItem .\src\$name\ -recurse
$filename = $Dir | where {$_.extension -eq ".nupkg"} | % {$_.Name}

# Installation test
Write-Host "#### Testing installation ####"
(choco install -v .\src\$name\$filename)
if ( $LASTEXITCODE -ne 0 )
{
    Write-Error "An error has occured during the installation."
    Exit(1)
}

# Uninstallation test (bypass test for MRO. Avoid to create a uninstaller because it exits with 1626 instead of 0.)
# if (-Not( $name = "microsoft-r-open" ))
# {
#     Write-Host "#### Testing uninstallation ####"
#     (choco uninstall -v $name)
#     if ( $LASTEXITCODE -ne 0 )
#     {
#         Write-Error "An error has occured during the uninstallation."
#         Exit(1)
#     }
# }
Write-Host "#### Testing uninstallation ####"
(choco uninstall -v $name)
if ( ($LASTEXITCODE -eq 0) -or ($LASTEXITCODE -eq 1626) )
{
    Exit(0)
}

Write-Error "An error has occured during the uninstallation."
Exit(1)
