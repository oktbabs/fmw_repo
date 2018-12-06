
import string
import sys

print "==>> This script shuts down all " + DOMAIN_NAME + "  Managed Servers " 
#print " Run Date : " + date

URL='t3://' + SERVER1_LISTENADDR + ':' + SERVER1_LISTENPORT

try:
   print ' ==>> CONNECT TO ADMIN SERVER : ' + SERVER1_LISTENADDR
#   connect(ADMIN_USERNAME, ADMIN_USERPWD, 't3://' + SERVER1_LISTENADDR + ':' + SERVER1_LISTENPORT)
   connect(ADMIN_USERNAME, sys.argv[1], URL)
except:
#   print 'Cannot connect to Admin Server at ' + 't3://' + SERVER1_LISTENADDR + ':' + SERVER1_LISTENPORT
   print 'Cannot connect to Admin Server at ' + URL
#   sys.exit(-1)
   print '... Restarting the  Admin Server at ' + URL

   print ' ==>> CONNECT TO NODE MANAGER ON MACHINE1 : ' + NMLISTENADDR1
   nmConnect(ADMIN_USERNAME, sys.argv[1], NMLISTENADDR1, NMLISTENPORT, DOMAIN_NAME, DOMAIN_HOME, NMTYPE)

   print ' ==>> START ADMIN SERVER ON MACHINE1 : ' + NMLISTENADDR1
   nmStart('AdminServer');

   print ' ==>> CONNECT TO ADMIN SERVER : ' + SERVER1_LISTENADDR
   connect(ADMIN_USERNAME, sys.argv[1], URL)
edit()
startEdit()

#MGDSERVER=2
#mServerName=eval('SERVER' + str(MGDSERVER))
#svSt=state(mServerName, 'Server')  

MGDSERVER=2
while true:
  try:
    mServerName=eval('SERVER' + str(MGDSERVER))
#    machineName=eval('MACHINE' + str(MACH))
    try:
        mServerAddr=eval('SERVER' + str(MGDSERVER) + '_LISTENADDR')
        mServerPort=int(eval('SERVER' + str(MGDSERVER) + '_LISTENPORT'))
        mServerMachinePointer=eval('SERVER' + str(MGDSERVER) + '_MACHINE')
        mServerMachine=eval(mServerMachinePointer)
    except NameError, ner:
        print "Required parameter not specified: "
        print ner
        sys.exit(-1)

    print "==> Managed Server           " + str(MGDSERVER) +    ": " + mServerName
    print "                           name: " + mServerName
    print "                     listenAddr: " + mServerAddr
    print "                        machine: " + mServerMachine
    
    print ' '
    try:
#       start(mServerName, 'Server', 't3://' + adminListenAddress + ':' + adminPort);
       state(mServerName, 'Server')=='RUNNING'
       print "Managed Server " + mServerName + " is already in RUNNING state"
       shutdown(block='true')
    except:
       print ' '
       print "Managed Server : " + mServerName + " is not in RUNNING state"

    MGDSERVER += 1
  except NameError:
    break

 
print "==>> Managed Server : " + mServerName + " shutdown successfully  <<==" 


print ' ==>> DISCONNECT FROM THE ADMIN SERVER : ' + SERVER1_LISTENADDR
disconnect();

print ' ==>> DISCONNECT FROM NODE MANAGER ON MACHINE1 : ' + NMLISTENADDR1
nmDisconnect()
