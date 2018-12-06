#++++++++++++++++++++++++++++++++++++++++++++++++++
# Script Name :unixMachineConfig_OBIE.py      +++++
# Written By: Timmy Babayeju                      +
# From Company   : Fujitsu                        +
# To   Company   : FSA                            +
#+++++++++++++++++++++++++++++++++++++++++++++++++"
#       DESCRIPTION                              +"
#+++++++++++++++++++++++++++++++++++++++++++++++++"
# This is an OBIEE specific script that retrieves + 
#  the old Machine ListenAddress and Ports from   + 
# the old VMs and replaces them with the New      + 
#Machine Listen Addresses and Ports associated    + 
#with the new VMs                                 +
#++++++++++++++++++++++++++++++++++++++++++++++++++

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
#
    print "==> Updating machine " + str(MACH) +    ": " + machineName
    print "                                  name   : " + machineName
    print "                         listenAddress   : " + machineAddr
    print "                                  port   : " + machinePort
#
    print " ...Changing to NodeManager directory .."
#        a=cd('/AnyMachine/' + machineName + '/NodeManager' + '/NodeManager/' + machineName)
    a=cd('/AnyMachine/' + machineName + '/NodeManager/NodeManager/')
#        cmo.getListenAddress()
#        cmo.getListenPort()
    print " ...ORIGINAL VALUES  .."
    print " ---------------------."
    print a.getListenAddress()
    print a.getListenPort()
    print
    print "setting attributes for mbean type NodeManager"
    print "---------------------------------------------"
    #set('ListenAddress', machineAddr)
    #set('ListenPort', machinePort)
    a.setListenAddress(machineAddr)
    a.setListenPort(int(machinePort))
    print
    print " ...NEW VALUES      .."
    print " --------------------."
    print a.getListenAddress()
    print a.getListenPort()
    

    MACH += 1
  except NameError:
    break

 
  print "==>> Updating the Domain  <<==" 
updateDomain()
closeDomain()

print "==>> " + DOMAIN_NAME + " successfully updated" 
