
#++++++++++++++++++++++++++++++++++++++++++++++
# Script Name  : serverListenAddressConfig.py + 
# Written By   : Timmy Babayeju               +
# From Company : Fujitsu                      +
# To  Company  : FSA                          +
# Description : Script retrieves the old      +
# Server  ListenAddress and Ports from the old+
# VMs and replaces them with the New  Server  +
# Listen Addresses and ports associated with  +
# the new VM/VMs                              +
#++++++++++++++++++++++++++++++++++++++++++++++

import wlstModule as wlst
import sys
import string
import traceback
from java.io import File
from java.io import FileOutputStream
f=File('/tmp/appPostLaunch/logs/serverListenAddressConfig.log')
fos=FileOutputStream(f)
theInterpreter.setOut(fos)

print "==>> Reading Domain Information from " + DOMAIN_HOME

readDomain(DOMAIN_HOME)

MGDSERVER=1
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

    print "==> Updating Managed Server  " + str(MGDSERVER) +    ": " + mServerName
    print "                           name: " + mServerName
    print "                     listenAddr: " + mServerAddr
    print "                        machine: " + mServerMachine

    print "setting attributes for mbean type Server"
    a=cd('/Server/' + mServerName)
    print '################'
    print a.getListenPort()
    print a.getListenAddress()
#    print a.getMachine()
    a.setListenPort(mServerPort)
    a.setListenAddress(mServerAddr)
    print a.getListenPort()
    print a.getListenAddress()

    print '################'
#    bean = getMBean("/AnyMachine/" + mServerMachine)
#    cmo.setMachine(bean)
    assign('Server',mServerName,'Machine',mServerMachine)
    MGDSERVER += 1
  except NameError:
    break

  print "==>> Updating the Domain  <<==" 
updateDomain()
closeDomain()

print "==>> " + DOMAIN_NAME + " successfully updated" 
