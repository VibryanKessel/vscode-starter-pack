# Path for the extensions list file
$extensionsList = "../vscode-extensions.txt"

# Get the list of installed extensions
$installedExtensions = code --list-extensions

# Save the extensions list to a file at the root of the repo
$installedExtensions | Out-File -FilePath $extensionsList

# Ensure we're in the root directory of the repo
Set-Location -Path (Resolve-Path "..")

# Fetch the latest version of the file from the remote repository for comparison
git fetch origin
git checkout origin/master -- $extensionsList

# Compare the new extensions with the remote version
$addedExtensions = Compare-Object -ReferenceObject (Get-Content $extensionsList) -DifferenceObject $installedExtensions | Where-Object {$_.SideIndicator -eq "=>"} | ForEach-Object { $_.InputObject }
$removedExtensions = Compare-Object -ReferenceObject (Get-Content $extensionsList) -DifferenceObject $installedExtensions | Where-Object {$_.SideIndicator -eq "<="} | ForEach-Object { $_.InputObject }

# Commit the changes (added or removed extensions)
if ($addedExtensions) {
    Write-Host "Extensions added: $addedExtensions"
    git add $extensionsList
    git commit -m "Added extensions: $addedExtensions"
}

if ($removedExtensions) {
    Write-Host "Extensions removed: $removedExtensions"
    git add $extensionsList
    git commit -m "Removed extensions: $removedExtensions"
}

# Push the changes to the remote repository
git push origin master
