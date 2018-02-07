# Get informations about the package to deploy
$commit = (Get-ChildItem env:APPVEYOR_REPO_COMMIT_MESSAGE).Value
$api_key = (Get-ChildItem env:CHOCO_API).Value
$name = $commit.split('|')[0]
$Dir = Get-ChildItem .\pkg\$name\ -recurse
$filename = $Dir | where {$_.extension -eq ".nupkg"} | % {$_.Name}
Write-Host $api_key