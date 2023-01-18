#!/bin/bash

PACKAGES=('curl' 'git' 'grep' 'ranger' 'pandoc' 'alacritty' 'neovim' 'neofetch')
PACKAGES_WRITING=('zathura' 'zathura-cb' 'zathura-djvu' 'zathura-pdf-poppler' 'zathura-ps' 'texlive')
PACKAGES_WM=('leftwm' 'polybar' 'picom' 'rofi' 'feh')
PACKAGES_DEV=('make' 'g++' 'cmake' 'libsqlite' 'hdf5-libdev' 'mingw64-gcc' 'mingw32-gcc')
PACKAGES_EXTRA=('lsd' 'bat' 'bpytop')

RESTORE=$(echo -en '\033[0m')
BLACK=$(echo -en '\033[00;30m')
RED=$(echo -en '\033[00;31m')
GREEN=$(echo -en '\033[00;32m')
LYELLOW=$(echo -en '\033[00;33m')
BLUE=$(echo -en '\033[00;34m')
MAGENTA=$(echo -en '\033[00;35m')
PURPLE=$(echo -en '\033[00;35m')
CYAN=$(echo -en '\033[00;36m')
LGRAY=$(echo -en '\033[00;37m')
LRED=$(echo -en '\033[01;31m')
LGREEN=$(echo -en '\033[01;32m')
YELLOW=$(echo -en '\033[01;33m')
LBLUE=$(echo -en '\033[01;34m')
LMAGENTA=$(echo -en '\033[01;35m')
LPURPLE=$(echo -en '\033[01;35m')
LCYAN=$(echo -en '\033[01;36m')
WHITE=$(echo -en '\033[01;37m')
LBLACK=$(echo -en '\033[00;90m')

