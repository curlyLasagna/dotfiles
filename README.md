# Dots

My Linux dotfiles.
I plan to distro hop for fun (within a VM) so I have to pack my dots.

As much as I love the minimalist aesthetic of not using a desktop environment, I have other priorities in life. The fact that I'm currently using Arch doesn't help, but Arch was the last distro I used before I bought my first Macbook.

If I really value my time, you could argue I should just use Windows, but I find that OS genuinely hard to understand. I'm most comfortable with MacOS, but due to bad financial decisions, I had to sell my MacBook.

### TODOS

- [ ] Script for Doom Emacs installation
- [ ] Script for zim installation
- [ ] Script to add fzf

## Applications used

### Terminal

#### zsh

I use [zim](https://zimfw.sh/) as my framework of choice. Out of the box experience is decent.

##### Zim installation

``` sh
wget -nv -O - https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
```

#### tmux

I use [tpm](https://github.com/tmux-plugins/tpm) to manage tmux plugins. I like these plugins:
- [pain control](https://github.com/tmux-plugins/tmux-pain-control)
  - Comfortable navigation
- [catppuccin](https://github.com/catppuccin/tmux)
  - Pretty theme
  
#### Starship

Cross platform shell prompt so I can jump back into Fish if I really wanted to without writing the same config twice.
  
### GUI apps

#### Emacs

Doom Emacs config. The only editor holding me back from using VSCode full time.
To install Doom Emacs, run the following 2 commands

``` sh
# Clone the repository
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs

# Run the installer script
~/.config/emacs/bin/doom install
```

You'll want to add `.~/config/emacs/bin/` to your path
