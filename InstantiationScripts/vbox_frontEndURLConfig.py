
#+++++++++++++++++++++++++++++++++++++"
# Script Name :vbox_frontEndURLConfig.py   "
# Written By: Timmy Babayeju         +"
# From Company   : Fujitsu           +"
# To   Company   : FSA               +"
# Description : This script sets     +"
# the Front End URL so that the     ++"
# weblogic servers can be accessed  ++"
# from the Web Tier Interface       ++"
#+++++++++++++++++++++++++++++++++++++"

import wlstModule as wlst
import string
import sys
import traceback
from java.io import File
from java.io import FileOutputStream
f=File('/tmp/appPostLaunch/logs/vbox_frontEndURLConfig.log')
fos=FileOutputStream(f)
theInterpreter.setOut(fos)
from datetime import *
dataObj = date(MINYEAR, 1, 1)
todaysDate = dataObj.today()

print "==>> This script sets the frontEnd URL on the Weblogic Admin Server"
#print " Run Date : " + todaysDate
print date.today()

URL='t3://' + SERVER1_LISTENADDR + ':' + SERVER1_LISTENPORT

try:
   print ' ==>> CONNECT TO ADMIN SERVER : ' + SERVER1_LISTENADDR
   connect(ADMIN_USERNAME, sys.argv[1], URL)
except:
   print 'Cannot connect to Admin Server at ' + URL

edit()
startEdit()
cd('Servers/' + SERVER1 + '/WebServer/' + SERVER1)
print ' '
print " Previous FronEnd Attributes are as follows :"
print " -------------------------------------------- "
print  get('FrontendHost')
print  get('FrontendHTTPPort')
print  get('FrontendHTTPSPort')

print ' '
print " Setting FronEnd Attributes to the following :"
print " -------------------------------------------- "
print ' '
set('FrontendHost', FRONTENDHOST)
set('FrontendHTTPPort', FRONTENDHTTPPORT)
set('FrontendHTTPSPort', FRONTENDHTTPSPORT)
print  get('FrontendHost')
print  get('FrontendHTTPPort')
print  get('FrontendHTTPSPort')

print ' '
save()
activate()

print "==>>  FRONTEND SERVER information for " + DOMAIN_NAME + " successfully completed. " 
