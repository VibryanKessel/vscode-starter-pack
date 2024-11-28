@echo off

rem Import extensions from the list in vscode-extensions.txt

set EXTENSIONS_LIST=../../vscode-extensions.txt

rem Check if the file exists
if not exist %EXTENSIONS_LIST% (
    echo %EXTENSIONS_LIST% does not exist. Exiting.
    exit /b
)

rem Install extensions from the list
for /f "delims=" %%i in (%EXTENSIONS_LIST%) do (
    if not "%%i"=="" (
        echo Installing extension: %%i
        code --install-extension %%i
    )
)
