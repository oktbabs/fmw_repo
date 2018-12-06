
myhost=`hostname -s`

if [ "$myhost" == "ohsserver01" ]
then
echo "$myhost()"
	{
	echo  Admin VIP
	#192.168.220.81
	sudo /sbin/ifconfig eth1:0  192.168.220.81 netmask 255.255.255.0 
	sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.81
	
	echo  NodeManager VIP
	#192.168.220.82
	sudo /sbin/ifconfig eth1:1  192.168.220.82 netmask 255.255.255.0 
	sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.82
	
	echo  WSM host1
	#192.168.221.83
	sudo /sbin/ifconfig eth2:2  192.168.221.83 netmask 255.255.255.0 
	sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.83
	
	echo  SOA host1
	#192.168.221.84
	sudo /sbin/ifconfig eth2:3  192.168.221.84 netmask 255.255.255.0 
	sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.84
	
	echo  OSB host1
	#192.168.221.85
	sudo /sbin/ifconfig eth2:4  192.168.221.85 netmask 255.255.255.0 
	sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.85
	
        echo  BAM HostVHN 1
        #192.168.221.86
        sudo /sbin/ifconfig eth2:5  192.168.221.86 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.86

        echo  OIM HostVHN 1
        #192.168.221.87
        sudo /sbin/ifconfig eth2:6  192.168.221.87 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.87


        echo  OAM HostVHN 1
        #192.168.221.88
        sudo /sbin/ifconfig eth2:7  192.168.221.88 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.88

	}
elif [ "$myhost" == "ohsserver02" ]
then
echo	"$myhost()"
	{
        echo  Admin VIP
        #192.168.220.281
        sudo /sbin/ifconfig eth1:0  192.168.220.281 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.281

        echo  NodeManager VIP
        #192.168.220.282
        sudo /sbin/ifconfig eth1:1  192.168.220.282 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.220.282

        echo  WSM host1
        #192.168.221.283
        sudo /sbin/ifconfig eth2:2  192.168.221.283 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.283

        echo  SOA host1
        #192.168.221.214
        sudo /sbin/ifconfig eth2:3  192.168.221.284 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.284

        echo  OSB HostVHN 1
        #192.168.221.285
        sudo /sbin/ifconfig eth2:4  192.168.221.285 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.285


        echo  BAM HostVHN 1
        #192.168.221.286
        sudo /sbin/ifconfig eth2:5  192.168.221.286 netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.286

        echo  OIM HostVHN 1
        #192.168.221.287
        sudo /sbin/ifconfig eth2:6  192.168.221.287  netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.287

        echo  OAM Policy Manager HostVHN 1
        #192.168.221.288
        sudo /sbin/ifconfig eth2:7  192.168.221.288  netmask 255.255.255.0
        sudo /sbin/arping -q -U -c 3 -I eth0 192.168.221.288

}
else
echo    "$myhost()"
        {

	echo "This server $myhost has not been calibrated with the correct VIPS. "
	echo "Calibrate and add servers with IP Address to setup VIPs."
	}
fi
