# dotfiles

## Prerequisites

```bash
xcode-select --install
```

Install [Homebrew](https://brew.sh), then:

```bash
brew install git gh stow
gh auth login
```

Generate an SSH key and add it to GitHub if you haven't already:

```bash
ssh-keygen -t ed25519 -C "$(whoami)@$(hostname)"
cat ~/.ssh/id_ed25519.pub
```

Install Oh My Zsh:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install `uc` (Udemy dev CLI) per internal docs.

## Setup

```bash
git clone git@github.com:TunaCuma/.config.git ~/.config
cd ~/.config
git submodule update --init nvim
git config core.hooksPath .githooks
~/.config/bin/dotfiles-install
uc setup
cp ~/.config/uv/uv.toml.example ~/.config/uv/uv.toml
exec zsh
```

Optional — LeetCode:

```bash
git clone git@github.com:TunaCuma/leetcode-home.git ~/.leetcode
cp ~/.leetcode/leetcode.toml.example ~/.leetcode/leetcode.toml
chmod 600 ~/.leetcode/leetcode.toml
git clone git@github.com:TunaCuma/leetcode.git ~/Code/leetcode
ln -sf ~/Code/leetcode/scripts ~/.leetcode/scripts
```
