# WiiManic's dotfiles

### Info

*   Window Manager - i3-gaps
*   Term Emu - urxvt
*   Launcher - Rofi
*   Bar - Polybar
*   Login - LightDM
*   Font - Input
*   Composite Manager - Compton
*   Editor - NeoVim/Oni

### How to Unpack

Use GNU Stow to unpack the folders, and it will symlink them to the correct
location. This is achieved with the following command:
`stow config`
By default this will unpack to the folder above the current one, so the
repo should be cloned to the home directory.

### Other Steps

#### Setup Python for NeoVim with Anaconda:

*   Create a new virtual env with `conda create -n neovim python=3.6`
*   Activate the env and install NeoVim package: `conda activate neovim` and `conda install -c conda-forge neovim`
*   Use `conda env list` to find the location if not known and set `g:python3_host_prog` to this value if needed.

### Sources

Wallpaper - [Reddit User Madisor\_](https://www.reddit.com/user/Madisor_).
