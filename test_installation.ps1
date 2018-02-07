$commit = (Get-ChildItem env:APPVEYOR_REPO_COMMIT_MESSAGE).Value
$name = $commit.split('|')[0]
(choco install .\pkg\$name\$name*.nupkg)