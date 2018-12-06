
#+++++++++++++++++++++++++++++++++++++++++"
# Script Name  : startNM_1.py             "
# Written By   : Timmy Babayeju          +"
# From Company : Fujitsu                 +"
# To  Company  : FSA                     +"
#+++++++++++++++++++++++++++++++++++++++++"
# Description : This script allows WLST  +
# to start Node Manager on VM1           +
#+++++++++++++++++++++++++++++++++++++++++"

import wlstModule as wlst
import sys
import string
import traceback


print ' ==>>> STARTING  NODE MANAGER ON MACHINE ' + NMLISTENADDR1
startNodeManager(verbose='true', NodeManagerHome=NMHOME, ListenPort=NMLISTENPORT, ListenAddress=NMLISTENADDR1)
 
print "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
print " "
#print ' ==>> CONNECTING WLST TO NODEMANGER ON MACHINE ' + nmListenAddress1
#nmConnect(adminUsername, adminPassword, nmListenAddress1, nmListenPort, domainName, domainDir, nmType)
