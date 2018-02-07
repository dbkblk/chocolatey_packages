# Get package information from the commit name
$commit = (Get-ChildItem env:APPVEYOR_REPO_COMMIT_MESSAGE).Value

# Do not build if the commit is for configuration
if ( $commit.Contains('config:') )
{
    Write-Error "This commit is a configuration update. No need to rebuild."
    Exit(1)
}

$name = $commit.split('|')[0]
$version = $commit.split('|')[1]
Write-Host "#### Processing $($name) v$($version) ####"

cd .\pkg

# Check local and distant version
$regex = '<version>(.*)<\/version>'
$v_local = Select-String -Path ".\$name\$name.nuspec" -Pattern $regex -AllMatches | % {$_.matches.groups[1]} | % {$_.Value}
$v_distant = (choco info -r --version=$v_local $name).split("|")[1]

# Avoid to build package if there is a problem.
if( [string]::IsNullOrEmpty($v_distant) )
{
    Write-Error "Cannot reach pkg version for $($name). Aborting script."
    Exit(1)
}

# Package
cd $name
(choco pack)
cd ..\..

Exit(0)