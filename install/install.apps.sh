#!/bin/bash

declare APT_FONTS=( 
  "fonts-liberation" 
  "ttf-ubuntu-font-family" 
)

declare APT_SYS_UTILS=( 
  "curl" 
  "leafpad" 
  "glogg" 
  "hexchat" 
  "terminator" 
  "gimp" 
  "guake" 
  "ppp" 
)

declare APT_PHP=( 
  "php7.0-cli" 
  "php7.0-curl" 
  "php7.0-mbstring" 
  "php7.0-mcrypt" 
)

declare APT_DEV_UTILS=( 
  "git" 
  "mysql-workbench"
  "build-essential"
)

# 3rd party not from apt
declare -A ALT_PACKS=(
  ["sublime-text_build-3126_amd64.deb"]="https://download.sublimetext.com/"
  ["google-chrome-stable_current_amd64.deb"]="https://dl.google.com/linux/direct/"
  ["virtualbox-5.1_5.1.18-114002~Ubuntu~xenial_amd64.deb"]="http://download.virtualbox.org/virtualbox/5.1.18/"
  ["vagrant_1.9.3_x86_64.deb"]="https://releases.hashicorp.com/vagrant/1.9.3/"
  ["gitkraken-amd64.deb"]="https://release.gitkraken.com/linux/"
  ["dropbox_2015.10.28_amd64.deb"]="https://www.dropbox.com/download?dl=packages/ubuntu/"
  ["slack-desktop-2.5.2-amd64.deb"]="https://downloads.slack-edge.com/linux_releases/"
  ["skypeforlinux-64-alpha.deb"]="https://go.skype.com/"
)

# @param array Packages for install
# @param string Confirm message
function user_confirm {
  echo -e "\n"$2"\n"$1"\n"

  select result in Yes No
  do
    install=$([ $REPLY == 1 ] && echo true || echo false )
    if [ $REPLY == 1 ] || [ $REPLY == 2 ] ; then
      break
    fi
  done  
}

# @param array Packages for install
function apt_install {
  local -n packs="$1[@]"

  confirm_msg='Install these packages?'
  user_confirm "$packs" "$confirm_msg"

  if $install ; then
    sudo apt-get install -y $packs
  fi
}

# @param array Packages for install
function www_install {
  local -n packs=$1

  files=${!packs[*]}
  confirm_msg="Download & install these 3rd party apps? If yes, I will create ~/install"
  user_confirm "$files" "$confirm_msg"

  if $install ; then
    mkdir ~/installed
    cd ~/installed
    for i in ${!packs[@]} ; do
      wget "${packs["$i"]}$i"
      sudo dpkg -i $i
    done
    sudo apt-get -f install
  fi  
}

function node_install {
  url="https://deb.nodesource.com/setup_6.x"
  confirm_msg="Install node.js?"
  user_confirm "$url" "$confirm_msg"

  if $install ; then
    curl -sL $url | sudo -E bash -
    sudo apt-get install -y nodejs 
  fi
}

function composer_install {
  url="https://getcomposer.org/installer"
  confirm_msg="Install Composer?"
  user_confirm "$url" "$confirm_msg"

  if $install ; then
    curl -sS $url | sudo php -- --install-dir=/usr/local/bin --filename=composer
  fi
}

sudo apt-get update

apt_install APT_FONTS
apt_install APT_SYS_UTILS
apt_install APT_PHP
apt_install APT_DEV_UTILS

www_install ALT_PACKS
node_install
composer_install
