# Get informations about the package to deploy
$commit = (Get-ChildItem env:APPVEYOR_REPO_COMMIT_MESSAGE).Value
$name = $commit.split('|')[0]
$Dir = Get-ChildItem .\src\$name\ -recurse
$filename = $Dir | where {$_.extension -eq ".nupkg"} | % {$_.Name}

# Register API key and deploy
$api_key = (Get-ChildItem env:CHOCO_API).Value
(choco apikey --key $api_key --source https://push.chocolatey.org/)

Write-Host "#### Deploying package ####"
(choco push -v .\src\$name\$filename)
if ( $LASTEXITCODE -ne 0 )
{
    Write-Error "An error has occured during the deployment."
    Exit(1)
}
Exit(0)