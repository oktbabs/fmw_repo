

#++++++++++++++++++++++++++++++++++++++++++++"
# Script Name  : vbox_extractSOADomainProduct.sh +"
# Written By   : Timmy Babayeju             +"
# From Company : Fujitsu                    +"
# To  Company  : FSA                       ++"
#++++++++++++++++++++++++++++++++++++++++++++"
# Description  : This script extracts the   +"
# content of the soa_admin.tgz file         +"
# containing the SOA product and SOA domain +"
# folder                                    +" 
#++++++++++++++++++++++++++++++++++++++++++++"

LOGFOLDER=/tmp/appPostLaunch/logs

echo "+++++++++++++++++++++++++++++++++++++"  >$LOGFOLDER/vbox_extractSOADomainProduct.log 
echo "...Changing Directory to / (root) ..."  >>$LOGFOLDER/vbox_extractSOADomainProduct.log 
cd /
echo "...Succcessfully changed directory to / ( root )..."     >>$LOGFOLDER/vbox_extractSOADomainProduct.log 
echo   >>$LOGFOLDER/vbox_extractSOADomainProduct.log 
echo "...Extracting soa_admin.tgz to / ...."     >>$LOGFOLDER/vbox_extractSOADomainProduct.log 
tar -zxvf /u01/soa_admin.tgz
echo   >>$LOGFOLDER/vbox_extractSOADomainProduct.log 
echo "..Successfully extracted soa_admin.tgz to /( root)...."  >>$LOGFOLDER/vbox_extractSOADomainProduct.log 
echo   >>$LOGFOLDER/vbox_extractSOADomainProduct.log 
echo "+++++++++++++++++++++++++++++++++++++"  >>$LOGFOLDER/vbox_extractSOADomainProduct.log 
