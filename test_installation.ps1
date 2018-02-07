# Get informations about the package to test
$commit = (Get-ChildItem env:APPVEYOR_REPO_COMMIT_MESSAGE).Value
$name = $commit.split('|')[0]
$Dir = Get-ChildItem .\pkg\$name\ -recurse
$filename = $Dir | where {$_.extension -eq ".nupkg"} | % {$_.Name}

# Installation test
Write-Host "#### Testing installation ####"
(choco install -v .\pkg\$name\$filename)
if ( $LASTEXITCODE -ne 0 )
{
    Write-Error "An error has occured during the installation."
    Exit(1)
}

# Uninstallation test
Write-Host "#### Testing uninstallation ####"
(choco uninstall -v $name)
if ( $LASTEXITCODE -ne 0 )
{
    Write-Error "An error has occured during the uninstallation."
    Exit(1)
}
Exit(0)