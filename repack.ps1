$commit = (Get-Item env:APPVEYOR_PULL_REQUEST_TITLE).Value
Write-Host $commit
# $pkg = 
# $regex = '<version>(.*)<\/version>'

# cd .\pkg

# # Get package list
# $pkg = dir -Directory | Select Name
# $regex = '<version>(.*)<\/version>'

# # Loop packages
# $pkg | ForEach-Object {
#     $name = $_.Name
#     $v_local = Select-String -Path ".\$name\$name.nuspec" -Pattern $regex -AllMatches | % {$_.matches.groups[1]} | % {$_.Value}
#     $v_distant = (choco info -r --version=$v_local $name).split("|")[1]

#     # Avoid to build package if there is a problem.
#     if( [string]::IsNullOrEmpty($v_distant) )
#     {
#         Write-Error "Cannot reach pkg version for $($name). Aborting script."
#         $Host.Exit(1)
#     }

#     # If there is a new version, pack it.
#     If ( $v_local -ne $v_distant ) 
#     {
#         Write-Host "Packing pkg: $($name), local: $($v_local), distant: $($v_distant)"
#         cd $name
#         (choco pack)
#         cd ..
#     }
# }

# #echo $pkg
# cd ..