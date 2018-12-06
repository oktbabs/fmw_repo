#+++++++++++++++++++++++++++++++++++++++++++++"
#+++++++++++++++++++++++++++++++++++++++++++++"
#   Script Name :unixMachineConfig_online.py  "
#   Written By: Timmy Babayeju               +"
#   From Company   : Fujitsu                 +"
#   To   Company   : FSA                     +"
#+++++++++++++++++++++++++++++++++++++++++++++"
#+++++++++++++++++++++++++++++++++++++++++++++"

import string
import sys
from datetime import *
dataObj = date(MINYEAR, 1, 1)
todaysDate = dataObj.today()

print "==>> Reading Domain Information from " + DOMAIN_HOME

#print "==>> Reading Domain Information from " + DOMAIN_HOME


URL='t3://' + SERVER1_LISTENADDR + ':' + SERVER1_LISTENPORT

try:
   print ' ==>> CONNECT TO ADMIN SERVER : ' + SERVER1_LISTENADDR
   connect(ADMIN_USERNAME, sys.argv[1], URL)
   print ' ==>> Successfully connected to the ADMIN SERVER : ' + SERVER1_LISTENADDR
except:
   print 'Cannot connect to Admin Server at ' + URL

edit()
startEdit()

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

    a=cd('/Machines/' + machineName + '/NodeManager/' + machineName)
    print " ORIGINAL VALUE : "
    print ' '

    print a.getListenAddress()
    print a.getListenPort()
    print "setting attributes for mbean type NodeManager"
    #set('ListenAddress', machineAddr)
    #set('ListenPort', machinePort)
    a.setListenAddress(machineAddr)
    a.setListenPort(int(machinePort))
    print ' '
    print " LATEST   VALUE : "
    print ' '

    print a.getListenAddress()
    print a.getListenPort()
    

    MACH += 1
  except NameError:
    break
save()
activate()

 
print "==>> Updating the Domain  <<==" 
#updateDomain()
#closeDomain()

print "==>> " + DOMAIN_NAME + " successfully updated" 
