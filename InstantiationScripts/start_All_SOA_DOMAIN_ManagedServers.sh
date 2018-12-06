
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Script Name  : start_All_SOA_DOMAIN_ManagedServers.sh +
# Written By   : Timmy Babayeju                         +
# From Company : Fujitsu                                +
# To  Company  : FSA                                    +
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#!/bin/sh
#

dos2unix /tmp/appCSVFolder/inputAppProperties.csv
. /tmp/appCSVFolder/inputAppProperties.csv


export JAVA_HOME=/u01/app/oracle/product/jrockit_1.6.0_31
export WL_HOME=/u01/app/oracle/product/fmw/wlserver_10.3
export PATH=$PATH:$JAVA_HOME/bin:$WL_HOME:.

. $WL_HOME/server/bin/setWLSEnv.sh

LOGFOLDER=/tmp/appPostLaunch/logs

myHost=`hostname|cut -d. -f1`

#
## This section tests for Admin Server startup on a single VM
#
if [ "$OCFS_NODE_1_NAME" == "$myHost" ]
then
   echo "${OCFS_NODE_1_NAME}()"
   {
   if [ $# = 1 ]
   then
   java weblogic.WLST -loadProperties /tmp/appCSVFolder/inputAppProperties.csv   start_All_SOA_DOMAIN_ManagedServers.py $1 >>$LOGFOLDER/start_All_SOA_DOMAIN_ManagedServers.log
   else
   echo "### Incorrect Usage #######"  >>$LOGFOLDER/start_All_SOA_DOMAIN_ManagedServers.log
   echo     >>$LOGFOLDER/start_All_SOA_DOMAIN_ManagedServers.log
   echo "  Usage : $0 <Console Password>  "  >>$LOGFOLDER/start_All_SOA_DOMAIN_ManagedServers.log
   echo  >>$LOGFOLDER/start_All_SOA_DOMAIN_ManagedServers.log
   echo "###########################"  >>$LOGFOLDER/start_All_SOA_DOMAIN_ManagedServers.log
   fi
   }
else
echo "++++++++++++++++++++++++++++++++++++++++++"  >>$LOGFOLDER/start_All_SOA_DOMAIN_ManagedServers.log
echo  >>$LOGFOLDER/start_All_SOA_DOMAIN_ManagedServers.log
echo "  Check that the Admin Server is already Running in the Domain "  >>$LOGFOLDER/start_All_SOA_DOMAIN_ManagedServers.log
echo  >>$LOGFOLDER/start_All_SOA_DOMAIN_ManagedServers.log
echo "++++++++++++++++++++++++++++++++++++++++++"  >>$LOGFOLDER/start_All_SOA_DOMAIN_ManagedServers.log
fi


