# Objects
$browser= New-Object system.net.webclient

# Standard update function
function Prepare-Package {
    param([string]$name, [string]$version, [string]$url, [string]$url64, [string]$Checksum, [string]$Checksum64, [string]$ChecksumZip, [string]$ZipName)

    # Check for essential strings
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
    if (-Not($checksum)) { 
        Write-Error "Prepare-Package: checksum undefined."
        Exit(1)
    }

    # Loading src files
    $nuspec = Get-Content ".\src\$name\$name.nuspec"
    $install = Get-Content ".\src\$name\tools\chocolateyinstall.ps1"

    # Replacing values
    $nuspec = $nuspec -replace "{{PackageVersion}}", $version
    $install = $install -replace "{{Checksum}}", $checksum
    $install = $install -replace "{{DownloadUrl}}", $url

    # Saving file
    $nuspec | Set-Content ".\pkg\$name\$name.nuspec"
    $install | Set-Content ".\pkg\$name\tools\chocolateyinstall.ps1"
}

# Checking Darktable
$page = $browser.DownloadString("https://github.com/darktable-org/darktable/releases/latest")
$name = "darktable"
$v_local = Select-String -Path ".\pkg\$name\$name.nuspec" -Pattern '<version>(.*)<\/version>' -AllMatches | % {$_.matches.groups[1]} | % {$_.Value}
$v_distant = $page | Select-String -Pattern 'release-[\w\.\-]*\/darktable-([\w\.\-]*)-win64.exe' -AllMatches | % {$_.matches.groups[1]} | % {$_.Value}
$url = "https://github.com/darktable-org/darktable/releases/download/release-$($v_distant)/darktable-$($v_distant)-win64.exe"
Write-Host "Checking $($name) $($v_local) (local) / $($v_distant) (distant) at $($url)"

# Updating Darktable
if ( $v_local -ne $v_distant )
{
    # Calculating checksum
    Invoke-WebRequest -Uri $url -Outfile "tmp"
    $checksum = Get-FileHash tmp -Algorithm SHA256 | % {$_.Hash}
    Remove-Item tmp

    # Prepare package
    Prepare-Package -name $name -version $version -url $url -checksum $url

    # Commit into git as darktable|version
}

# Checking 