# current_distro=$(cat /etc/*-release | grep "^ID=" | cut -f"2" -d"=")
current_distro=$(awk -F= '$1 == "ID" { print $2 }' /etc/*-release)
close_distro=$(awk -F= '$1 == "ID_LIKE" { print $2 }' /etc/*-release)

declare -A choices

echo "$WHITE------------------------------------------------------------------------$RESTORE"
echo "$BLACK------------------------------------------------------------------------$RESTORE"
echo "$LGREEN=>$RESTORE Detected $GREEN$current_distro$RESTORE $MAGENTA$close_distro$RESTORE"
echo "$LBLACK------------------------------------------------------------------------$RESTORE"
echo "$LMAGENTA------------------------------------------------------------------------$RESTORE"

user_pref() {
  echo "Packages useful for working on the terminal are$LCYAN ${PACKAGES_EXTRA[*]} $RESTORE"
  read -rp "Install? (y/N): " 'choices[extra_packages]' 

  echo "Packages useful for a tiling window manager are$LCYAN ${PACKAGES_WM[*]} $RESTORE"
  read -rp "Install? (y/N): " 'choices[wm_packages]' 
  
  echo "Packages useful for developement are$LCYAN ${PACKAGES_DEV[*]} $RESTORE"
  read -rp "Install? (y/N): " 'choices[dev_packages]' 
  
  echo "Packages useful for writing are$LCYAN ${PACKAGES_WRITING[*]} $RESTORE"
  read -rp "Install? (y/N): " 'choices[writing_packages]' 

  echo "Specify a version of python that you want to install (leave it empty to not install python)"
  read -rp "Install Python Version? : " 'choices[python_version]' 

  echo "Install the following python packages$LCYAN"
  cmd < requirement.txt
  read -rp "$RESTORE Install essential packages for python? (y/N): " 'choices[python_packages]' 

}

install_prompt() {
  echo "$PURPLE----------------------------Installing$LPURPLE StarShip Prompt-------------------$RESTORE"
  curl -sS https://starship.rs/install.sh | sh
}

install_python() {
  echo "$YELLOW----------------------------Installing$LYELLOW Python----------------------------$RESTORE"
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  cd ~/.pyenv && src/configure && make -C src

  if [[ ${choices[python_version]} != [nN] || ${choices[python_version]} != [nN][oO] || -n ${choices[python_version]} ]]; then
    "cd $HOME/GitHub/DotFiles || return"
    pyenv install -r requirements.txt
  fi

  if [[ ${choices[python_packages]} == [yY] || ${choices[python_packages]} == [yY][eE][sS] ]]; then
    pip install -r "${choices[python_packages]}"
  fi

}

install_rust() {
  echo "$RED----------------------------Installing$LRED Rust------------------------------------$RESTORE"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  rustup component add rustfmt
  rustup component add clippy
  rustup component add rust-analyzer
  ln -s "$(rustup which --toolchain stable rust-analyzer)" "$HOME/.cargo/bin/rust-analyzer"
  ln -s "$(rustup which --toolchain stable rust-analyzer)" "$HOME/.local/bin/rust-analyzer"
  rustup update
}

install_leftwm_git() {
  echo "$LGRAY----------------------------Installing LeftWM------------------------------------$RESTORE"
  mkdir -p "$HOME/GitHub"
  "cd $HOME/GitHub || return"
  git clone https://github.com/leftwm/leftwm.git
  "cd leftwm || return"
  cargo build --profile optimized
  sudo install -s -Dm755 ./target/release/leftwm ./target/release/leftwm-worker ./target/release/lefthk-worker ./target/release/leftwm-state ./target/release/leftwm-check ./target/release/leftwm-command -t /usr/bin
  sudo cp leftwm.desktop /usr/share/xsessions/
}

install_leftwm() {
  echo "$BLUE----------------------------Installing DotFiles------------------------------------$RESTORE"
  mkdir -p "$HOME/GitHub/leftwm"
  "cd $HOME/GitHub/leftwm || return"
  cargo install leftwm
  sudo cp ./leftwm.desktop /usr/share/xsessions
}

install_dotfiles() {
  echo "$BLUE----------------------------Installing DotFiles------------------------------------$RESTORE"
  mkdir -p "$HOME/GitHub"
  "cd $HOME/GitHub || return"
  git clone git@github.com:Mouradost/DotFiles.git
  "cd DotFiles || return"
  mkdir -p "$HOME/.bashrc.d/"
  mkdir -p "$HOME/.config/"
  cp -r .bashrc.d/* "$HOME/.bashrc.d/"
  cp -r .config/* "$HOME/.config/"
}

installer() {
  echo "$LGREEN=>$RESTORE Installing the following packages $CYAN ${PACKAGES[*]} $RESTORE"
  $1 "${PACKAGES[@]}"

  echo "$BLUE----------------------------Installing DotFiles-----------------------------------------$RESTORE"
  install_dotfiles

  user_pref

  if [[ ${choices[dev_packages]} == [yY] || ${choices[dev_packages]} == [yY][eE][sS] ]]; then
    echo "$BLUE----------------------------Installing dev_packages---------------------------------------$RESTORE"
    $1 "${PACKAGES_DEV[@]}"
  fi

  if [[ ${choices[wm_packages]} == [yY] || ${choices[wm_packages]} == [yY][eE][sS] ]]; then
    echo "$BLUE----------------------------Installing wm_packages----------------------------------------$RESTORE"
    $1 "${PACKAGES_WM[@]}"
  fi
  
  if [[ ${choices[extra_packages]} == [yY] || ${choices[extra_packages]} == [yY][eE][sS] ]]; then
    echo "$BLUE----------------------------Installing extra_packages-------------------------------------$RESTORE"
    $1 "${PACKAGES_EXTRA[@]}"
  fi

  if [[ ${choices[writing_packages]} == [yY] || ${choices[writing_packages]} == [yY][eE][sS] ]]; then
    echo "$BLUE----------------------------Installing writing_packages-----------------------------------$RESTORE"
    $1 "${PACKAGES_WRITING[@]}"
  fi

  install_prompt
  install_rust
  install_leftwm_git
  install_python
}

if [[ $current_distro = "fedora" ]]; then
  echo "$LGREEN=>$RESTORE Installing packages for$LBLUE Fedora$RESTORE"
  echo "# Added for speed
fastestmirror=True
max_parallel_downloads=10
defaultyes=True
keepcache=True" >> /etc/dnf/dnf.conf
  sudo dnf upgrade -y && sudo dnf update -y
  installer "sudo dnf install"
  sudo dnf autoremove
elif [[ $current_distro = "arch" ]]; then 
  echo "$LGREEN=>$RESTORE Installing packages for$BLUE Arch$RESTORE"
  installer "sudo pacman -Syu"
elif [[ $current_distro = "debian" ]]; then 
  echo "$LGREEN=>$RESTORE Installing packages for$PURPLE Debian$RESTORE"
  sudo apt upgrade -y && sudo apt update -y
  installer "sudo apt install"
  sudo apt autoremove
else
  echo "$LRED=>$RESTORE Not supported$RED distro$RESTORE"
fi
  

