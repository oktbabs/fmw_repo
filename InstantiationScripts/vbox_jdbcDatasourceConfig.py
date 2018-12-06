
#++++++++++++++++++++++++++++++++++++++++++++++
# Script Name  : vbox_jdbcDatasourceConfig.py      + 
# Written By   : Timmy Babayeju               +
# From Company : Fujitsu                      +
# To  Company  : FSA                          +
#++++++++++++++++++++++++++++++++++++++++++++++
# Description : Script retrieves the old      +
# datasource connect string for the old VM/VMs+
# and updates it with the datasource conection+
# strings associated with the new VMs         +
#++++++++++++++++++++++++++++++++++++++++++++++

import wlstModule as wlst
import sys
import string
import traceback
#from java.io import File
#from java.io import FileOutputStream
#f=File('/tmp/appPostLaunch/logs/vbox_jdbcDatasourceConfig.log')
#fos=FileOutputStream(f)
#theInterpreter.setOut(fos)


print "==>> Reading Domain Information from " + DOMAIN_HOME

readDomain(DOMAIN_HOME)


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
#    a=cd('/JDBCSystemResources/' + databaseDS + '/JDBCResource/' + databaseDS + '/JDBCDriverParams/' + databaseDS)
    cd('/')
    a=cd('/JDBCSystemResource/' + databaseDS + '/JdbcResource/' + databaseDS + '/JDBCDriverParams/NO_NAME_0')

    print " ORIGINAL VALUE : "
    print ' '
    print a.getUrl()
#    cmo.setUrl(dataBURL)
#    a.setListenAddress(mServerAddr)
    #print a.getdatabaseDS()
    #cmo.getUrl()
    print 'Setting the new values :'
    a.setUrl(databURL)
    a.setPasswordEncrypted(sys.argv[1])

    print ' '
    print " LATEST   VALUE : "
    print ' '
    print a.getUrl()

    DataS += 1
  except NameError:
    break

  print "==>> Updating the Domain  <<==" 
updateDomain()
closeDomain()

print "==>> " + DOMAIN_NAME + " successfully updated" 
