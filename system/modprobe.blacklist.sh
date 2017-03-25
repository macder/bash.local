#!/bin/bash

gksudo gedit /etc/modprobe.d/blacklist.conf

sudo update-initramfs -u
sudo update-grub

sudo rm /var/lib/ureadahead/boot.pack
sudo rm /var/lib/ureadahead/pack

sudo mv /var/log/syslog /var/log/syslog.blacklist
sudo mv /var/log/kern.log /var/log/kern.log.bak

# sudo rm /var/log/syslog