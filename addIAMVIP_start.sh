
myhost=`hostname -s`

if [ "$myhost" == "fmwidm01" ]
then
echo "$myhost()"
	{
	echo  Admin VIP
	#192.168.220.31
	sudo /sbin/ifconfig eth1:0  192.168.220.31 netmask 255.255.255.0 
	sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.31
	
	echo  NodeManager VIP
	#192.168.220.32
	sudo /sbin/ifconfig eth1:1  192.168.220.32 netmask 255.255.255.0 
	sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.32
	
	echo  SOA host1
	#192.168.221.33
	sudo /sbin/ifconfig eth2:3  192.168.221.33 netmask 255.255.255.0 
	sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.33
	
        echo  OIM HostVHN 1
        #192.168.221.35
        sudo /sbin/ifconfig eth2:5  192.168.221.35 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.35


        echo  OAM HostVHN 1
        #192.168.221.37
        sudo /sbin/ifconfig eth2:7  192.168.221.37  netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.37

        echo  OAP Policy Manager HostVHN 1
        #192.168.220.39
        sudo /sbin/ifconfig eth2:9  192.168.221.39  netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.39


	}
elif [ "$myhost" == "fmwidm02" ]
then
echo	"$myhost()"
	{
        echo  Admin VIP
        #192.168.220.131
        sudo /sbin/ifconfig eth1:0  192.168.220.131 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.131

        echo  NodeManager VIP
        #192.168.220.132
        sudo /sbin/ifconfig eth1:1  192.168.220.132 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.132

        echo  SOA host1
        #192.168.220.133
        sudo /sbin/ifconfig eth2:3  192.168.220.133 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.133

        echo  OIM HostVHN 1
        #192.168.220.135
        sudo /sbin/ifconfig eth2:5  192.168.220.135 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.135


        echo  OAM HostVHN 1
        #192.168.220.137
        sudo /sbin/ifconfig eth2:7  192.168.220.137  netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.137

        echo  OAP Policy Manager HostVHN 1
        #192.168.220.139
        sudo /sbin/ifconfig eth2:9  192.168.220.139  netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.139


}
else
echo    "$myhost()"
        {

	echo "This server $myhost has not been calibrated with the correct VIPS. "
	echo "Calibrate and add servers with IP Address to setup VIPs."
	}
fi
