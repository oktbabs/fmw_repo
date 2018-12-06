
#++++++++++++++++++++++++++++++++++++++++++++++
# Script Name  : changeSOACoherence.py        + 
# Written By   : Timmy Babayeju               +
# From Company : Fujitsu                      +
# To  Company  : FSA                          +
# Description : Script retrieves the old      +
# Coherence Arguments WKA Addresses for SOA & + 
# updates with new Coherence WKA Addreseses   +
# and Ports for servers in the Cluster        + 
# Arguments for the SOA cache                 + 
#++++++++++++++++++++++++++++++++++++++++++++++

import wlstModule as wlst
import sys
import string
import traceback
from java.io import File
from java.io import FileOutputStream
f=File('/tmp/appPostLaunch/logs/changeSOACoherence.log')
fos=FileOutputStream(f)
theInterpreter.setOut(fos)


print "==>> Reading Domain Information from " + DOMAIN_HOME

readDomain(DOMAIN_HOME)

SOACACHE=1
while true:
  try:
    COHSOAServer=eval('SOA_WKA' + str(SOACACHE) + '_SERVER')
#    databaseDS=eval('ds' + str(DataS))
    try:
        COHSOASrv=eval(COHSOAServer)
#        COHSOAServerListAddr=eval('SOA_WKA' + str(SOACACHE) + '_SERVERLISTENADDR')
#        COHSOAListAddr=eval(COHSOAServerListAddr)
#        COHSOAServerListPort=eval('SOA_WKA' + str(SOACACHE) + '_SERVERLISTENPORT')
#        COCACHE1=-DOSB.coherence.localhost=sd1oappdu03-osbhost1-vip.fsa.gov.uk -DOSB.coherence.localport=7890 -DOSB.coherence.wka1=sd1oappdu03-osbhost1-vip.fsa.gov.uk -DOSB.coherence.wka1.port=7890 -DOSB.coherence.wka2=sd1oappdu03-osbhost2-vip.fsa.gov.uk -DOSB.coherence.wka2.port=7890
        SOACACHE1='-Xms:1536m -Xmx:1536m -Xnohup -d64 -Dtangosol.coherence.wka1=' + SOA_WKA1_SERVERLISTENADDR + ' -Dtangosol.coherence.wka2=' + SOA_WKA2_SERVERLISTENADDR  + ' -Dtangosol.coherence.localhost=' + SOA_WKA1_SERVERLISTENADDR  + ' -Dtangosol.coherence.localport=' + SOA_WKA1_SERVERLISTENPORT  + ' -Dtangosol.coherence.wka1.port=' + SOA_WKA1_SERVERLISTENPORT  + ' -Dtangosol.coherence.wka2.port=' + SOA_WKA2_SERVERLISTENPORT
        SOACACHE2='-Xms:1536m -Xmx:1536m -Xnohup -d64 -Dtangosol.coherence.wka1=' + SOA_WKA1_SERVERLISTENADDR + ' -Dtangosol.coherence.wka2=' + SOA_WKA2_SERVERLISTENADDR  + ' -Dtangosol.coherence.localhost=' + SOA_WKA2_SERVERLISTENADDR  + ' -Dtangosol.coherence.localport=' + SOA_WKA2_SERVERLISTENPORT   + ' -Dtangosol.coherence.wka1.port=' + SOA_WKA1_SERVERLISTENPORT  + ' -Dtangosol.coherence.wka2.port=' + SOA_WKA2_SERVERLISTENPORT





