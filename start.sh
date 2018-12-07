#!/bin/bash

CONT1=x1
CONT2=x2

## Setup the containers
# Create the containers
lxc-create -n $CONT1 -t download -- -d alpine -r 3.4 -a armhf
lxc-create -n $CONT2 -t download -- -d alpine -r 3.4 -a armhf

# Start the containers
lxc-start -n $CONT1
lxc-attach -n $CONT1 -- ls
lxc-start -n $CONT2
lxc-attach -n $CONT2 -- ls

# Wait to allow the containers to connect to the network.
sleep 20s

sudo iptables -t nat -A PREROUTING -i wlan0 -p tcp --dport 8080 -j DNAT --to-destination 10.0.3.100:80

cat ./C1_setup | lxc-attach -n $CONT1 -- tee /bin/setup.sh
lxc-attach -n $CONT1 -- chmod +x /bin/setup.sh
lxc-attach -n $CONT1 -- /bin/setup.sh
cat ./C1_webserver | lxc-attach -n $CONT1 -- tee /var/www/localhost/htdocs/index.php

cat ./C2_setup | lxc-attach -n $CONT2 -- tee /bin/setup.sh
lxc-attach -n $CONT2 -- chmod +x /bin/setup.sh
lxc-attach -n $CONT2 -- /bin/setup.sh

echo "\nServer is now running on port 8080\n"
