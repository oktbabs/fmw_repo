
#++++++++++++++++++++++++++++++++++++++++++++++
# Script Name  : jdbcDatasourceConfig.py      + 
# Written By   : Timmy Babayeju               +
# From Company : Fujitsu                      +
# To  Company  : FSA                          +
#++++++++++++++++++++++++++++++++++++++++++++++

import string
import sys
from datetime import *
dataObj = date(MINYEAR, 1, 1)
todaysDate = dataObj.today()

print "==>> CONNECT TO ADMINSERVER FOR " + DOMAIN_HOME

#readDomain(DOMAIN_HOME)

URL='t3://' + SERVER1_LISTENADDR + ':' + SERVER1_LISTENPORT

try:
   print ' ==>> CONNECT TO ADMIN SERVER : ' + SERVER1_LISTENADDR
   connect(ADMIN_USERNAME, sys.argv[1], URL)
except:
   print 'Cannot connect to Admin Server at ' + URL

edit()
startEdit()

DataS=1
while true:
  try:
    databaseDS=eval('ds' + str(DataS))
    try:
        URL1='jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=' + dbRACHost1 + ')(PORT=' + dbRACPort + ')))(CONNECT_DATA=(SERVICE_NAME=' + dbRACServiceName + ')(INSTANCE_NAME=' + dbRACInstanceName1+ ')))'
        URL2='jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=' + dbRACHost2 + ')(PORT=' + dbRACPort + ')))(CONNECT_DATA=(SERVICE_NAME=' + dbRACServiceName + ')(INSTANCE_NAME=' + dbRACInstanceName2+ ')))'

        databaseURL=eval('ds' + str(DataS) + '_URL')
        databURL=eval(databaseURL)
    except NameError, ner:
        print "Required parameter not specified: "
        print ner
        sys.exit(-1)

    print "==> Updating DataSource Info " + str(DataS) +    ": " + databaseDS
    print "                     DATA_SRC     : " + databaseDS
    print "                     RACHOST1     : " + dbRACHost1
    print "                     RACHOST2     : " + dbRACHost2
    print "                     RACPORT      : " + dbRACPort
    print "                     INSTANCE1    : " + dbRACInstanceName1
    print "                     INSTANCE2    : " + dbRACInstanceName2
    print "                     SERVICE_Name : " + dbRACServiceName

    print "setting attributes for mbean type Server"
    a=cd('/JDBCSystemResources/' + databaseDS + '/JDBCResource/' + databaseDS + '/JDBCDriverParams/' + databaseDS)

    print " ORIGINAL VALUE : "
    print ' '
    print a.getUrl()

    print 'Setting the new values :'
    a.setUrl(databURL)
    a.setPassword(sys.argv[2])

    print ' '
    print " LATEST   VALUE : "
    print ' '
    print a.getUrl()

    DataS += 1
  except NameError:
    break
save()
activate()

print "==>> Updating the Domain  <<==" 

#updateDomain()
#closeDomain()

#print "==>> " + DOMAIN_NAME + " successfully updated" 
