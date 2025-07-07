#!/bin/sh
cat /etc/issue
uname -a
id -a
apt install -y -f file sudo build-essential devscripts debhelper git
file /bin/ls
