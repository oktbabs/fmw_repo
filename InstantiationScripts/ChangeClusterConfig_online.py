
#++++++++++++++++++++++++++++++++++++++++++++++
# Script Name  : vbox_ChangeClusterConfig_online.py+ 
# Written By   : Timmy Babayeju               +
# From Company : Fujitsu                      +
# To  Company  : FSA                          +
#++++++++++++++++++++++++++++++++++++++++++++++

import string
import sys
from datetime import *
dataObj = date(MINYEAR, 1, 1)
todaysDate = dataObj.today()

print "==>> Reading Domain Information from " + DOMAIN_HOME

#readDomain(DOMAIN_HOME)
URL='t3://' + SERVER1_LISTENADDR + ':' + SERVER1_LISTENPORT

try:
   print ' ==>> CONNECT TO ADMIN SERVER : ' + SERVER1_LISTENADDR
   connect(ADMIN_USERNAME, sys.argv[1], URL)
except:
   print 'Cannot connect to Admin Server at ' + URL

edit()
startEdit()


CLUST=1
while true:
  try:
    mClusterName=eval('CLUSTER' + str(CLUST))
    try:
        mClustServAdr1=eval('CLUSTER' + str(CLUST)+ '_SERVER1ADDR')
        mClusterServAddr1=eval(mClustServAdr1)
        mClusterServPort1=eval('CLUSTER' + str(CLUST)+ '_SERVER1PORT')
        mClustSrvPort1=eval(mClusterServPort1)
        mClustServAdr2=eval('CLUSTER' + str(CLUST)+ '_SERVER2ADDR')
        mClusterServAddr2=eval(mClustServAdr2)
        mClustSrvPort2=eval('CLUSTER' + str(CLUST)+ '_SERVER2PORT')
        mClustSrvPort2=eval(mClustSrvPort2)
#        mClusterMachine=eval(mClusterMachinePointer)
    except NameError, ner:
        print "Required parameter not specified: "
        print ner
        sys.exit(-1)

    print "==> Updating Cluster Information " + str(CLUST) +    ": " + mClusterName
    print "              Cluster Server Listen Address1 : " + mClusterServAddr1
    print "                 Cluster Server Listen port1 : " + mClustSrvPort1
    print "              Cluster Server Listen Address2 : " + mClusterServAddr2
    print "                 Cluster Server Listen port2 : " + mClustSrvPort2
#    print "                     listenAddr: " + mClusterAddr
#    print "                        machine: " + mClusterMachine

    print "setting attributes for mbean type Server"
    cd('/')
    a=cd('/Clusters/' + mClusterName)
#    cd('/Cluster/' + mClusterName)
    print '################'
    print ' '
    print " Initial Cluster Info  "
    print " ----------------------"
#    print a.getName()
    print a.getClusterAddress()
#    cmo.getClusterAddress()
#    print a.getMachine()
    print "   Setting New Info    "
    print "   --------------------"
    a.setClusterAddress(mClusterServAddr1+':'+ mClustSrvPort1 +', ' + mClusterServAddr2 + ':' + mClustSrvPort2)
#    a.set('ClusterAddress', mClusterServAddr1+":"+ mClustSrvPort1 +", " + mClusterServAddr2 + ":" + mClustSrvPort2)
#    a.set('ClusterAddress', mClusterAddr)
#    print cmo.set('ClusterAddress', mClusterAddr)
    print " Final Cluster Info"
    print " ------------------"
#    print a.getName()
    print a.getClusterAddress()
#    cmo.getClusterAddress()

    print '################'

    CLUST += 1
  except NameError:
    break

save()
activate()

print "==>> Updating the Domain  <<==" 
#updateDomain()
#closeDomain()

print "==>> " + DOMAIN_NAME + " successfully updated" 
