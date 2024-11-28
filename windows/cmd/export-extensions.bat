@echo off

rem Path for the extensions list file
set EXTENSIONS_LIST=..\..\vscode-extensions.txt

rem Ensure we're working in the root directory of the repo
cd /d "%~dp0..\"

rem Check if the extensions file already exists
if not exist %EXTENSIONS_LIST% (
    echo Creating new vscode-extensions.txt file.
    rem If it doesn't exist, create it and write the list of installed extensions
    for /f "delims=" %%i in ('code --list-extensions') do echo %%i >> %EXTENSIONS_LIST%
) else (
    rem If the file exists, update it with the current extensions list
    > %EXTENSIONS_LIST% (
        for /f "delims=" %%i in ('code --list-extensions') do echo %%i
    )
)

rem Fetch the latest version of the file from the remote repository for comparison
git fetch origin
git checkout origin/master -- %EXTENSIONS_LIST%

rem Initialize variables for added and removed extensions
set ADDED_EXTENSIONS=
set REMOVED_EXTENSIONS=

rem Compare current extensions with the one from the repo using findstr
for /f "delims=" %%i in (%EXTENSIONS_LIST%) do (
    rem Check if the extension is already in the existing extensions file from the repo
    findstr /i /x "%%i" %EXTENSIONS_LIST% > nul
    if errorlevel 1 (
        set ADDED_EXTENSIONS=!ADDED_EXTENSIONS! %%i
    )
)

rem Compare for removed extensions by checking the repo extensions list against the local one
for /f "delims=" %%i in (%EXTENSIONS_LIST%) do (
    findstr /i /x "%%i" %EXTENSIONS_LIST% > nul
    if errorlevel 1 (
        set REMOVED_EXTENSIONS=!REMOVED_EXTENSIONS! %%i
    )
)

rem Commit the changes
if defined ADDED_EXTENSIONS (
    echo Extensions added: !ADDED_EXTENSIONS!
    git add %EXTENSIONS_LIST%
    git commit -m "Added extensions: !ADDED_EXTENSIONS!"
)

if defined REMOVED_EXTENSIONS (
    echo Extensions removed: !REMOVED_EXTENSIONS!
    git add %EXTENSIONS_LIST%
    git commit -m "Removed extensions: !REMOVED_EXTENSIONS!"
)

rem Push changes to the remote repository
git push origin master
