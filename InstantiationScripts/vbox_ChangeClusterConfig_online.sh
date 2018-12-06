#++++++++++++++++++++++++++++++++++++++++++++++
# Script Name  : vbox_ChangeClusterConfig_online.sh +
# Written By   : Timmy Babayeju               +
# From Company : Fujitsu                      +
# To  Company  : FSA                          +
#++++++++++++++++++++++++++++++++++++++++++++++

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


java weblogic.WLST -loadProperties /tmp/appCSVFolder/inputAppProperties2.csv  vbox_ChangeClusterConfig_online.py $1 

