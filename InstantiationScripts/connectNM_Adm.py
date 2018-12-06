
#++++++++++++++++++++++++++++++++++++++++++++++
# Script Name  : connectNM_Adm.py             +
# Written By   : Timmy Babayeju               +
# From Company : Fujitsu                      +
# To  Company  : FSA                          +
# Description : Script uses WLST to nmConnect +
# to the Node Manager and user the NodeManager+
# to start the AdminServer for the Domain     +
#++++++++++++++++++++++++++++++++++++++++++++++

import wlstModule as wlst
import sys
import string
import traceback
#from java.io import File
#from java.io import FileOutputStream
#f=File('/tmp/appPostLaunch/logs/connectNM_Adm.log')
#fos=FileOutputStream(f)
#theInterpreter.setOut(fos)


#print ' ==>>> STARTING  NODE MANAGER ON MACHINE ' + nmListenAddress1
#startNodeManager(verbose='true', NodeManagerHome=nmHome, ListenPort=nmListenPort, ListenAddress=nmListenAddress1)
 
#print "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
#print " "
print ' ==>> CONNECTING WLST TO NODEMANGER ON MACHINE ' + NMLISTENADDR1
nmConnect(ADMIN_USERNAME, sys.argv[1], NMLISTENADDR1, NMLISTENPORT, DOMAIN_NAME, DOMAIN_HOME, NMTYPE)
#	print " ===> Starting AdminServer  ... "
#	print " "
print "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
print ' ==>>> STARTING  ADMINSERVER ON MACHINE ' + SERVER1_LISTENADDR
print " "
nmStart(SERVER1)
