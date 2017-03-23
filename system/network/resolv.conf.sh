#!/bin/bash
# Opens all config files related to resolving (DNS)

FILES="/etc/resolv.conf /etc/resolvconf/resolv.conf.d/head /etc/resolvconf/resolv.conf.d/base /etc/resolvconf/resolv.conf.d/original /etc/resolvconf/resolv.conf.d/tail /etc/networks /etc/hosts /etc/network/interfaces"

sh ~/scripts/tools/gedit.root.sh $FILES

#sudo resolvconf -u