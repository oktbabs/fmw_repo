#++++++++++++++++++++++++++++++++++++++++++++++
# Script Name  : jdbcDatasourceConfig.sh      +
# Written By   : Timmy Babayeju               +
# From Company : Fujitsu                      +
# To  Company  : FSA                          +
#++++++++++++++++++++++++++++++++++++++++++++++

#!/bin/sh
#
export JAVA_HOME=/u01/app/oracle/product/jrockit_1.6.0_31
export WL_HOME=/u01/app/oracle/product/fmw/wlserver_10.3
export PATH=$PATH:$JAVA_HOME/bin:$WL_HOME:.

. $WL_HOME/server/bin/setWLSEnv.sh



if [ $# = 1 ]
then
java weblogic.WLST -loadProperties /tmp/appCSVFolder/inputAppProperties.csv  jdbcDatasourceConfig.py $1 >>/tmp/appPostLaunch/logs/jdbcDatasourceConfig.log
else
echo "### Incorrect Usage #######"  >>/tmp/appPostLaunch/logs/jdbcDatasourceConfig.log
echo
echo "  Usage : $0 <Database Password>  "  >>/tmp/appPostLaunch/logs/jdbcDatasourceConfig.log
echo  >>/tmp/appPostLaunch/logs/jdbcDatasourceConfig.log
echo "###########################"  >>/tmp/appPostLaunch/logs/jdbcDatasourceConfig.log
fi

