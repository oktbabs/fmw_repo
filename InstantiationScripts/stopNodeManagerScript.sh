
#+++++++++++++++++++++++++++++++++++++++++"
# Script Name  : stopNodeManagerScript.sh"
# Written By   : Timmy Babayeju          +"
# From Company : Fujitsu                 +"
# To  Company  : FSA                     +"
# Description : Script stops NodeManager+"
# on VM1 and VM2                         +"
#+++++++++++++++++++++++++++++++++++++++++"

#!/bin/sh
#
dos2unix /tmp/appCSVFolder/inputAppProperties.csv
. /tmp/appCSVFolder/inputAppProperties.csv

export JAVA_HOME=/u01/app/oracle/product/jrockit_1.6.0_31
export WL_HOME=/u01/app/oracle/product/fmw/wlserver_10.3
export PATH=$PATH:$JAVA_HOME/bin:$WL_HOME:.


LOGFOLDER=/tmp/appPostLaunch/logs

myHost=`hostname|cut -d. -f1`


. $WL_HOME/server/bin/setWLSEnv.sh  >>$LOGFOLDER/NodeManagerStop.log

# This section indicates on which VM the Nodemanager should stop on
#

if [ "$OCFS_NODE_1_NAME" == "$myHost" ]
then
echo "...Stopping NodeManager on $myHost....."  >>$LOGFOLDER/NodeManagerStop.log
echo  >>$LOGFOLDER/NodeManagerStop.log
java weblogic.WLST -loadProperties /tmp/appCSVFolder/inputAppProperties.csv stopNM_1.py $1  >>$LOGFOLDER/NodeManagerStop.log
echo  >>$LOGFOLDER/NodeManagerStop.log
elif [ "$OCFS_NODE_2_NAME" == "$myHost" ]
then
echo "...Stopping NodeManager on $myHost....."  >>$LOGFOLDER/NodeManagerStop.log
echo  >>$LOGFOLDER/NodeManagerStop.log
java weblogic.WLST -loadProperties /tmp/appCSVFolder/inputAppProperties.csv stopNM_2.py $1  >>$LOGFOLDER/NodeManagerStop.log
echo  >>$LOGFOLDER/NodeManagerStop.log
else
echo " --"     >>$LOGFOLDER/NodeManagerStop.log
echo " ===>> Cannot Stop NodeManager $myHost . Check That Host Name exists in CSV file >>$LOGFOLDER/NodeManagerStop.log"
echo " --"   >>$LOGFOLDER/NodeManagerStop.log
fi

chown -R oracle:dba /tmp/appCSVFolder/inputAppProperties.csv   >>$LOGFOLDER/NodeManagerStop.log

