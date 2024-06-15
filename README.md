# CrossR dotfiles

### Info

* Editor - nvim (TUI)
* Tiling Window Manager (Mac) - Yabai
* Window Manager Status Bar (Mac) - Sketchybar
* Keybindings (Mac) - skhd
* Terminal - kitty
* Session Management - tmux
* LaTeX configuration
* [ROOT](https://root.cern/) configuration

### How to Unpack

#### Linux/macOS

I previously used GNU Stow to unpack the folders...but if I'm being honest it
only takes a couple of seconds to run the few `ln -s` commands I need, which is
zero dependencies. So just do that in the few locations that matter.

#### Windows

Can use folder junctions such that the config is still kept under version
control, while being in the correct place:

```batch
mklink /J %LOCALAPPDATA%\nvim neovim\.config\nvim
```

