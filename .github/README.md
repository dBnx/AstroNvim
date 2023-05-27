# AstroNvim User Configuration Example

A user configuration template for [AstroNvim](https://github.com/AstroNvim/AstroNvim). The main focus lies on the development with
- C/modern C++
- Rust
- Python3
- (System)Verilog
- LaTeX


## 🛠️ Installation

#### Installing [neovim](https://neovim.io)

Neovim, as well as the used programs can be installed with:
```shell
yay -S neovim npm git lazygit gdu btm fzf
yay -S --asdeps wl-clipboard python-neovim
```
`npm` is needed to install certain LSP's using `mason`. The cli tools `lazygit` and `gdu` can be opened
directly within the editor and are not needed. Furthermore wayland is assumed - X11 needs another cli
clipboard interface like `xclip`.


#### Installing [AstroNvim](https://github.com/AstroNvim/AstroNvim) and the custom config

- Backup your `neovim` configuration & install `astronvim`:

```sh
mv -v ~/.config/nvim ~/.config/nvim.bak; \
  git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
```

- Get this config:

```sh
git clone --depth 1 git@github.com:dBnx/AstroNvimConfig.git ~/.config/nvim/lua/user
```

- Start `neovim` - all plugins will be automatically installed:

```sh
nvim
```


#### All in one:

```shell
mv -v ~/.config/nvim ~/.config/nvim.bak; \
  git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim \
  && git clone --depth 1 git@github.com:dBnx/AstroNvimConfig.git ~/.config/nvim/lua/user \
  && nvim
```

#### Missing dictionary files

In some circumstances neovim does not automatically download dictionary files. They can be
manually added like this:
```shell
mkdir -p $HOME/.config/nvim/spell && \
  wget 'http://ftp.vim.org/pub/vim/runtime/spell/de.utf-8.spl' $HOME/.config/nvim/spell/
```

#### 🧹 Clean preexisting `neovim` folders

Preexisting configurations can leave fragments behind, that result in weird errors and can be 
renamed using:

```shell
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

## ⚙️ Usage

- List of the default mappings provided by `AstroNvim`: https://astronvim.com/Basic%20Usage/mappings
