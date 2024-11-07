@echo off

rem Export VSCode extensions to a file
set EXTENSIONS_LIST=vscode-extensions.txt

rem Get the list of installed extensions
for /f "delims=" %%i in ('code --list-extensions') do echo %%i >> %EXTENSIONS_LIST%

rem Check for changes in extensions
if exist previous-extensions.txt (
    rem Compare the old and new extensions
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
) else (
    echo No previous extensions file found. Skipping comparison.
)

rem Push changes to the remote repository
git push origin master

rem Update previous extensions file
copy %EXTENSIONS_LIST% previous-extensions.txt
