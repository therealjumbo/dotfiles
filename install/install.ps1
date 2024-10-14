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

# Define package IDs
$package_ids = @(
    "GnuWin32.Tree",
    "Microsoft.WindowsTerminal",
    "7zip.7zip",
    "Google.Chrome",
    "Google.GoogleDrive",
    "KeePassXCTeam.KeePassXC",
    "Kitware.CMake",
    "Mozilla.Firefox",
    "Neovim.Neovim",
    "Ninja-build.Ninja",
    "Notepad++.Notepad++",
    "Python.Python.3.12",
    "Qalculate.Qalculate",
    "Rustlang.Rustup",  # Special handling needed
    "SumatraPDF.SumatraPDF",
    "cURL.cURL",
    "junegunn.fzf",
    "koalaman.shellcheck",
    "waterlan.dos2unix",
    "Git.Git",
    "VideoLAN.VLC",
    "PDFArranger.PDFArranger"
)

# Define winget install args
$winget_install_args = '--exact --source winget --scope Machine --accept-package-agreements --silent'
$winget_install_rust_args = '--exact --source winget --accept-package-agreements --silent'

# checking if each package is installed one-by-one via `winget list --exact
# --id $package_id` is really slow. Instead, output all installed packages to a
# variable, and then just search that string for each package.
$winget_installed_list = winget list --disable-interactivity

# Install packages
foreach ($package_id in $package_ids) {
    $find_package = Select-String -InputObject $winget_installed_list -Pattern $package_id -SimpleMatch -Quiet

    if ($find_package -ne "True") {
        Write-Host "Installing $package_id."
        if ($package_id -ne "Rustlang.Rustup") {
            $process = Start-Process -FilePath "winget.exe" -NoNewWindow -Passthru -Wait `
            -ArgumentList "install $winget_install_args --id $package_id"
            
            if ($process.ExitCode -ne 0) {
                Write-Host "Installation of $package_id failed, exiting."
                exit 1
            }
        } else {
            $process = Start-Process -FilePath "winget.exe" -NoNewWindow -Passthru -Wait `
            -ArgumentList "install $winget_install_rust_args --id $package_id"

            if ($process.ExitCode -ne 0) {
                Write-Host "Installation of $package_id failed, exiting."
                exit 1
            }
        }
    } else {
        Write-Host "$package_id already installed, skipping install."
    }
}

# define winget upgrade args
$winget_upgrade_args = '--exact --source winget --accept-package-agreements --silent'

# upgrade packages
foreach ($package_id in $package_ids) {
    Write-Host "Checking for update for package: $package_id"
    Start-Process -FilePath "winget.exe" -NoNewWindow -Wait `
    -ArgumentList "upgrade $winget_upgrade_args --id $package_id"
}

# Install dploy, alternative to GNU stow in MS Windows
pip install --upgrade dploy

# Running "rustup component add ..." directly, leads to an error that exits the
# script, even when the command is successful, we can suppress that by simply
# running it through "Start-Process". If it's already installed, rustup will do
# the right thing, so we don't need to test for that either.
$rust_components = 'rust-src rust-analyzer rust-docs rustfmt clippy'
Start-Process -FilePath "rustup.exe" -NoNewWindow -Wait -ArgumentList "component add $rust_components"
