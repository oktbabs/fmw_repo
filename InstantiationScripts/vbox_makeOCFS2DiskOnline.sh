
#++++++++++++++++++++++++++++++++++++++++++++++
# Script Name  : vbox_makeOCFS2DiskOnline.sh       +
# Written By   : Timmy Babayeju               +
# From Company : Fujitsu                      +
# To  Company  : FSA                          +
#++++++++++++++++++++++++++++++++++++++++++++++
# Description : Script provisions a new file  +
# system after Template instantiation.        +
# The script does the following on each VM:   +
# 1) format Disk (2) creates OCFS2 Cluster    +
# (3) Configures o2CB Services (4) Makes      +
# OCFS2 filesystem (5) Mounts the filesystem  +
# and (6) Changes filesystem ownership        +
#++++++++++++++++++++++++++++++++++++++++++++++

#!/bin/sh
#dos2unix /tmp/appCSVFolder/inputAppProperties2.csv
#. /tmp/appCSVFolder/inputAppProperties2.csv

dos2unix /home/oracle/appCSVFolder/inputAppProperties2.csv
. /home/oracle/appCSVFolder/inputAppProperties2.csv

LOGFOLDER=/tmp/appPostLaunch/logs
CSVHOME=/home/oracle/appCSVFolder

myHost=`hostname|cut -d. -f1`
myIPAddr=`/sbin/ip addr|grep inet|grep "$NIC1"|awk -F'[/ ]' '{print $6}'`
## This function formats the disk used by the VMs in a cluster
## This function call should only be executed on the first node

echo ${OCFS_DISK_1_NAME}

formatDisk_1(){
/sbin/fdisk ${OCFS_DISK_1_NAME} <<EOF
n
p
1


w
EOF
}

## This function part probes the disk used by the VMs in a cluster
## This function call should only be executed on the second VM
partProbeDisk_2(){
/sbin/partprobe ${OCFS_DISK_2_NAME} <<EOF
n
p
1


w
EOF
}

## This function creates the cluster configuration file
## All the entries are populated from the $CSVHOME/inputAppProperties2.csv
## This function creates the cluster configuration file
## All the entries are populated from the $CSVHOME/inputAppProperties2.csv
## The function call should be executed on the Nodes consituting the filesystem cluster

createClusterFile(){

echo "#"                 >/etc/ocfs2/cluster.conf
echo "## Generated by script : Author - Timmy Babayeju, Fujitsu Limited for FSA"                          >>/etc/ocfs2/cluster.conf
echo "#"                 >>/etc/ocfs2/cluster.conf
echo "cluster:"                          >>/etc/ocfs2/cluster.conf
echo "        node_count = $OCFS_NODES_TOTAL"        >>/etc/ocfs2/cluster.conf
echo "        name = $OCFS_CLUSTER_NAME"                 >>/etc/ocfs2/cluster.conf
for (( n = 1; n <= $OCFS_NODES_TOTAL; n++ ))
do
 if [ $n = 1 ]
 then
    echo "node:"        >>/etc/ocfs2/cluster.conf
    echo "        ip_port = 5555"        >>/etc/ocfs2/cluster.conf
    echo "        ip_address = $OCFS_NODE_1_IPADDR"  >>/etc/ocfs2/cluster.conf
    echo "        number = $n"        >>/etc/ocfs2/cluster.conf
    echo "        name = $OCFS_NODE_1_NAME"        >>/etc/ocfs2/cluster.conf
    echo "        cluster = $OCFS_CLUSTER_NAME"        >>/etc/ocfs2/cluster.conf
 else
    echo "node:"        >>/etc/ocfs2/cluster.conf
    echo "        ip_port = 5555"        >>/etc/ocfs2/cluster.conf
    echo "        ip_address = $OCFS_NODE_2_IPADDR"  >>/etc/ocfs2/cluster.conf
    echo "        number = $n"        >>/etc/ocfs2/cluster.conf
    echo "        name = $OCFS_NODE_2_NAME"        >>/etc/ocfs2/cluster.conf
    echo "        cluster = $OCFS_CLUSTER_NAME"        >>/etc/ocfs2/cluster.conf
 fi
done
}


## This function configures the O2CB service to use the cluster

configureServiceO2CB(){
/sbin/service o2cb configure <<!
y

$OCFS_CLUSTER_NAME




!
}


