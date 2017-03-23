#!/bin/bash

# bash ~/scripts/connect.fcv_vpn.sh &

# WID=$(xprop -root | grep "_NET_ACTIVE_WINDOW(WINDOW)"| awk '{print $5}')
# xdotool windowfocus $WID
# xdotool key ctrl+shift+t
# wmctrl -i -a $WID

cd ~/www/halifax_ca
# docker login nexus.fcvhost.com:9443
# docker-compose start


# docker-compose exec hrm-dev bash -c "cd ui; npm start"

subl ~/www/halifax_ca