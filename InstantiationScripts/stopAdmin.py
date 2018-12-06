
#+++++++++++++++++++++++++++++++++++++++++
# Script Name  : stopAdmin.py            +
# Written By   : Timmy Babayeju          +
# From Company : Fujitsu                 +
# To  Company  : FSA                     +
#+++++++++++++++++++++++++++++++++++++++++
import wlstModule as wlst
import sys
import string
import traceback

#print ' ==>>> STARTING  NODE MANAGER ON MACHINE ' + nmListenAddress1
#startNodeManager(verbose='true', NodeManagerHome=nmHome, ListenPort=nmListenPort, ListenAddress=nmListenAddress1)
 
#print "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
#print " "
print ' ==>> CONNECTING WLST TO NODEMANGER ON MACHINE ' + NMLISTENADDR1
nmConnect(ADMIN_USERNAME, sys.argv[1], NMLISTENADDR1, NMLISTENPORT, DOMAIN_NAME, DOMAIN_HOME, NMTYPE)
#	print " ===> Starting AdminServer  ... "
#	print " "
print "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
print ' ==>>> SHUTTING DOWN ADMINSERVER ON MACHINE ' + SERVER1_LISTENADDR
print " "
nmKill(SERVER1)
print " "
print ' ==>>> SHUTTING DOWN ADMINSERVER ON MACHINE ' + SERVER1_LISTENADDR + ' completed successfully'
