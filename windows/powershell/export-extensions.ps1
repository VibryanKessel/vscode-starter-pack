# Export VSCode extensions to a file
$extensionsList = "vscode-extensions.txt"

# Get the list of installed extensions
$installedExtensions = code --list-extensions

# Save the extensions list to a file
$installedExtensions | Out-File -FilePath $extensionsList

# Check for changes in extensions
if (Test-Path "previous-extensions.txt") {
    $previousExtensions = Get-Content "previous-extensions.txt"
    
    # Compare the old and new extensions
    $addedExtensions = Compare-Object -ReferenceObject $previousExtensions -DifferenceObject $installedExtensions | Where-Object {$_.SideIndicator -eq "=>"} | ForEach-Object { $_.InputObject }
    $removedExtensions = Compare-Object -ReferenceObject $previousExtensions -DifferenceObject $installedExtensions | Where-Object {$_.SideIndicator -eq "<="} | ForEach-Object { $_.InputObject }

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
} else {
    Write-Host "No previous extensions file found. Skipping comparison."
}

# Push changes to the remote repository
git push origin master

# Update previous extensions file
Copy-Item -Path $extensionsList -Destination "previous-extensions.txt"
