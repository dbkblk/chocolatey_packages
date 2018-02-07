# Get informations about the package to deploy
$commit = (Get-ChildItem env:APPVEYOR_REPO_COMMIT_MESSAGE).Value
$name = $commit.split('|')[0]
$Dir = Get-ChildItem .\pkg\$name\ -recurse
$filename = $Dir | where {$_.extension -eq ".nupkg"} | % {$_.Name}

# Register API key and deploy
$api_key = (Get-ChildItem env:CHOCO_API).Value
(choco apikey --key $api_key --source https://push.chocolatey.org/)
(choco push -v .\pkg\$name\$filename)