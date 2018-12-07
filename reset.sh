#!/bin/bash

CONT1=C1
CONT2=C2

lxc-stop -n $CONT1
lxc-stop -n $CONT2

lxc-destroy -n $CONT1
lxc-destroy -n $CONT2

sudo apt -y purge --auto-remove lxc dnsmasq-base

sudo rm -rf /home/pi/.config/lxc /etc/lxc /etc/default/lxc-net /etc/default/lxc
