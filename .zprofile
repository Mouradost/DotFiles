# .zshenv → .zprofile → .zshrc → .zlogin → .zlogout

# Add variables to $PATH
export PATH="$PATH:$HOME/.local/bin/"

# Default programs
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export READER="zathura"
export FILE="lf"

# Config file
export ZDOTDIR="$HOME/.config/zsh/"

# Setup pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Setup go
export GOPATH="$HOME/go"

# Setup rust
. "$HOME/.cargo/env"
