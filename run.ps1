#Requires -RunAsAdministrator

Write-Host "######## Starting $PSCommandPath"

if ($env:OS -ne "Windows_NT") {
    Write-Host "OS is: $env:OS, This script only works on Windows. Exiting."
    exit 1
}

if ($env:HOME -ne $env:USERPROFILE ) {
    Write-Host "The env var 'HOME' is: '$env:HOME', the env var: 'USERPROFILE' is: '$env:USERPROFILE'."
    Write-Host "In order for things to work right, these must be the same."
    Write-Host "Fix this by going to 'Edit the system environment variables' in the start menu."
    Write-Host "Add a system-wide environment variable 'HOME' that is set to %USERPROFILE%".
    Write-Host "Alternatively you could set a user specific environment variable 'HOME' set to %USERPROFILE%, or the path therein."
    Write-Host "Then restart powershell and try again. Exiting."
    exit 1
}

Invoke-Expression -Command $PSScriptRoot/install/install.ps1
Invoke-Expression -Command $PSScriptRoot/setup/setup.ps1
Invoke-Expression -Command $PSScriptRoot/dotfiles/dotfiles.ps1
