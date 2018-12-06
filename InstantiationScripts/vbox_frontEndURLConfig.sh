#+++++++++++++++++++++++++++++++++++++++++"
# Script Name  : frontEndURLConfig.sh     "
# Written By   : Timmy Babayeju          +"
# From Company : Fujitsu                 +"
# To  Company  : FSA                     +"
#+++++++++++++++++++++++++++++++++++++++++"

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

if [ $# = 1 ]
then
java weblogic.WLST -loadProperties /tmp/appCSVFolder/inputAppProperties2.csv   vbox_frontEndURLConfig.py  $1  >>/tmp/appPostLaunch/logs/vbox_frontEndURLConfig.log
else
echo "### Incorrect Usage #######" >>/tmp/appPostLaunch/logs/vbox_frontEndURLConfig.log
echo >>/tmp/appPostLaunch/logs/vbox_frontEndURLConfig.log
echo "  Usage : $0 <Console Password>  " >>/tmp/appPostLaunch/logs/vbox_frontEndURLConfig.log
echo >>/tmp/appPostLaunch/logs/vbox_frontEndURLConfig.log
echo "###########################"  >>/tmp/appPostLaunch/logs/vbox_frontEndURLConfig.log
echo "---------------------------"  >>/tmp/appPostLaunch/logs/vbox_frontEndURLConfig.log
fi

