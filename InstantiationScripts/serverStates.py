
#+++++++++++++++++++++++++++++++++++++"
#   Script Name :serverStates.py      "
#   Written By: Timmy Babayeju       +"
#   From Company   : Fujitsu         +"
#   To   Company   : FSA             +"
#+++++++++++++++++++++++++++++++++++++"

import string
import sys
from datetime import *
dataObj = date(MINYEAR, 1, 1)
todaysDate = dataObj.today()


print "==>> This script checks the server states of the weblogic servers"
print " Run Date : \n" 
print date.today()

URL='t3://' + SERVER1_LISTENADDR + ':' + SERVER1_LISTENPORT

try:
   print ' ==>> CONNECT TO ADMIN SERVER : ' + SERVER1_LISTENADDR
   connect(ADMIN_USERNAME, sys.argv[1], URL)
except:
   print 'Cannot connect to Admin Server at ' + 't3://' + SERVER1_LISTENADDR + ':' + SERVER1_LISTENPORT


clust=1
while true:
  try:
    clusterName=eval('CLUSTER' + str(clust))
    try:
        clusterAddr1=eval('CLUSTER' + str(clust) + '_LISTENADDR1')
        clusterAddr2=eval('CLUSTER' + str(clust) + '_LISTENADDR2')
        clusterPort=eval('CLUSTER' + str(clust) + '_LISTENPORT')
    except NameError, ner:
        print "Required parameter not specified: "
        print ner
        sys.exit(-1)

    print "==> Verifying Cluster " + str(clust) +   ": " + clusterName
    print "                                  name    : " + clusterName
    print "                         listenAddress1   : " + clusterAddr1
    print "                         listenAddress2   : " + clusterAddr2
    print "                                  port    : " + clusterPort

    clu=state(clusterName,'Cluster')
    print  clu  

    clust += 1
  except NameError:
    break

