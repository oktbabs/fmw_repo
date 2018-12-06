
# Admin VIP
#192.168.110.31
sudo /sbin/ifconfig eth1:0  192.168.110.31 netmask 255.255.255.0 
sudo /sbin/arping -q -U -c 3 -I eth0 192.168.110.31

# NodeManager VIP
#192.168.110.32
sudo /sbin/ifconfig eth1:1  192.168.110.32 netmask 255.255.255.0 
sudo /sbin/arping -q -U -c 3 -I eth0 192.168.110.32
# WSM Host1
#192.168.220.33
sudo /sbin/ifconfig eth2:1  192.168.220.33 netmask 255.255.255.0 
sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.33
# WSM Host2
#192.168.220.133
sudo /sbin/ifconfig eth2:2  192.168.220.133 netmask 255.255.255.0 
sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.133

#SOA host1
#192.168.220.35
sudo /sbin/ifconfig eth2:3  192.168.220.35 netmask 255.255.255.0 
sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.35
#SOA host2
#192.168.220.135
sudo /sbin/ifconfig eth2:4  192.168.220.135 netmask 255.255.255.0 
sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.135
#OSB Host1
#192.168.220.37
sudo /sbin/ifconfig eth2:5  192.168.220.37 netmask 255.255.255.0 
sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.37
#OSB Host2
#192.168.220.137
sudo /sbin/ifconfig eth2:6  192.168.220.137 netmask 255.255.255.0 

sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.137
# BAM HostVHN 1
#192.168.220.39
sudo /sbin/ifconfig eth2:7  192.168.220.39 netmask 255.255.255.0 
sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.39
# BAM Host 2
#192.168.220.139
sudo /sbin/ifconfig eth2:8  192.168.220.139 netmask 255.255.255.0 
sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.139



