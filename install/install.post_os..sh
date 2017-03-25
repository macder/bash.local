#!/bin/bash

# Install system packages after installing ubuntu base (mini.iso)

# this is a WIP

declare APT_DESKTOP=( 
  # "--no-install-recommends ubuntu-gnome-desktop"
  "xserver-xorg-legacy"
  "gksu"
  "gnome-software"
)

declare APT_UTILS=(
  "synaptic"
  "system-config-lvm"
  "firefox"
)

declare APT_DRIVERS=(
  "intel-microcode"
  "iucode-tool"
  "nvidia-375"
)

function grub_text {
  file="/etc/default/grub"

  sudo sed -i 's/quite splash//g' $file
  sudo sed -i 's/#GRUB_TERMINAL/GRUB_TERMINAL/g' $file
  sudo echo "GRUB_GFXPAYLOAD=text" >> $file

  sudo nano $file
  sudo update-grub
}

function network {
  file="/etc/network/interfaces"

  sudo sed -i 's/auto eno1/allow-hotplug eno1/g' $file
  sudo nano $file

  sudo systemctl disable network-manger
  sudo systemctl disable networking.service
}
