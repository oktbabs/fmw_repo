#++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Script Name  : start_All_SOA_DOMAIN_ManagedServers.py +
# Written By   : Timmy Babayeju                         +
# From Company : Fujitsu                                +
# To  Company  : FSA                                    +
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++

import string
import sys
#from java.io import File
#from java.io import FileOutputStream
#f=File('/tmp/appPostLaunch/logs/start_All_SOA_DOMAIN_ManagedServers.log')
#fos=FileOutputStream(f)
#theInterpreter.setOut(fos)


print "==>> This script starts all " + DOMAIN_NAME + "  Managed Servers " 
#print " Run Date : " + date

URL='t3://' + SERVER1_LISTENADDR + ':' + SERVER1_LISTENPORT

try:
   print ' ==>> CONNECT TO ADMIN SERVER : ' + SERVER1_LISTENADDR
   connect(ADMIN_USERNAME, sys.argv[1], URL)
except:
   print 'Cannot connect to Admin Server at ' + URL
   sys.exit(-1)
  

MGDSERVER=2
while true:
  try:
    mServerName=eval('SERVER' + str(MGDSERVER))
    try:
        mServerAddr=eval('SERVER' + str(MGDSERVER) + '_LISTENADDR')
        mServerPort=int(eval('SERVER' + str(MGDSERVER) + '_LISTENPORT'))
        mServerMachinePointer=eval('SERVER' + str(MGDSERVER) + '_MACHINE')
        mServerMachine=eval(mServerMachinePointer)
    except NameError, ner:
        print "Required parameter not specified: "
        print ner
        sys.exit(-1)

    print "==> Starting Managed Server  " + str(MGDSERVER) +    ": " + mServerName
    print "                           name: " + mServerName
    print "                     listenAddr: " + mServerAddr
    print "                        machine: " + mServerMachine
    
    print ' '
    try:
       svSt=state(mServerName, 'Server')
       if svSt=='RUNNING': 
          print "Managed Server " + mServerName + "is already in " + svSt + " state "
       else:
          print ' '
          print "Starting Managed Server : " + mServerName
          start(mServerName, 'Server', URL)
          print "==                                               ==" 
          print "==>> Started " + mServerName + " successfully  <<==" 
          print "==                                               ==" 
    except:
       print "Cannot Start Managed Server : " + mServerName
    MGDSERVER += 1
  except NameError:
    break


print ' ==>> DISCONNECT FROM THE ADMIN SERVER : ' + SERVER1_LISTENADDR
disconnect();

nmDisconnect()

