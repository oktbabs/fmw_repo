#+++++++++++++++++++++++++++++++++++++++++++++"
#++++++++++++++++++++++++++++++++++++++++++++++
# Script Name :unixMachineConfig.py           +
# Written By: Timmy Babayeju                  +
# From Company   : Fujitsu                    +
# To   Company   : FSA                        +
# Description : Script retrieves the old      +
# Machine ListenAddress and Ports from the old+
# VMs and replaces them with the New Machine  +
# Listen Addresses and ports associated with  +
# the new VMs                                 +
#++++++++++++++++++++++++++++++++++++++++++++++

import wlstModule as wlst
import sys
import string
import traceback
from java.io import File
from java.io import FileOutputStream
f=File('/tmp/appPostLaunch/logs/unixMachineConfig.log')
fos=FileOutputStream(f)
theInterpreter.setOut(fos)


print "==>> Reading Domain Information from " + DOMAIN_HOME

readDomain(DOMAIN_HOME)
MACH=1
while true:
  try:
    machineName=eval('MACHINE' + str(MACH))
    try:
        machineAddr=eval('MACHINE' + str(MACH) + '_NMLISTENADDR')
        machinePort=eval('MACHINE' + str(MACH) + '_NMLISTENPORT')
    except NameError, ner:
        print "Required parameter not specified: "
        print ner
        sys.exit(-1)

    print "==> Updating machine " + str(MACH) +    ": " + machineName
    print "                                  name   : " + machineName
    print "                         listenAddress   : " + machineAddr
    print "                                  port   : " + machinePort

    a=cd('/AnyMachine/' + machineName + '/NodeManager/' + machineName)
    print a.getListenAddress()
    print a.getListenPort()
    print "setting attributes for mbean type NodeManager"
    #set('ListenAddress', machineAddr)
    #set('ListenPort', machinePort)
    a.setListenAddress(machineAddr)
    a.setListenPort(int(machinePort))
    print a.getListenAddress()
    print a.getListenPort()
    

    MACH += 1
  except NameError:
    break

 
  print "==>> Updating the Domain  <<==" 
updateDomain()
closeDomain()

print "==>> " + DOMAIN_NAME + " successfully updated" 
