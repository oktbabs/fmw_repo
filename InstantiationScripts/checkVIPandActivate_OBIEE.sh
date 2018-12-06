
#+++++++++++++++++++++++++++++++++++++++++++++++"
# Script Name  : checkVIPandActivate_OBIEE.sh   "
# Written By   : Timmy Babayeju                +"
# From Company : Fujitsu                       +"
# To  Company  : FSA                           +"
#+++++++++++++++++++++++++++++++++++++++++++++++"
# Description  : Script checks if VIPs for VM1 +"
# are ONLINE. If they are not, they are brought+"
# online on VM1. This is OBIE Specific         +"
#+++++++++++++++++++++++++++++++++++++++++++++++"


dos2unix /tmp/appCSVFolder/inputAppProperties.csv
. /tmp/appCSVFolder/inputAppProperties.csv

LOGFOLDER=/tmp/appPostLaunch/logs

myHost=`hostname|cut -d. -f1`

theNetMask=`/sbin/ifconfig |grep Mask: |head -1|awk -F':' '{print $4}'`
grep "SERVER[0-9]*_VIP" /tmp/appCSVFolder/inputAppProperties.csv|awk -F'=' '{print  $2 }'|tail -n +2 >allVIPEntries.txt
#srvNum=`grep "SERVER[0-9]*_VIP" /tmp/appCSVFolder/inputAppProperties.csv|awk -F'=' '{print  $2 }'|wc -l`
m=1
########################################################################
## This section checks if VIPs for VM1 are running in a 2 Node Cluster
#  and brings them up if they are not running.
########################################################################

if [ "$OCFS_NODE_1_NAME" == "$myHost" ]
then
echo "${OCFS_NODE_1_NAME}()"
{

checkVIPandActivate1(){

for r in `cat allVIPEntries.txt`
do 
  echo $r
  s=`/sbin/ip -f inet addr show dev eth0 | grep "$r" | awk -F' ' '{print $1,$2,$7 }'|awk -F'[/ ]' '{print $2}'`
  if [ "$s" != "" ]
  then 
      echo
      echo "Good ... $r ... is already ONLINE .."
      else 
      echo "Really Bad.  $r... is NOT online and it must be ONLINE to continue...."
      echo "=======>>>> Bringing   $r  ..ONLINE ======>>>>...."

      setvip(){
        sudo /sbin/ifconfig eth0:${m} $r netmask $theNetMask
#        sudo /sbin/arping -q -U -c 3 -I eth0 $r
        }
       setvip
      echo
      echo "=======>>>>  $r  ..is now ONLINE ======>>>>...."
      echo
  fi
  if [ $OCFS_NODES_TOTAL -eq 2 ]
  then 
       if [ $m -eq 2 ]
       then
           echo
           echo "... Shutting down eth0:${m} on `hostname` ..."
           sudo /sbin/ifconfig  eth0:${m} down
           echo
           echo "... eth0:${m} successfully shutdown on `hostname` ..."
           echo
      else
          echo
          echo "... This is a single Node or single VM Deployment  on VM1 ..."
          echo "... ALL VIPS for Vertical clusters should be running on 1 server .."
      fi 
    
  fi

m=$(( m + 1))
done
rm -f allVIPEntries.txt
}
checkVIPandActivate1  >>$LOGFOLDER/checkVIPandActivate.log
sudo chown -R oracle:dba /tmp/appCSVFolder/inputAppProperties.csv
sudo chown -R oracle:dba $LOGFOLDER/checkVIPandActivate.log
}

########################################################################
## This section checks if VIPs for VM2 are running in a 2 Node Cluster
#  and brings them up if they are not running.
########################################################################
elif [ "$OCFS_NODE_2_NAME" == "$myHost" ]
then
echo "${OCFS_NODE_2_NAME}()"
{

checkVIPandActivate2(){

for r in `cat allVIPEntries.txt`
do 
  echo $r
  s=`/sbin/ip -f inet addr show dev eth0 | grep "$r" | awk -F' ' '{print $1,$2,$7 }'|awk -F'[/ ]' '{print $2}'`
  if [ "$s" != "" ]
  then 
      echo
      echo "Good ... $r ... is already ONLINE .."
      else 
      echo "Really Bad.  $r... is NOT online and it must be ONLINE to continue...."
      echo "=======>>>> Bringing   $r  ..ONLINE ======>>>>...."

      setvip(){
        sudo /sbin/ifconfig eth0:${m} $r netmask $theNetMask
#        sudo /sbin/arping -q -U -c 3 -I eth0 $r
        }
       setvip
      echo
      echo "=======>>>>  $r  ..is now ONLINE ======>>>>...."
      echo
  fi
    if [ $m -eq 0  -o $m -eq 1 ]
    then
        echo
        echo "... Shutting down eth0:${m} on `hostname` ..."
        sudo /sbin/ifconfig  eth0:${m} down
        echo
        echo "... eth0:${m} successfully shutdown on `hostname` ..."
        echo
   fi

m=$(( m + 1))
done
rm -f allVIPEntries.txt
}
checkVIPandActivate2  >>$LOGFOLDER/checkVIPandActivate.log
sudo chown -R oracle:dba /tmp/appCSVFolder/inputAppProperties.csv
sudo chown -R oracle:dba $LOGFOLDER/checkVIPandActivate.log
}
else
  echo "+++++++++++++++++++++++++++++++++++++++++++++++"
  echo "------>>> Cannot Determine server Name <<<<----"
  echo
  echo "------>>> Cannot Verify or Activate VIPs <<<----"
  echo "+++++++++++++++++++++++++++++++++++++++++++++++"
sudo chown -R oracle:dba /tmp/appCSVFolder/inputAppProperties.csv
sudo chown -R oracle:dba $LOGFOLDER/checkVIPandActivate.log

fi
sudo chown -R oracle:dba /tmp/appCSVFolder/inputAppProperties.csv
sudo chown -R oracle:dba $LOGFOLDER/checkVIPandActivate.log
