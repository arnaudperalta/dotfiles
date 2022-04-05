#!/bin/bash
sudo genie -c systemctl start docker
sudo chmod 777 /var/run/docker.sock
cd ~/.
sh -c "i3 > /dev/null &" &
setxkbmap -option "compose:ralt"
