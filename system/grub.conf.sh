#!/bin/bash
# Opens grub config file and when finished runs update-grub

gksudo gedit /etc/default/grub

sudo update-grub