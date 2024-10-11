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

dploy stow "$PSScriptRoot\dploy" "$env:HOME"

if ( Test-Path "$env:HOME\.gitconfig" -PathType Leaf ) {
    Move-Item -Path "$env:HOME\.gitconfig" -Destination "$env:HOME\.gitconfig.old" -Force
}
dploy stow "$PSScriptRoot\git" "$HOME"

dploy stow "$PSScriptRoot\nvim\.config" "$env:LOCALAPPDATA"

New-Item -ItemType Directory -Force -Path "$env:HOME\.ssh" | Out-Null
if ( Test-Path "$env:HOME\.ssh\config" -PathType Leaf ) {
    Move-Item -Path "$env:HOME\.ssh\config" -Destination "$env:HOME\.ssh\config.old" -Force
}
dploy stow "$PSScriptRoot\ssh" "$env:HOME\.ssh"
# ~/.ssh/config includes the ~/.ssh/site_config file, so create it if it DNE,
# but we don't want to commit this file to the repo (site specific mods)
if ( !(Test-Path "$env:HOME\.ssh\site_config" -PathType Leaf) ) {
    New-Item -ItemType File -Path "$env:HOME\.ssh\site_config"
}


if ( Test-Path "$env:HOME\.bash_profile" -PathType Leaf ) {
    Move-Item -Path "$env:HOME\.bash_profile" -Destination "$env:HOME\.bash_profile.old" -Force
}
if ( Test-Path "$env:HOME\.bashrc" -PathType Leaf ) {
    Move-Item -Path "$env:HOME\.bashrc" -Destination "$env:HOME\.bashrc.old" -Force
}
dploy stow "$PSScriptRoot\bash" "$env:HOME"

if ( Test-Path "$env:HOME\.inputrc" -PathType Leaf ) {
    Move-Item -Path "$env:HOME\.inputrc" -Destination "$env:HOME\.inputrc.old" -Force
}
dploy stow "$PSScriptRoot\inputrc" "$env:HOME"

# we don't want stow to symlink anything besides the chrome subdir right now so
# create the directory above it first
New-Item -ItemType Directory -Force -Path "$APPDATALOCAL\Mozilla\Firefox\Profiles\default" | Out-Null
dploy stow "$PSScriptRoot\firefox" "$APPDATALOCAL\Mozilla\Firefox\Profiles\default"
