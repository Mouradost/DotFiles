set fish_greeting # Supresses fish greeting message
set TERM "xterm-256color" # Terminal type
set EDITOR "nvim" # $EDITOR use nvim
set VISUAL "nvim" # $VISUAL use nvim

# Default vi key bindings
function fish_user_key_bindings
  fish_vi_key_bindings
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# starship prompt
starship init fish | source

# Aliases

# dnf
alias install "sudo dnf install"
alias update "sudo dnf update && sudo dnf upgrade"

# lsd
alias ls "lsd -a -l --hyperlink=auto --color=auto"

# bat
alias cat "bat"
function batdiff
    git diff --name-only --relative --diff-filter d | xargs bat --diff
end

#fzf
alias fzf "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"

# git
alias gs "git status"
alias ga "git add"
alias gaa "git add --all"
alias gc "git commit"
alias gl "git log --online"
alias gb "git checkout -b"
alias gd "batdiff"

# nvim
alias nv "nvim"

# history
alias hg "history | grep"

# File search
alias sf "fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim"

# Get ip wan
alias ip-wan "curl ipinfo.io"

# Kitty terminal
alias icat "kitty +kitten icat"
alias kssh "kitty +kitten ssh"
alias khg "kitty +kitten hyperlinked_grep"
alias ktransfer "kitty +kitten transfer"

# top as bpytop
alias top "bpytop"

# ranger
alias ranger "ranger --cmd='set show_hidden!'"

# Neofetch
alias nf "neofetch"

# Cloud
alias cloud "onedriver ~/OneDrive/"

