
unzip linuxx64_12201_database.zip -d /media/LINUX_ORASOFT/12C_Response_Folder/V46095_DB_12c_121020

Configure Tuned as described in House of Brick’s blog post (Tuned is installed by default on RHEL7).
At this point, we are ready to begin the initial software installation. As the downloaded file was unzipped, a directory called database was created under your current directory.

Cd to the ./database/response directory.
Copy the db_install.rsp file to the ./database directory. In my case, it will be copied from /home/oracle/database/response directory to /home/oracle/database
Modify the following lines (only) to read as follows (or customize for your environment) in the file /home/oracle/database/db_install.rsp:
oracle.install.option=INSTALL_DB_SWONLY
 UNIX_GROUP_NAME=oinstall
 INVENTORY_LOCATION=/u01/app/oraInventory
 ORACLE_HOME=/u01/app/oracle/product/12.2.0.1/dbhome_1
 ORACLE_BASE=/u01/app/oracle
 oracle.install.db.InstallEdition=EE
 oracle.install.db.OSDBA_GROUP=dba
 oracle.install.db.OSOPER_GROUP=dba
 oracle.install.db.OSBACKUPDBA_GROUP=dba
 oracle.install.db.OSDGDBA_GROUP=dba
 oracle.install.db.OSKMDBA_GROUP=dba
 oracle.install.db.OSRACDBA_GROUP=dba
 oracle.install.db.OSRACDBA_GROUP=dba
 SECURITY_UPDATES_VIA_MYORACLESUPPORT=false
 DECLINE_SECURITY_UPDATES=true
 

After making the changes to the db_install.rsp file, you are ready to run the Oracle installation. The command to run the Oracle home in silent mode (running from the database directory) is:
./runInstaller -silent -responseFile
/home/oracle/database/db_install.rsp
 
