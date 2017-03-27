#!/bin/bash

# Run this after installing a minimalist Ubuntu (mini.iso w/ manual package selection)
# sudo ./install.post_os.sh

# this is a WIP

declare APT_DESKTOP=( 
  # "--no-install-recommends ubuntu-gnome-desktop" # Needs to be seperated, dont want others to not install recommends
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
  "hwdata"
  "intel-microcode"
  "iucode-tool"
  "nvidia-375"
)

declare BLACKLIST=(
  "snd_hda_codec_hdmi"
  "joydev"
  "eeepc_wmi"
  "asus_wmi"
  "snd_seq_midi"
  "snd_seq_midi_event"
  "snd_rawmid"
  "snd_seq"
  "snd_seq_device"
  "fjes"
  "mac_hid"
)

function grub_text {
  file="/etc/default/grub"

  sed -i 's/quite splash//g' $file
  sed -i 's/#GRUB_TERMINAL/GRUB_TERMINAL/g' $file
  echo "GRUB_GFXPAYLOAD=text" >> $file

  nano $file
  update-grub
}

function network {
  file="/etc/network/interfaces"

  sed -i 's/auto eno1/allow-hotplug eno1/g' $file
  nano $file

  systemctl disable network-manger
  systemctl disable networking.service
}

function modprobe_blacklist {
  echo "options snd_hda_intel enable=1,0" > /etc/modprobe.d/intel.conf

  for element in ${BLACKLIST[@]}
  do
    echo -e "blacklist "$element >> /etc/modprobe.d/blacklist.conf
  done  

  update-initramfs -u
}

#echo fs.inotify.max_user_watches=16384 | tee -a /etc/sysctl.conf
#sysctl -p
