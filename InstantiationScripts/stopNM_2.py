
#+++++++++++++++++++++++++++++++++++++++++"
# Script Name  : stopNM_2.py             "
# Written By   : Timmy Babayeju          +"
# From Company : Fujitsu                 +"
# To  Company  : FSA                     +"
#+++++++++++++++++++++++++++++++++++++++++"
# Description : This script allows WLST  +
# to stop  Node Manager on VM2           +
#+++++++++++++++++++++++++++++++++++++++++"

import wlstModule as wlst
import sys
import string
import traceback
#from java.io import File
#from java.io import FileOutputStream
#f=File('/tmp/appPostLaunch/logs/stopNM_2.log')
#fos=FileOutputStream(f)
#theInterpreter.setOut(fos)



print "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
print " "
print ' ==>> CONNECTING WLST TO NODEMANGER ON MACHINE : ' + NMLISTENADDR2
nmConnect(ADMIN_USERNAME, sys.argv[1], NMLISTENADDR2, NMLISTENPORT, DOMAIN_NAME, DOMAIN_HOME, NMTYPE)
print " "
print " "
print "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
print " "
print ' ==>> STOPPING NODEMANGER ON MACHINE : ' + NMLISTENADDR2
stopNodeManager()

