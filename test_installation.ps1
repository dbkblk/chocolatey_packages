$commit = (Get-ChildItem env:APPVEYOR_REPO_COMMIT_MESSAGE).Value
$name = $commit.split('|')[0]
$Dir = Get-ChildItem .\pkg\$name\ -recurse
$filename = $Dir | where {$_.extension -eq ".nupkg"} | % {$_.Name}
(choco install .\pkg\$name\$filename)
(choco uninstall $name)