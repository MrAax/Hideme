#!/bin/bash
clear
set -e
changer_mac_wlan0(){
		#clear
		macchanger -l > vendormac.txt
		sudo ifconfig wlan0 down
		ouimac=$(shuf -n 1 vendormac.txt | awk '{print$3}')
		uaamac=$(printf '%02x:%02x:%02x' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
		macchanger -m "$ouimac:$uaamac" wlan0
		sudo ifconfig wlan0 up
		sleep 15
}

changer_mac_eth0(){
		#clear
		macchanger -l > vendormac.txt
		sudo ifconfig eth0 down
		ouimac=$(shuf -n 1 vendormac.txt | awk '{print$3}')
		uaamac=$(printf '%02x:%02x:%02x' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
		macchanger -m "$ouimac:$uaamac" eth0
		sudo ifconfig eth0 up
		sleep 15	
}

tor_reload(){
	sudo service tor start
	echo "Select your option : "
    echo "1. wlan0"
    echo "2. eth0"
    read options
    if (($options == 1 ))
    then
    	changer_mac_wlan0
    	changer_mac_wlan0
    	changer_mac_wlan0
    elif (($options == 2))
    then
    	changer_mac_eth0
    	changer_mac_eth0
    	changer_mac_eth0
    else
            clear
            echo "Invaled option selected !!!"
            sleep 5
            clear
     fi
        
	sudo service tor restart
	sleep 15
	proxychains firefox https://check.torproject.org/
	proxychains bash
	
}

wget -q --spider https://google.com
if [ "$?" -eq 0 ]; then
	tor_reload
else
	echo -e "		\033[1m \e[0;31m Check your network connection.\033[0m"
	sleep 3
fi

tor_restart(){
	sudo service tor restart
}

while true
do
	wget -q --spider https://google.com
	if [ "$?" -eq 0 ]; then
		echo -e "		\033[1m \e[0;32m Your network connected.\033[0m"
		echo -e "\033[1;40;31m Please wait some settings are changing. \e[0m"
		tor_restart
		sleep 10
		
	else
		clear
		echo -e "		\033[1m \e[0;31m Check your network connection.\033[0m"
		sleep 3
	fi
done