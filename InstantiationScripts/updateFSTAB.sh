
#+++++++++++++++++++++++++++++++++++++++++"
# Script Name  : vbox_updateFSTAB.sh          +"
# Written By   : Timmy Babayeju          +"
# From Company : Fujitsu                 +"
# To  Company  : FSA                     +"
#+++++++++++++++++++++++++++++++++++++++++"
#!/bin/sh
dos2unix inputAppProperties2.*
. inputAppProperties2.csv

## This function updates the FSTAB entries
## This function call should be executed on the 2 VMS

#sd1oappdu15(){
$OCFS_NODE_1_NAME(){
echo "......Adding /dev/xvdc1 entry to /etc/fstab file ..." 
echo "/dev/xvdc1 /u01/app/oracle/admin  ocfs2 _netdev,defaults  0 0 " >> /etc/fstab
echo
echo "...... /dev/xvdc1 entry successfully added to /etc/fstab file ..." 

}

#sd1oappdu16(){
$OCFS_NODE_2_NAME(){
echo "......Adding /dev/xvdc2 entry to /etc/fstab file ..." 
echo "/dev/xvdc2 /u01/app/oracle/admin  ocfs2 _netdev,defaults  0 0 " >> /etc/fstab
echo
echo "...... /dev/xvdc2 entry successfully added to /etc/fstab file ..." 

}

echo " Updating the /etc/fstab file on  $HOSTNAME"
HOSTNAME=$(hostname)
theNode=$(echo $HOSTNAME|cut -c10-11)
sd1oappdu${theNode}

