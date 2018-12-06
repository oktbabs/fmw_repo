
#+++++++++++++++++++++++++++++++++++++++++"
# Script Name  : startNodeManagerScript.sh"
# Written By   : Timmy Babayeju          +"
# From Company : Fujitsu                 +"
# To  Company  : FSA                     +"
# Description : Script starts NodeManager+"
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


. $WL_HOME/server/bin/setWLSEnv.sh  >>$LOGFOLDER/NodeManagerStart.log

# This method starts Node Manager 1 on VM1

initiateNodeManager1(){
java weblogic.WLST -loadProperties /tmp/appCSVFolder/inputAppProperties.csv startNM_1.py
}

# This method starts Node Manager 2 on VM2

initiateNodeManager2(){
java weblogic.WLST -loadProperties /tmp/appCSVFolder/inputAppProperties.csv startNM_2.py
}

# This section indicates on which VM the Nodemanager should start on
#

if [ "$OCFS_NODE_1_NAME" == "$myHost" ]
then
echo "${OCFS_NODE_1_NAME}()"
{
# This section indicates that Nodemanager should start on VM1
#
initiateNodeManager1  >>$LOGFOLDER/NodeManagerStart.log
sudo chown -R oracle:dba /tmp/appCSVFolder/inputAppProperties.csv   >>$LOGFOLDER/NodeManagerStart.log
sudo chown -R oracle:dba $LOGFOLDER/NodeManagerStart.log
}
elif [ "$OCFS_NODE_2_NAME" == "$myHost" ]
then
echo "${OCFS_NODE_2_NAME}()"
{
# This section indicates that Nodemanager should start on VM2
#
initiateNodeManager2  >>$LOGFOLDER/NodeManagerStart.log
sudo chown -R oracle:dba /tmp/appCSVFolder/inputAppProperties.csv   >>$LOGFOLDER/NodeManagerStart.log
sudo chown -R oracle:dba $LOGFOLDER/NodeManagerStart.log
}
else
echo " --"     >>$LOGFOLDER/NodeManagerStart.log
echo " ===>> Cannot Start NodeManager $myHost . Check That Host Name exists in CSV file >>$LOGFOLDER/NodeManagerStart.log"
echo " --"   >>$LOGFOLDER/NodeManagerStart.log
sudo chown -R oracle:dba /tmp/appCSVFolder/inputAppProperties.csv   >>$LOGFOLDER/NodeManagerStart.log
sudo chown -R oracle:dba $LOGFOLDER/NodeManagerStart.log
fi

