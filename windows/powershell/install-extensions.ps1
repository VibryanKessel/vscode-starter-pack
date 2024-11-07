# Import extensions from the list in vscode-extensions.txt

$extensionsList = "vscode-extensions.txt"

# Check if the file exists
if (-Not (Test-Path $extensionsList)) {
    Write-Host "$extensionsList does not exist. Exiting."
    exit
}

# Read the extensions from the list and install them
Get-Content $extensionsList | ForEach-Object {
    if ($_ -ne "") {
        Write-Host "Installing extension: $_"
        code --install-extension $_
    }
}
