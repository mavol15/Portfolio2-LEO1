# Portfolio2 - LEO1

Setup and start of the containers have been split into two parts. This is becuse we encountered some probems that can be solved by a reboot of the system.

The schripst should be run like this:

1. Run setup.sh
2. Reboot system
3. Run start.sh
4. DO NOT STOP THE SCRIPT (CTRL-C) it needs to be running

When this is done everything should be working.
The random numbers can be viewed in a browser with the device IP and port 8080 (XX.XX.XX.XX:8080)

In addition to the serup and start scripst thee is a reset script to uninstall and remove everything to retry if everything fails. 

-----------------------------------------------------------------------------------------------------------------

setup.sh

	Use apt to install lxc and dnsmasq-base.
	Create configuration files for network and bridge
	Create configuration files fo unpriviliged use
	Setup static IP for the containers
	Restart the lxc-net service

	After this a system reboot is needed. 

----------------------------------------------------------------------------------------------------------------
	
start.sh

	Create the two lxc containers
	Start and attach the two containers (Running a command like ls seams to help "wake it up")
	Wait to allow the containers to connect to the network.
	Setup portfowarding
	Setup the first container (c1-setup)
	Setup the second container (c2-setup)

----------------------------------------------------------------------------------------------------------------
	
reset.sh

    Purge lxc and dnsmasq-base
	Delete lcx configuration files
	
----------------------------------------------------------------------------------------------------------------
