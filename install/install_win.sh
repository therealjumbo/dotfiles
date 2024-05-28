#!/bin/bash
set -eu

if [ "$OS" != "Windows_NT" ]; then
    echo "This script only works on Windows. Exiting."
    exit 1
fi

WINGET_STD_ARGS_ARR=(--exact --source=winget --scope=machine --accept-package-agreements  --silent)
# rustup's installer is buggy and can't use `--scope=machine`, see
# https://github.com/microsoft/winget-pkgs/issues/153349
WINGET_RUST_ARGS_ARR=(--exact --source=winget --accept-package-agreements  --silent)

# declare an array of package ids
# find these with `winget search foo`
# we can't upgrade Git.Git this way since the upgrade fails if git bash is open
# AutoHotkey.AutoHotkey installer is broken, so you must install it manually
package_ids_arr=(
    7zip.7zip
    Google.Chrome
    Google.GoogleDrive
    KeePassXCTeam.KeePassXC
    Kitware.CMake
    Mozilla.Firefox
    Neovim.Neovim
    Ninja-build.Ninja
    Notepad++.Notepad++
    Python.Python.3.12
    Qalculate.Qalculate
    Rustlang.Rustup
    SumatraPDF.SumatraPDF
    cURL.cURL
    junegunn.fzf
    koalaman.shellcheck
    waterlan.dos2unix
)

# install all packages
for package_id in "${package_ids_arr[@]}"
do
    if ! winget list --exact --id="$package_id" > /dev/null; then
	if [ "$package_id" != "Rustlang.Rustup" ]; then
            winget install --id="$package_id" "${WINGET_STD_ARGS_ARR[@]}"
	else
	    winget install --id="$package_id" "${WINGET_RUST_ARGS_ARR[@]}"
	fi
    fi
done

# since the packages are already installed, we shouldn't need to specify the scope for upgrades
WINGET_UPGRADE_ARGS_ARR=(--exact --source=winget --accept-package-agreements  --silent)

# if the packages were already installed before the above step, they may be out
# of date, so upgrade all packages
for package_id in "${package_ids_arr[@]}"
do
    echo "For $package_id"
    winget upgrade --id="$package_id" "${WINGET_UPGRADE_ARGS_ARR[@]}" || true
    echo
done

# dploy is a python stow replacement that we use instead of stow on windows
pip install --upgrade dploy

# install vim-plug
if ! [ -e "$LOCALAPPDATA/nvim-data/site/autoload/plug.vim" ]; then
    curl -sfLo "$LOCALAPPDATA/nvim-data/site/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
