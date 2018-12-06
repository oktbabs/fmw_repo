set -x
. /home/oracle/templates_db/dmp/soa_inputAppProperties.csv
. /home/oracle/$dbOracleDB.env

export ORAENV_ASK=NO

. oraenv

echo $ORACLE_HOME

myHost=`hostname|cut -d. -f1`

if [ "$OCFS_NODE_1_NAME" == "$myHost" ]
then
echo "${OCFS_NODE_1_NAME}()"
{

exit|sqlplus "/ as sysdba" @$dbMetadataFile $1 

exit|sqlplus "/ as sysdba" @/home/oracle/templates_db/dmp/create_import_directory.sql

impdp  \"/ as sysdba\" full=y file=/home/oracle/templates_db/dmp/$dbSchemaDataFile directory=import_dump log=/tmp/imp.log 

exit|sqlplus "sys as sysdba" @$ORACLE_HOME/rdbms/admin/utlrp.sql

exit|sqlplus "sys as sysdba" @reset_soa_queue.sql

exit|sqlplus "/ as sysdba" @/home/oracle/templates_db/dmp/drop_import_directory.sql
}
else
echo ..."Nothing to do"
fi
