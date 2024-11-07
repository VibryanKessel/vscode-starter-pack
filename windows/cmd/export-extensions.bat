@echo off

rem Path for the extensions list file
set EXTENSIONS_LIST=..\vscode-extensions.txt

rem Get the list of installed extensions and save it to the extensions file at the root of the repo
for /f "delims=" %%i in ('code --list-extensions') do echo %%i >> %EXTENSIONS_LIST%

rem Ensure we're working in the root directory of the repo
cd /d "%~dp0..\"

rem Fetch the latest version of the file from the remote repository for comparison
git fetch origin
git checkout origin/master -- %EXTENSIONS_LIST%

rem Compare the current extensions with the remote version
for /f %%i in ('comm -13 previous-extensions.txt %EXTENSIONS_LIST%') do set ADDED_EXTENSIONS=%%i
for /f %%i in ('comm -23 previous-extensions.txt %EXTENSIONS_LIST%') do set REMOVED_EXTENSIONS=%%i

rem Commit the changes
if defined ADDED_EXTENSIONS (
    echo Extensions added: %ADDED_EXTENSIONS%
    git add %EXTENSIONS_LIST%
    git commit -m "Added extensions: %ADDED_EXTENSIONS%"
)

if defined REMOVED_EXTENSIONS (
    echo Extensions removed: %REMOVED_EXTENSIONS%
    git add %EXTENSIONS_LIST%
    git commit -m "Removed extensions: %REMOVED_EXTENSIONS%"
)

rem Push changes to the remote repository
git push origin master
