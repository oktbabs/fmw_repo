#!/bin/sh
dos2unix inputAppProperties.*
. /tmp/appCSVFolder/inputAppProperties.csv


theNetMask=`/sbin/ifconfig |grep Mask: |head -1|awk -F':' '{print $4}'`
                    
sd1oappdu15(){
#$aa(){
# Admin VIP
echo "Adding IP for sd1soadomain-adminvhn.fsa.gov.uk"
sudo /sbin/ifconfig eth0:0 $SERVER1_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER1_VIP
# WSM Host1
echo "Adding IP for sd1aoppdu03-wsmhost1-vip.fsa.gov.uk"
sudo /sbin/ifconfig eth0:1  $SERVER2_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER2_VIP
#SOA host1
echo "Adding IP for sd1oappdu03-soahost1-vip.fsa.gov.uk"
sudo /sbin/ifconfig eth0:3  $SERVER4_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER4_VIP
#OSB Host1
echo "Adding IP for sd1oappdu03-osbhost1-vip.fsa.gov.uk"
sudo /sbin/ifconfig eth0:5  $SERVER6_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER6_VIP
# BAM HostVHN 1
echo "Adding IP for sd1oappdu03-bamhost1-vip.fsa.gov.uk"
sudo /sbin/ifconfig eth0:7  $SERVER8_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER8_VIP
}


sd1oappdu16(){
# WSM Host2
echo "Adding IP for sd1oappdu03-wsmhost2-vip.fsa.gov.uk"
sudo /sbin/ifconfig eth0:2  $SERVER3_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER3_VIP
#SOA host2
echo "Adding IP for sd1oappdu03-soahost2-vip.fsa.gov.uk"
sudo /sbin/ifconfig eth0:4  $SERVER5_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER5_VIP
#OSB Host2
echo "Adding IP for sd1oappdu03-osbhost2-vip.fsa.gov.uk"
sudo /sbin/ifconfig eth0:6  $SERVER7_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER7_VIP
# BAM Host 2
echo "Adding IP for sd1oappdu03-bamhost1-vip.fsa.gov.uk"
sudo /sbin/ifconfig eth0:7  $SERVER8_VIP netmask $theNetMask
sudo /sbin/arping -q -U -c 3 -I eth0 $SERVER8_VIP
}

#server=$(echo $HOSTNAME|tr -d '[a-z]'| tr -dc [:alnum:])

echo "Adding VIP's related to $HOSTNAME"
HOSTNAME=$(hostname)
theNode=$(echo $HOSTNAME|cut -c10-11)
sd1oappdu${theNode}


