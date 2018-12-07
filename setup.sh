#!/bin/bash

CONT1=C1
CONT2=C2

# Install lxc and dnsmasq-base:
sudo apt -y install lxc dnsmasq-base


#Based on the following two guides
#https://angristan.xyz/setup-network-bridge-lxc-net/
#https://help.ubuntu.com/lts/serverguide/lxc.html

echo "lxc.network.type = veth" | sudo tee /etc/lxc/default.conf 
echo "lxc.network.link = lxcbr0" | sudo tee -a /etc/lxc/default.conf
echo "lxc.network.flags = up" | sudo tee -a /etc/lxc/default.conf
echo "lxc.network.hwaddr = 00:16:3e:xx:xx:xx" | sudo tee -a /etc/lxc/default.conf

echo "USE_LXC_BRIDGE=true" | sudo tee -a /etc/default/lxc-net

echo "LXC_DHCP_CONFILE=/etc/lxc/dnsmasq.conf" | sudo tee -a /etc/default/lxc-net
sudo touch /etc/lxc/dnsmasq.conf

mkdir -p ~/.config/lxc
echo "lxc.id_map = u 0 100000 65536" > ~/.config/lxc/default.conf
echo "lxc.id_map = g 0 100000 65536" >> ~/.config/lxc/default.conf
echo "lxc.network.type = veth" >> ~/.config/lxc/default.conf 
echo "lxc.network.link = lxcbr0" >> ~/.config/lxc/default.conf
echo "lxc.network.flags = up" >> ~/.config/lxc/default.conf
echo "lxc.network.hwaddr = 00:16:3e:xx:xx:xx" >> ~/.config/lxc/default.conf
echo "$USER veth lxcbr0 10" | sudo tee -a /etc/lxc/lxc-usernet

echo "dhcp-host=$CONT1,10.0.3.100" | sudo tee -a /etc/lxc/dnsmasq.conf
echo "dhcp-host=$CONT2,10.0.3.101" | sudo tee -a /etc/lxc/dnsmasq.conf
sudo service lxc-net restart


