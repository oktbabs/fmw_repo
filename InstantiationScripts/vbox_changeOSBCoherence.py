
#++++++++++++++++++++++++++++++++++++++++++++++
# Script Name  : vbox_changeOSBCoherence.py        + 
# Written By   : Timmy Babayeju               +
# From Company : Fujitsu                      +
# To  Company  : FSA                          +
# Description : Script retrieves the old      +
# Coherence Arguments WKA Addresses for OSB & +
# updates with new Coherence WKA Addreseses   +
# and Ports for servers in the Cluster        +
# Arguments for the OSB cache                 +
#++++++++++++++++++++++++++++++++++++++++++++++

import wlstModule as wlst
import sys
import string
import traceback
from java.io import File
from java.io import FileOutputStream
f=File('/tmp/appPostLaunch/logs/vbox_changeOSBCoherence.log')
fos=FileOutputStream(f)
theInterpreter.setOut(fos)


print "==>> Reading Domain Information from " + DOMAIN_HOME

readDomain(DOMAIN_HOME)

OSBCACHE=1
while true:
  try:
    COHOSBServer=eval('OSB_WKA' + str(OSBCACHE) + '_SERVER')
#    databaseDS=eval('ds' + str(DataS))
    try:
        COHOSBSrv=eval(COHOSBServer)
#        COHOSBServerListAddr=eval('OSB_WKA' + str(OSBCACHE) + '_SERVERLISTENADDR')
#        COHOSBListAddr=eval(COHOSBServerListAddr)
#        COHOSBServerListPort=eval('OSB_WKA' + str(OSBCACHE) + '_SERVERLISTENPORT')
#        COCACHE1=-DOSB.coherence.localhost=sd1oappdu03-osbhost1-vip.fsa.gov.uk -DOSB.coherence.localport=7890 -DOSB.coherence.wka1=sd1oappdu03-osbhost1-vip.fsa.gov.uk -DOSB.coherence.wka1.port=7890 -DOSB.coherence.wka2=sd1oappdu03-osbhost2-vip.fsa.gov.uk -DOSB.coherence.wka2.port=7890
        OSBCACHE1='-Xms:1536m -Xmx:1536m -Xnohup -d64 -DOSB.coherence.localhost=' + OSB_WKA1_SERVERLISTENADDR + ' -DOSB.coherence.localport=' + OSB_WKA1_SERVERLISTENPORT + ' -DOSB.coherence.wka1=' + OSB_WKA1_SERVERLISTENADDR + ' -DOSB.coherence.wka1.port=' + OSB_WKA1_SERVERLISTENPORT + ' -DOSB.coherence.wka2=' + OSB_WKA2_SERVERLISTENADDR + ' -DOSB.coherence.wka2.port=' + OSB_WKA2_SERVERLISTENPORT
        OSBCACHE2='-Xms:1536m -Xmx:1536m -Xnohup -d64 -DOSB.coherence.localhost=' + OSB_WKA2_SERVERLISTENADDR + ' -DOSB.coherence.localport=' + OSB_WKA2_SERVERLISTENPORT + ' -DOSB.coherence.wka1=' + OSB_WKA1_SERVERLISTENADDR  + ' -DOSB.coherence.wka1.port=' + OSB_WKA1_SERVERLISTENPORT  + ' -DOSB.coherence.wka2=' + OSB_WKA2_SERVERLISTENADDR  + ' -DOSB.coherence.wka2.port=' + OSB_WKA2_SERVERLISTENPORT


#        URL1='jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=' + dbRACHost1 + ')(PORT=' + dbRACPort + ')))(CONNECT_DATA=(SERVICE_NAME=' + dbRACServiceName + ')(INSTANCE_NAME=' + dbRACInstanceName1+ ')))'
#        URL2='jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=' + dbRACHost2 + ')(PORT=' + dbRACPort + ')))(CONNECT_DATA=(SERVICE_NAME=' + dbRACServiceName + ')(INSTANCE_NAME=' + dbRACInstanceName2+ ')))'

#        databaseURL=eval('ds' + str(DataS) + '_URL')
#        COHOSBServerListAddr=eval('OSB_WKA' + str(OSBCACHE) + '_SERVERLISTENADDR')
#        COHOSBListAddr=eval(COHOSBServerListAddr)
#        COHOSBServerListPort=eval('OSB_WKA' + str(OSBCACHE) + '_SERVERLISTENPORT')
#        COHOSBSArguments=eval('OSB_WKA' + str(OSBCACHE) + '_ARGS')
#        COHOSBSArgs=eval(COHOSBSArguments)

#        databURL=eval(databaseURL)
        COHOSBSArguments=eval('OSB_WKA' + str(OSBCACHE) + '_ARGS')
        COHOSBSArgs=eval(COHOSBSArguments)
    except NameError, ner:
        print "Required parameter not specified: "
        print ner
        sys.exit(-1)

    print "==> Updating DataSource Info " + str(OSBCACHE) +    ": " + COHOSBServer
    print "            OSB Server           : " + COHOSBSrv
    print "            OSB Listen Address 1 : " + OSB_WKA1_SERVERLISTENADDR
    print "               OSB Listen Port 1 : " + OSB_WKA1_SERVERLISTENPORT
    print "            OSB Listen Address 2 : " + OSB_WKA2_SERVERLISTENADDR
    print "               OSB Listen Port 2 : " + OSB_WKA2_SERVERLISTENPORT

#    print "setting attributes for mbean type Server"
#    a=cd('/JDBCSystemResources/' + databaseDS + '/JDBCResource/' + databaseDS + '/JDBCDriverParams/' + databaseDS)
#    cd('/')
#    a=cd('/JDBCSystemResource/' + databaseDS + '/JdbcResource/' + databaseDS + '/JDBCDriverParams/NO_NAME_0')


    print "setting attributes for mbean type Server"
    a=cd('/Servers/' + COHOSBSrv + '/ServerStart/' + COHOSBSrv)


    print " ORIGINAL VALUE : "
    print ' '
    print a.getArguments()
#    cmo.setUrl(dataBURL)
#    a.setListenAddress(mServerAddr)
    #print a.getdatabaseDS()
    #cmo.getUrl()
    print 'Setting the new values :'
    a.setArguments(COHOSBSArgs)
#    a.setPasswordEncrypted(sys.argv[1])

    print ' '
    print " LATEST   VALUE : "
    print ' '
    print a.getArguments()

    OSBCACHE += 1
  except NameError:
    break

print "==>> Updating the Domain  <<==" 
updateDomain()
closeDomain()

print "==>> " + DOMAIN_NAME + " successfully updated" 
