
#+++++++++++++++++++++++++++++++++++++++++++++++"
# Script Name  : create_networkVIPs_1.sh        "
# Written By   : Timmy Babayeju                +"
# From Company : Fujitsu                       +"
# To  Company  : FSA                           +"
#+++++++++++++++++++++++++++++++++++++++++++++++"
# The script manages the Network Configuration +" 
# files and creates them per VM if they are    +" 
# not already created                          +"
#+++++++++++++++++++++++++++++++++++++++++++++++"                       


#!/bin/sh

dos2unix /tmp/appCSVFolder/inputAppProperties.csv
. /tmp/appCSVFolder/inputAppProperties.csv

LOGFOLDER=/tmp/appPostLaunch/logs

myHost=`hostname|cut -d. -f1`
theNetMask=`/sbin/ifconfig |grep Mask: |head -1|awk -F':' '{print $4}'`
netDir=/etc/sysconfig/network-scripts
fileeth0=$netDir/ifcfg-eth0

serverNum=`grep "SERVER[0-9]*_VIP" /tmp/appCSVFolder/inputAppProperties.csv|awk -F'=' '{print  $2 }'|wc -l`

a=1
###################################################################
## This section checks if the Network Configuration files for VM1 
# are already created in a vertical or horizontal Cluster. 
###################################################################

if [ "$OCFS_NODE_1_NAME" == "$myHost" ]
then
echo "${OCFS_NODE_1_NAME}()"
{
networkVIP1(){

for (( b=2; b <= $serverNum;b++ ))
do
   if [ ! -f "$netDir/ifcfg-eth0:${a}" ]
   then
      echo 
      echo "-====>>> Creating network $netDir/ifcfg-eth0:${a}  <<======"
      echo 
      echo "#" > $netDir/ifcfg-eth0:${a}
      echo  "# generated by script : Author: Timmy Babayeju, Fujitsu Limited" >> $netDir/ifcfg-eth0:${a}
      echo "#" >> $netDir/ifcfg-eth0:${a}
      echo "DEVICE=eth0:${a}" >> $netDir/ifcfg-eth0:${a}
      echo "ONBOOT=yes"  >> $netDir/ifcfg-eth0:${a}
      echo "BOOTPROTO=static" >>$netDir/ifcfg-eth0:${a}
      echo IPADDR=`grep "^SERVER${b}_VIP=" /tmp/appCSVFolder/inputAppProperties.csv|cut -d= -f2`>> $netDir/ifcfg-eth0:${a}
      echo "NETMASK=$theNetMask" >> $netDir/ifcfg-eth0:${a}
      echo "NETWORK=10.134.2.0"  >> $netDir/ifcfg-eth0:${a}
      echo "TYPE=Ethernet"  >> $netDir/ifcfg-eth0:${a}
      echo "-====>>> Successfully Created ...$netDir/ifcfg-eth0:${a} <<======"
      echo 
   else
      echo " ..... $netDir/ifcfg-eth0:${a} .... already exists. Nothing changes for this file"  
      echo
   fi
   if [ $OCFS_NODES_TOTAL -eq 2 ]
   then
        if [ $a -eq 2 -o $a -eq 4 -o $a -eq 6 -o $a -eq 8 ]
        then
            echo
            echo " .....removing  $netDir/ifcfg-eth0:${a} network configuration file from `hostname` host....."  
            echo
                  rm -f $netDir/ifcfg-eth0:${a}
            echo
            echo " .....$netDir/ifcfg-eth0:${a} network configuration file successfully removed from `hostname` host....."  
        else
            echo
            echo "... This is a single Node or single VM Deployment  on VM1 ..."
            echo "... ALL Network Configuration files for vertical clustering are created .."
            echo
        fi
    fi
 a=$(( a + 1 ))
done
                  
}
networkVIP1 >> $LOGFOLDER/create_networkVIPs.log
}

sudo chown -R oracle:dba /tmp/appCSVFolder/inputAppProperties.csv
sudo chown -R oracle:dba $LOGFOLDER/create_networkVIPs.log
###################################################################
## This section checks if the Network Configuration files for VM2 
# are already created in a vertical or horizontal Cluster. 
###################################################################

elif [ "$OCFS_NODE_2_NAME" == "$myHost" ]
then
echo "${OCFS_NODE_2_NAME}()"
{
networkVIP2(){ 
for (( b=2; b <= $serverNum;b++ ))
do
   if [ ! -f "$netDir/ifcfg-eth0:${a}" ]
   then
      echo 
      echo "-====>>> Creating network $netDir/ifcfg-eth0:${a}  <<======"
      echo 
      echo "#" > $netDir/ifcfg-eth0:${a}
      echo  "# generated by script : Author: Timmy Babayeju, Fujitsu Limited" >> $netDir/ifcfg-eth0:${a}
      echo "#" >> $netDir/ifcfg-eth0:${a}
      echo "DEVICE=eth0:${a}" >> $netDir/ifcfg-eth0:${a}
      echo "ONBOOT=yes"  >> $netDir/ifcfg-eth0:${a}
      echo "BOOTPROTO=static" >>$netDir/ifcfg-eth0:${a}
      echo IPADDR=`grep "^SERVER${b}_VIP=" /tmp/appCSVFolder/inputAppProperties.csv|cut -d= -f2`>> $netDir/ifcfg-eth0:${a}
      echo "NETMASK=$theNetMask" >> $netDir/ifcfg-eth0:${a}
      echo "NETWORK=10.134.2.0"  >> $netDir/ifcfg-eth0:${a}
      echo "TYPE=Ethernet"  >> $netDir/ifcfg-eth0:${a}
      echo "-====>>> Successfully Created ...$netDir/ifcfg-eth0:${a} <<======"
      echo 
   else
      echo " ..... $netDir/ifcfg-eth0:${a} .... already exists. Nothing changes for this file"  
      echo
   fi
        if [ $a -eq 1 -o $a -eq 3 -o $a -eq 5 -o $a -eq 7 ]
        then
            echo
            echo " .....removing  $netDir/ifcfg-eth0:${a} network configuration file from `hostname` host....."  
            echo
                  rm -f $netDir/ifcfg-eth0:${a}
            echo
            echo " .....$netDir/ifcfg-eth0:${a} network configuration file successfully removed from `hostname` host....."  
        fi
 a=$(( a + 1 ))
done
                  
}
networkVIP2 >> $LOGFOLDER/create_networkVIPs.log
}
sudo chown -R oracle:dba /tmp/appCSVFolder/inputAppProperties.csv
sudo chown -R oracle:dba $LOGFOLDER/create_networkVIPs.log
else
  echo "+++++++++++++++++++++++++++++++++++++++++++++++"
  echo "------>>> Cannot Determine server Name <<<<----"
  echo
  echo "------>>> Cannot Verify or Activate VIPs <<<----"
  echo "+++++++++++++++++++++++++++++++++++++++++++++++"
sudo chown -R oracle:dba /tmp/appCSVFolder/inputAppProperties.csv
sudo chown -R oracle:dba $LOGFOLDER/create_networkVIPs.log
fi