## This function creates the filesystem on each VM
## This function call should be executed on the 2 VMS

createOCFS_FS1(){
    echo "------"
    echo " ===>>> Creating OCFS2 file system on  ${OCFS_DISK_1_NAME}1 info <<<==="
    echo "------"
/sbin/mkfs.ocfs2 --fs-features=discontig-bg ${OCFS_DISK_1_NAME}1 <<EOF
y
EOF
}

## This function updates the FSTAB entries
## This function call should be executed on the 2 VMS

updateFSTAB_1(){
    echo " ===>>> Updating the /etc/fstab file with ${OCFS_DISK_1_NAME}1 info <<<==="
    echo "------"

    echo "${OCFS_DISK_1_NAME}1 /u01/app/oracle/admin  ocfs2 _netdev,defaults  0 0 " >> /etc/fstab
    echo " ===>>> The /etc/fstab file has been updated with ${OCFS_DISK_1_NAME}1 info <<<==="
    echo "------"
}

updateFSTAB_2(){
    echo " ===>>> Updating the /etc/fstab file with ${OCFS_DISK_2_NAME}1 info <<<==="
    echo "------"

    echo "${OCFS_DISK_2_NAME}1 /u01/app/oracle/admin  ocfs2 _netdev,defaults  0 0 " >> /etc/fstab
    echo " ===>>> The /etc/fstab file has been updated with ${OCFS_DISK_2_NAME}1 info <<<==="
    echo "------"
}


## This function mounts the filesystem for use
## This function call should be executed on the the first VM

mountFS_1(){
    echo "------"
    echo " ===>>> Mounting /u01/app/oracle/admin  on ${OCFS_DISK_1_NAME}1 <<<==="
    echo "------"
    /sbin/mount.ocfs2 ${OCFS_DISK_1_NAME}1 /u01/app/oracle/admin
#    /sbin/mount -a
    echo " ===>>> Successfully mounted  /u01/app/oracle/admin  on ${OCFS_DISK_1_NAME}1 <<<==="
    echo "------"
    }

mountFS_2(){
    echo "------"
    echo " ===>>> Mounting /u01/app/oracle/admin  on ${OCFS_DISK_2_NAME}1 <<<==="
    echo "------"
    /sbin/mount.ocfs2 ${OCFS_DISK_2_NAME}1 /u01/app/oracle/admin
    echo " ===>>> Successfully mounted  /u01/app/oracle/admin  on ${OCFS_DISK_2_NAME}1 <<<==="
    echo "------"
    }

fsChowner(){
    echo "------"
    echo " ===>>> Changing /u01/app/oracle/admin filesystem ownership to oracle:oinstall <<<==="
    sudo chown -R oracle:oinstall /u01
    echo "------"
    }

## This section tests for which steps should be executed on each VM
if [ "$OCFS_NODE_1_NAME" == "$myHost" ]
then
echo "${OCFS_NODE_1_NAME}()"
{
formatDisk_1   >$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
createClusterFile   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
configureServiceO2CB   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
createOCFS_FS1   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
updateFSTAB_1   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
mountFS_1   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
fsChowner   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
echo " --"   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
echo " ===>> Disk management successfully completed on $OCFS_NODE_1_NAME  <<==="   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
echo " --"   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log

chown -R oracle:oinstall $CSVHOME/inputAppProperties2.csv   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
chown -R oracle:oinstall $LOGFOLDER/vbox_makeOCFS2DiskOnline.log
}

elif [ "$OCFS_NODE_2_NAME" == "$myHost" ]
then
echo "${OCFS_NODE_2_NAME}()"
{
partProbeDisk_2   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
createClusterFile   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
configureServiceO2CB   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
updateFSTAB_2   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
mountFS_2   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
fsChowner   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
echo " --"   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
echo " ===>> Disk management successfully completed on $OCFS_NODE_2_NAME  <<==="   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
echo " --"   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
}
else
echo " --"   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
echo " ===>> Cannot mount file system !!. Check File system configuration details on CSV file  <<==="   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
echo " --"   >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
fi

chown -R oracle:oinstall $CSVHOME/inputAppProperties2.csv  >>$LOGFOLDER/vbox_makeOCFS2DiskOnline.log
chown -R oracle:oinstall $LOGFOLDER/vbox_makeOCFS2DiskOnline.log

