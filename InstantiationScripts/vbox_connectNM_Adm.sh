
#+++++++++++++++++++++++++++++++++++++++++
# Script Name  : vbox_connectNM_Adm.sh        +
# Written By   : Timmy Babayeju          +
# From Company : Fujitsu                 +
# To  Company  : FSA                     +
#+++++++++++++++++++++++++++++++++++++++++

#!/bin/sh
#
dos2unix inputAppProperties2.*
. /tmp/appCSVFolder/inputAppProperties2.csv

#export JAVA_HOME=/u01/app/oracle/product/jrockit_1.6.0_31
#export WL_HOME=/u01/app/oracle/product/fmw/wlserver_10.3
#export PATH=$PATH:$JAVA_HOME/bin:$WL_HOME:.

export JAVA_HOME=$JAVA_HOME
export WL_HOME=$WL_HOME
export PATH=$PATH

. $WL_HOME/server/bin/setWLSEnv.sh

LOGFOLDER=/tmp/appPostLaunch/logs

myHost=`hostname|cut -d. -f1`

## This section tests for Admin Server startup on a single VM
if [ "$OCFS_NODE_1_NAME" == "$myHost" ]
then
#sd1oappdu15(){
echo "${OCFS_NODE_1_NAME}()"
{


if [ $# = 1 ]
then
java weblogic.WLST -loadProperties /tmp/appCSVFolder/inputAppProperties2.csv   vbox_connectNM_Adm.py $1  >>$LOGFOLDER/vbox_connectNM_Adm.log
else
echo "### Incorrect Usage #######"  >>$LOGFOLDER/vbox_connectNM_Adm.log
echo  >>$LOGFOLDER/vbox_connectNM_Adm.log
echo "  Usage : $0 <Console Password>  "  >>/tmp/appPostLaunch/logs/vbox_connectNM_Adm.log
echo  >>$LOGFOLDER/vbox_connectNM_Adm.log
echo "###########################"  >>$LOGFOLDER/vbox_connectNM_Adm.log
fi

}
else
echo "++++++++++++++++++++++++++++++++++++++++++"  >>$LOGFOLDER/vbox_connectNM_Adm.log
echo  >>$LOGFOLDER/vbox_connectNM_Adm.log
echo "  Only One Admin Server can run iat a time per domain"  >>$LOGFOLDER/vbox_connectNM_Adm.log
echo  >>$LOGFOLDER/vbox_connectNM_Adm.log
echo "++++++++++++++++++++++++++++++++++++++++++"  >>$LOGFOLDER/vbox_connectNM_Adm.log
fi
