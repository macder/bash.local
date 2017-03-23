#!/bin/bash

cd ~/www/flex
vagrant up

# (/usr/bin/terminator -e cd ui; npm start &> /dev/null &)

(/usr/bin/google-chrome http://flex.dev https://github.com/macder/flex https://app.codeship.com/projects/203597 &> /dev/null &)

(/usr/bin/subl ~/www/flex &> /dev/null &)
(/usr/bin/mysql-workbench &> /dev/null &)
(/usr/bin/gitkraken &> /dev/null &)
(/usr/bin/terminator &> /dev/null &)
