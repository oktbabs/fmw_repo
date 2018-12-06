
myhost=`hostname -s`

if [ "$myhost" == "oelvmapps01" ]
then
echo "$myhost()"
	{
	echo  Admin VIP
	#192.168.110.31
	sudo /sbin/ifconfig eth1:0  192.168.220.31 netmask 255.255.255.0 
	sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.31
	
	echo  NodeManager VIP
	#192.168.110.32
	sudo /sbin/ifconfig eth1:1  192.168.220.32 netmask 255.255.255.0 
	sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.32
	
	echo  WSM host1
	#192.168.220.33
	sudo /sbin/ifconfig eth2:2  192.168.221.33 netmask 255.255.255.0 
	sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.33
	
	echo  SOA host1
	#192.168.220.34
	sudo /sbin/ifconfig eth2:3  192.168.221.34 netmask 255.255.255.0 
	sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.34
	
	echo  OSB host1
	#192.168.220.35
	sudo /sbin/ifconfig eth2:4  192.168.221.35 netmask 255.255.255.0 
	sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.35
	
        echo  BAM HostVHN 1
        #192.168.220.36
        sudo /sbin/ifconfig eth2:5  192.168.221.36 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.36

        echo  OIM HostVHN 1
        #192.168.220.37
        sudo /sbin/ifconfig eth2:6  192.168.221.37 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.37

        echo  OAM HostVHN 1
        #192.168.220.38
        sudo /sbin/ifconfig eth2:7  192.168.221.38  netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.38

        echo  OBI HostVHN 1
        #192.168.220.39
        sudo /sbin/ifconfig eth2:8  192.168.221.39  netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.39

        echo  OAMPM HostVHN 1
        #192.168.220.40
        sudo /sbin/ifconfig eth2:9  192.168.221.40  netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.40


	}
elif [ "$myhost" == "oelvmapps02" ]
then
echo	"$myhost()"
	{
        echo  Admin VIP
        #192.168.110.131
        sudo /sbin/ifconfig eth1:0  192.168.220.131 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.131

        echo  NodeManager VIP
        #192.168.110.132
        sudo /sbin/ifconfig eth1:1  192.168.220.132 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.132

        echo  WSM host1
        #192.168.221.134
        sudo /sbin/ifconfig eth2:2  192.168.221.133 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.133

        echo  SOA host1
        #192.168.221.134
        sudo /sbin/ifconfig eth2:3  192.168.221.134 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.134

        echo  OSB HostVHN 1
        #192.168.221.135
        sudo /sbin/ifconfig eth2:4  192.168.221.135 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.135


        echo  BAM HostVHN 1
        #192.168.221.136
        sudo /sbin/ifconfig eth2:5  192.168.221.136 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.136

        echo  OIM HostVHN 1
        #192.168.221.137
        sudo /sbin/ifconfig eth2:6  192.168.221.137  netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.137

        echo  OAM HostVHN 1
        #192.168.221.138
        sudo /sbin/ifconfig eth2:7  192.168.221.138  netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.138

        echo  OBI HostVHN 1
        #192.168.221.139
        sudo /sbin/ifconfig eth2:7  192.168.221.139  netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.139

        echo  OAM Policy Manager HostVHN 1
        #192.168.221.140
        sudo /sbin/ifconfig eth2:7  192.168.221.140  netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.140

}
else
echo    "$myhost()"
        {

	echo "This server $myhost has not been calibrated with the correct VIPS. "
	echo "Calibrate and add servers with IP Address to setup VIPs."
	}
fi
