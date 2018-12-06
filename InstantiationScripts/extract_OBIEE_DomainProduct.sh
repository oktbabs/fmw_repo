

#++++++++++++++++++++++++++++++++++++++++++++++++"
# Script Name  : extract_OBIEE_DomainProduct.sh +"
# Written By   : Timmy Babayeju                 +"
# From Company : Fujitsu                        +"
# To  Company  : FSA                           ++"
#++++++++++++++++++++++++++++++++++++++++++++++++"
# Description  : This script extracts the   +++++"
# content of the OBIEE Tarballs. It extracts  +++"
# them to the appropriate fileystems        +++++"
#++++++++++++++++++++++++++++++++++++++++++++++++"
#!/bin/sh

dos2unix /tmp/appCSVFolder/inputAppProperties.csv
. /tmp/appCSVFolder/inputAppProperties.csv


LOGFOLDER=/tmp/appPostLaunch/logs
myHost=`hostname|cut -d. -f1`
   
extractionInfo(){  
       echo " ===>> Changing directory to $FOLDER "
       echo 
       cd $FOLDER
       echo 
       echo " Successfully Changed directory to $FOLDER "
       echo 
       echo " Extracting $mytar to  $FOLDER "
       echo 
       tar -zxvf  $mytar
       echo " Successfully Changed directory to $FOLDER "
       echo " ===>> Changing directory to $FOLDER "
}


###################################################################
## This section checks if the OBIEE tarball 
#  will be extracted to  VM1 OR  VM2.
###################################################################

if [ "$OCFS_NODE_1_NAME" == "$myHost" ]
then
   echo "${OCFS_NODE_1_NAME}()"
   {
      for a in ADMINFOLDER  ASERVERFOLDER  MSERVERFOLDER1
      do
        if [ $a == "ADMINFOLDER" ]
        then
             FOLDER=/u01/app/oracle/admin
             mytar=/u01/obi_admin.tgz
      extractionInfo  >>$LOGFOLDER/extract_OBIEE_DomainProduct.log
        elif [ $a == "ASERVERFOLDER" ]
        then
             FOLDER=/u01/app/oracle/admin/obi_domain/aserver
             mytar=/u01/obi_aserver.tgz
      extractionInfo  >>$LOGFOLDER/extract_OBIEE_DomainProduct.log
        elif [ $a ==  "MSERVERFOLDER1" ]
        then
             FOLDER=/u01/app/oracle/admin/obi_domain/mserver
             mytar=/u01/obi_mserver_host1.tgz
      extractionInfo  >>$LOGFOLDER/extract_OBIEE_DomainProduct.log
        else
          echo "====>>> NOTHING TO DO <<<<==="
        fi
      done
   }
elif [ "$OCFS_NODE_2_NAME" == "$myHost" ]
then
echo "${OCFS_NODE_2_NAME}()"
  {
      for r in MSERVERFOLDER2
      do
        if [ $r ==  "MSERVERFOLDER2" ]
        then
             FOLDER=/u01/app/oracle/admin/obi_domain/mserver
             mytar=/u01/obi_mserver_host2.tgz
      extractionInfo  >>$LOGFOLDER/extract_OBIEE_DomainProduct.log
        else
          echo "====>>> NOTHING TO DO <<<<==="
        fi
      done
   }
 else
            echo  >>$LOGFOLDER/extract_OBIEE_DomainProduct.log
            echo "=====>>>!!! Ensure that the Servers are  available!! <<<<===="
            echo "=====>>> Ensure that the filesystems are mounted          <<<<===="
            echo  >>$LOGFOLDER/extract_OBIEE_DomainProduct.log
fi
chown -R oracle:dba /u01
