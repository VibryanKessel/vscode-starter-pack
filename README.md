# VSCode Starter Pack

Welcome to my starter pack for Visual Studio Code! 🚀

This repository contains a file with all my favorite **VSCode** extensions, as well as **scripts** to **export** and **import** these extensions easily, while sorting them by operating system.

## Project structure

The repository is organized as follows:

/vscode-extensions.txt # List of all my VSCode extensions 
/macos/ # Export and import script for macOS 
/windows/ # Export and import script for Windows (CMD and PowerShell) 
/linux/ # Export and import script for Linux


### Extensions file

- `vscode-extensions.txt` contains the complete list of my extensions installed on VSCode.
- This file is updated automatically by the scripts in this repository.

### Scripts

Export and import scripts are separated by **operating system**. This facilitates the installation and management of extensions for each platform.

#### Export extensions

Use the scripts in the folder according to your OS to **export** your extensions from VSCode and save them in a `vscode-extensions.txt` file.

#### Import extensions

The same scripts can be used to **install** all extensions from the `vscode-extensions.txt` file on a new machine or after reinstalling VSCode.

## Instructions for use

### 1. export extensions

To export my extensions to your own system, simply run the script corresponding to your OS.

- **macOS** :  
  Run the `export-extensions.sh` script in the `/macos/` folder (from the terminal):
  
  ``bash
  bash export-extensions.sh

- Windows (PowerShell)**:
Executes the `export-extensions.ps1` script in the `/windows/powershell` folder:
  ``bash
  .\export-extensions.ps1

- Windows (CMD)**:
Executes the `export-extensions.bat` script in the `/windows/cmd` folder:
  
  ``bash
  export-extensions.bat

- Linux** :
Runs the `export-extensions.sh` script in the `/linux/` folder:

  ``bash
  export-extensions.sh


### 2. import extensions
To import extensions on a new machine or a fresh installation of VSCode:

- **macOS** :
Run the `install-extensions.sh` script in the `/macos/` folder:

  ``bash
  install-extensions.sh

- ***Windows (PowerShell)**:
Executes the `install-extensions.ps1` script in the `/windows/powershell` folder:
  ``bash
  .\install-extensions.ps1

- Windows (CMD)**:
Executes the `install-extensions.bat` script in the `/windows/cmd` folder:

  ``bash
  install-extensions.bat

- Linux** :
Runs the `install-extensions.sh` script in the `/linux/` folder:

  ``bash
  install-extensions.sh

## About
This project is personal and intended to make the process of installing and managing VSCode extensions faster and more convenient for me. If you find it useful, 
 don't hesitate to use it for your own projects!
Scripts are written using the native scripting languages of each operating system:

Bash for macOS and Linux.
PowerShell and CMD for Windows.
They are designed to be simple and practical, with no external dependencies.

## Contribution
This project is personal, but if you would like to suggest improvements or corrections, don't hesitate to open an issue or submit a pull request.

## Thanks
This project is entirely based on my personal needs to manage my VSCode extensions. If you find it useful, don't hesitate to use it and contribute to improve it! 😄

✨ Enjoy your VSCode setup! ✨
---
