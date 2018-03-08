# Get package information from the commit name
$commit = (Get-ChildItem env:APPVEYOR_REPO_COMMIT_MESSAGE).Value

# Do not build if the commit is for configuration
if ( $commit.Contains('config:') )
{
    Write-Error "This commit is a configuration update. No need to rebuild."
    Exit(1)
}

$name = $commit.split('|')[0]
$v_commit = $commit.split('|')[1]
Write-Host "#### Processing $($name) v$($v_commit) ####"

cd .\src\$name\

# Source the local informations (url and version)
. .\latest.ps1

# Check local and distant version
$regex = '<version>(.*)<\/version>'
$v_distant = (choco info -r --pre --version=$version $name).split("|")[1]

# Avoid to build package if there is a problem.
if( [string]::IsNullOrEmpty($v_distant) )
{
    Write-Error "Cannot reach pkg version for $($name). Aborting script."
    Exit(1)
}


# Prepare the package and build
# Modifying the sources files (in a VM)
if (-Not($name)) { 
    Write-Error "Prepare-Package: Name undefined."
    Exit(1)
}
if (-Not($version)) { 
    Write-Error "Prepare-Package: Version undefined."
    Exit(1)
}
if (-Not($url)) { 
    Write-Error "Prepare-Package: URL undefined."
    Exit(1)
}

# Calculate checksums
Invoke-WebRequest -Uri $url -Outfile "tmp"
$checksum = Get-FileHash tmp -Algorithm SHA256 | % {$_.Hash}

# Writing debug messages
Write-Host "[DEBUG] pkg: $($name), version: $($version), url: $($url), checksum: $($checksum)"

# Special cases checksums (ex: RawTherapee)
if ( $name -eq "rawtherapee") 
{
    (7z x -y tmp)
    $checksumExe = Get-FileHash "RawTherapee_$($version)_WinVista_64.exe" -Algorithm SHA256 | % {$_.Hash}
    Write-Host "[DEBUG] Special package. checksumExe: $($checksumExe)."
}



# Loading src files
$nuspec = Get-Content ".\$name.nuspec"
$install = Get-Content ".\tools\chocolateyinstall.ps1"

# Replacing values
$nuspec = $nuspec -replace "{{version}}", $version
$install = $install -replace "{{checksum}}", $checksum
if ( $checksumExe ) { $install = $install -replace "{{checksumExe}}", $checksumExe }
$install = $install -replace "{{url}}", $url

# Saving file
$nuspec | Set-Content ".\$name.nuspec"
$install | Set-Content ".\tools\chocolateyinstall.ps1"

# Debug
Write-Host "[DEBUG] #### FILES CONTENT ####"
$nuspec
$install

# Pack it
(choco pack)

# Return to base directory
cd ..\..

Exit(0)