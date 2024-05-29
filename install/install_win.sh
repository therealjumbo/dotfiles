#!/bin/bash
set -eu

this_script_dir="$(dirname "$(readlink -e "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}" )" )"

if [ "$OS" != "Windows_NT" ]; then
    echo "This script only works on Windows. Exiting."
    exit 1
fi

# https://www.msys2.org/docs/filesystem-paths/#automatic-unix-windows-path-conversion
home_test="$(cygpath -u $(readlink -e $HOME))"
profile_test="$(cygpath -u $(readlink -e $USERPROFILE))"
if [ "$home_test" != "$profile_test" ]; then
    echo "The env var: HOME is: '$HOME', the env var: USERPROFILE is: '$USERPROFILE'."
    echo "In order for git bash to work right, these must be the same."
    echo "Fix this by going to 'Edit the system environment variables' in the start menu."
    echo "Add a system-wide environment variable 'HOME' that is set to %USERPROFILE%".
    echo "Alternatively you could set a user specific environment variable 'HOME' set to %USERPROFILE%, or the path therein."
    echo "Then restart bash and try again. Exiting."
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
# TODO: test if we still need this, it should only be needed for some legacy
# nvim plugins
pip install --upgrade pynvim

# install vim-plug
if ! [ -e "$LOCALAPPDATA/nvim-data/site/autoload/plug.vim" ]; then
    curl -sfLo "$LOCALAPPDATA/nvim-data/site/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# now that we have nvim and vim-plug installed, install and update all nvim plugins
nvim -Es -u "${this_script_dir}/../dotfiles/nvim/.config/nvim/init.lua" +PlugInstall +qall
nvim -Es -u "${this_script_dir}/../dotfiles/nvim/.config/nvim/init.lua" +PlugUpdate +qall

# rust-analyzer (the rust LSP implementation) needs the std lib sources
rustup component add rust-src
# the executable rust-analyzer.exe that rustup provides is just a wrapper, we
# still need to install the actual rust-analyzer for our platform
rustup component add rust-analyzer