#        SOACACHE1='-DOSB.coherence.localhost=' + SOA_WKA1_SERVERLISTENADDR + '-DOSB.coherence.localport=' + SOA_WKA1_SERVERLISTENPORT + '-DOSB.coherence.wka1=' + SOA_WKA1_SERVERLISTENADDR + '-DOSB.coherence.wka1.port=' + SOA_WKA1_SERVERLISTENPORT + '-DOSB.coherence.wka2=' + SOA_WKA2_SERVERLISTENADDR + '-DOSB.coherence.wka2.port=' + SOA_WKA2_SERVERLISTENPORT
#        SOACACHE2='-DOSB.coherence.localhost=' + SOA_WKA2_SERVERLISTENADDR + '-DOSB.coherence.localport=' + SOA_WKA2_SERVERLISTENPORT + '-DOSB.coherence.wka1=' + SOA_WKA1_SERVERLISTENADDR  + '-DOSB.coherence.wka1.port=' + SOA_WKA1_SERVERLISTENPORT  + '-DOSB.coherence.wka2=' + SOA_WKA2_SERVERLISTENADDR  + '-DOSB.coherence.wka2.port=' + SOA_WKA2_SERVERLISTENPORT


#        URL1='jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=' + dbRACHost1 + ')(PORT=' + dbRACPort + ')))(CONNECT_DATA=(SERVICE_NAME=' + dbRACServiceName + ')(INSTANCE_NAME=' + dbRACInstanceName1+ ')))'
#        URL2='jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=' + dbRACHost2 + ')(PORT=' + dbRACPort + ')))(CONNECT_DATA=(SERVICE_NAME=' + dbRACServiceName + ')(INSTANCE_NAME=' + dbRACInstanceName2+ ')))'

#        databaseURL=eval('ds' + str(DataS) + '_URL')
#        COHSOAServerListAddr=eval('SOA_WKA' + str(SOACACHE) + '_SERVERLISTENADDR')
#        COHSOAListAddr=eval(COHSOAServerListAddr)
#        COHSOAServerListPort=eval('SOA_WKA' + str(SOACACHE) + '_SERVERLISTENPORT')
#        COHSOASArguments=eval('SOA_WKA' + str(SOACACHE) + '_ARGS')
#        COHSOASArgs=eval(COHSOASArguments)

#        databURL=eval(databaseURL)
        COHSOASArguments=eval('SOA_WKA' + str(SOACACHE) + '_ARGS')
        COHSOASArgs=eval(COHSOASArguments)
    except NameError, ner:
        print "Required parameter not specified: "
        print ner
        sys.exit(-1)

    print "==> Updating Coherence  Info " + str(SOACACHE) +    ": " + COHSOAServer
    print "            OSB Server           : " + COHSOASrv
    print "            OSB Listen Address 1 : " + SOA_WKA1_SERVERLISTENADDR
    print "               OSB Listen Port 1 : " + SOA_WKA1_SERVERLISTENPORT
    print "            OSB Listen Address 2 : " + SOA_WKA2_SERVERLISTENADDR
    print "               OSB Listen Port 2 : " + SOA_WKA2_SERVERLISTENPORT

#    print "setting attributes for mbean type Server"
#    a=cd('/JDBCSystemResources/' + databaseDS + '/JDBCResource/' + databaseDS + '/JDBCDriverParams/' + databaseDS)
#    cd('/')
#    a=cd('/JDBCSystemResource/' + databaseDS + '/JdbcResource/' + databaseDS + '/JDBCDriverParams/NO_NAME_0')


    print "setting attributes for mbean type Server"
    a=cd('/Servers/' + COHSOASrv + '/ServerStart/' + COHSOASrv)


    print " ORIGINAL VALUE : "
    print ' '
    print a.getArguments()
#    cmo.setUrl(dataBURL)
#    a.setListenAddress(mServerAddr)
    #print a.getdatabaseDS()
    #cmo.getUrl()
    print 'Setting the new values :'
    a.setArguments(COHSOASArgs)
#    a.setPasswordEncrypted(sys.argv[1])

    print ' '
    print " LATEST   VALUE : "
    print ' '
    print a.getArguments()

    SOACACHE += 1
  except NameError:
    break

print "==>> Updating the Domain  <<==" 
updateDomain()
closeDomain()

print "==>> " + DOMAIN_NAME + " successfully updated" 
