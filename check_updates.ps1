# Objects
$browser= New-Object system.net.webclient

# Checking Darktable
$page = $browser.DownloadString("https://github.com/darktable-org/darktable/releases/latest")
$name = "darktable"
$v_local = Select-String -Path ".\pkg\$name\$name.nuspec" -Pattern '<version>(.*)<\/version>' -AllMatches | % {$_.matches.groups[1]} | % {$_.Value}
$v_distant = $page | Select-String -Pattern 'release-[\w\.\-]*\/darktable-([\w\.\-]*)-win64.exe' -AllMatches | % {$_.matches.groups[1]} | % {$_.Value}
$url = "https://github.com/darktable-org/darktable/releases/download/release-$($v_distant)/darktable-$($v_distant)-win64.exe"
Write-Host "Checking $($name) $($v_local) (local) / $($v_distant) (distant) at $($url)"

# Update checking
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