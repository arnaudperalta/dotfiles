#!/bin/bash
sudo genie -c systemctl start docker
sudo chmod 777 /var/run/docker.sock
cd ..
i3 &!
setxkbmap -option "compose:ralt"
