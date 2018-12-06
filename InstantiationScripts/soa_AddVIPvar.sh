
#++++++++++++++++++++++++++++++++++++++++++++++
# Script Name  : soa_AddVIPvar.sh             +
# Written By   : Timmy Babayeju               +
# From Company : Fujitsu                      +
# To  Company  : FSA                          +
# Description : Script to bring SOA VIPs      +
# Online. The script is executed on the two   + 
# VMs for SOA                                 + 
#++++++++++++++++++++++++++++++++++++++++++++++


#!/bin/sh
dos2unix inputAppProperties.*
. /tmp/appCSVFolder/inputAppProperties.csv

LOGFOLDER=/tmp/appPostLaunch/logs

theNetMask=`/sbin/ifconfig |grep Mask: |head -1|awk -F':' '{print $4}'`
                    
sd1oappdu15(){
# Admin VIP
echo "Adding IP for $SERVER1_LISTENADDR"
sudo /sbin/ifconfig eth0:0 $SERVER1_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER1_VIP
# WSM Host1
echo "Adding IP for $SERVER2_LISTENADDR"
sudo /sbin/ifconfig eth0:1  $SERVER2_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER2_VIP
#SOA host1
echo "Adding IP for $SERVER4_LISTENADDR"
sudo /sbin/ifconfig eth0:3  $SERVER4_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER4_VIP
#OSB Host1
echo "Adding IP for $SERVER6_LISTENADDR"
sudo /sbin/ifconfig eth0:5  $SERVER6_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER6_VIP
# BAM HostVHN 1
echo "Adding IP for $SERVER8_LISTENADDR"
sudo /sbin/ifconfig eth0:7  $SERVER8_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER8_VIP
}


sd1oappdu16(){
# WSM Host2
echo "Adding IP for $SERVER3_LISTENADDR"
sudo /sbin/ifconfig eth0:2  $SERVER3_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER3_VIP
#SOA host2
echo "Adding IP for $SERVER5_LISTENADDR"
sudo /sbin/ifconfig eth0:4  $SERVER5_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER5_VIP
#OSB Host2
echo "Adding IP for $SERVER7_LISTENADDR"
sudo /sbin/ifconfig eth0:6  $SERVER7_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER7_VIP
# BAM Host 2
echo "Adding IP for $SERVER9_LISTENADDR"
sudo /sbin/ifconfig eth0:8  $SERVER9_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER9_VIP
}

#server=$(echo $HOSTNAME|tr -d '[a-z]'| tr -dc [:alnum:])

echo "Adding VIP's related to $HOSTNAME" >>$LOGFOLDER/soa_AddVIPvar.log
HOSTNAME=$(hostname)
theNode=$(echo $HOSTNAME|cut -c10-11)
sd1oappdu${theNode}  >>$LOGFOLDER/soa_AddVIPvar.log


