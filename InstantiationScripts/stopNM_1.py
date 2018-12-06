

#+++++++++++++++++++++++++++++++++++++++++"
# Script Name  : stopNM_1.py             "
# Written By   : Timmy Babayeju          +"
# From Company : Fujitsu                 +"
# To  Company  : FSA                     +"
#+++++++++++++++++++++++++++++++++++++++++"
# Description : This script allows WLST  +
# to stop  Node Manager on VM1           +
#+++++++++++++++++++++++++++++++++++++++++"

import wlstModule as wlst
import sys
import os
import string
import traceback
#from java.io import File
#from java.io import FileOutputStream
#f=File('/tmp/appPostLaunch/logs/stopNM_1.log')
#fos=FileOutputStream(f)
#theInterpreter.setOut(fos)


print "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
print " "
print ' ==>> CONNECTING WLST TO NODEMANGER ON MACHINE : ' + NMLISTENADDR1
nmConnect(ADMIN_USERNAME, sys.argv[1], NMLISTENADDR1, NMLISTENPORT, DOMAIN_NAME, DOMAIN_HOME, NMTYPE)
print " "
print " "
print "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
print " "
print ' ==>> STOPPING NODEMANGER ON MACHINE : ' + NMLISTENADDR1
stopNodeManager()

