# CrossR dotfiles

### Info

* Editor - Oni2 (GUI) / nvim (TUI)
* Tiling Window Manager (Mac) - Yabai
* Window Manager Status Bar (Mac) - Spacebar
* Keybindings (Mac) - skhd
* Terminal - kitty
* Session Management - tmux

### How to Unpack

#### Linux/macOS

Use GNU Stow to unpack the folders, and it will symlink them to the correct
location. This is achieved with the following command:
`stow config`
By default this will unpack to the folder above the current one, so the
repo should be cloned to the home directory.

#### Windows

For neovim and Oni2, instead just setup folder junctions such that the git
folder is used to store the config in. This is achieved with:

```batch
mklink /J %LOCALAPPDATA%\Oni2 oni2\.config\oni2
mklink /J %LOCALAPPDATA%\nvim neovim\.config\nvim
```

### Other Steps

#### Setup Python for NeoVim with Anaconda:

*   Create a new virtual env with `conda create -n neovim python=3.6`
*   Activate the env and install NeoVim package: `conda activate neovim` and `conda install -c conda-forge neovim`
*   Use `conda env list` to find the location if not known and set `g:python3_host_prog` to this value if needed.

