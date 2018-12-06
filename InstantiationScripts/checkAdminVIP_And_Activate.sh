#!/bin/bash

dos2unix /tmp/appCSVFolder/inputAppProperties.csv
. /tmp/appCSVFolder/inputAppProperties.csv

LOGFOLDER=/tmp/appPostLaunch/logs

myHost=`hostname|cut -d. -f1`

theNetMask=`/sbin/ifconfig |grep Mask: |head -1|awk -F':' '{print $4}'`
m=0
###########################################################
## This section checks if Admin VIPs is running, if not
#  the Admin VIP is brought online.
###########################################################

if [ "$OCFS_NODE_1_NAME" == "$myHost" ]
then
echo "${OCFS_NODE_1_NAME}()"
{


# Check to see if Admin Port is already running with admin
echo " ===>> Verifying Admin VIP Status <<==="  >>$LOGFOLDER/adminVIP.log

adminip=$SERVER1_VIP
echo ".... Admin IP is  $SERVER1_VIP ...."

adminfoundexit(){
  echo "Admin server appears to be running already: "`netstat -nap|grep "$SERVER1_LISTENPORT"|grep LISTEN`; exit >>$LOGFOLDER/adminVIP.log
                }
setvip(){
  sudo /sbin/ifconfig eth0:${m} $adminip netmask $theNetMask
  sudo /sbin/arping -q -U -c 3 -I eth0 $adminip
        }

#####Main####

netstat -na|grep "$SERVER1_LISTENPORT"|grep LISTEN>>/dev/null&&adminfoundexit
ping $adminip -c1||setvip  >>$LOGFOLDER/adminVIP.log
sudo chown -R oracle:dba /tmp/appCSVFolder/inputAppProperties.csv
sudo chown -R oracle:dba $LOGFOLDER/adminVIP.log
}
else
echo "=====>>>> NOTHING TO DO ON $myHost <<<<==== "
echo   >>$LOGFOLDER/adminVIP.log
echo " Admin VIP can only be available on one Node at Template Instantiation"
echo   >>$LOGFOLDER/adminVIP.log
echo "=====>>>> NOTHING TO DO ON $myHost <<<<==== "
sudo chown -R oracle:dba /tmp/appCSVFolder/inputAppProperties.csv
sudo chown -R oracle:dba $LOGFOLDER/adminVIP.log
fi

