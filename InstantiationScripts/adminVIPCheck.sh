#/bin/bash

#

# local script to start Admin in the background

#

# Check to see if port 7001 is already running with admin

adminip=192.168.110.31

adminfoundexit(){
  echo "Admin server appears to be running already: "`netstat -nap|grep 7001|grep LISTEN`; exit 1
}
setvip(){
  sudo /sbin/ifconfig eth1:1 $adminip netmask 255.255.255.0
  sudo /sbin/arping -q -U -c 3 -I eth1 $adminip
}

#####Main####

netstat -na|grep 7001|grep LISTEN>>/dev/null&&adminfoundexit
ping $adminip -c1||setvip



