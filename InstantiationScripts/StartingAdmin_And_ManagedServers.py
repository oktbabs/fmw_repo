#++++++++++++++++++++++++++++++++++++++++++++++++++++
# Script Name  : StartingAdmin_And_ManagedServers.py+
# Written By   : Timmy Babayeju                     +
# From Company : Fujitsu                            +
# To  Company  : FSA                                +
#++++++++++++++++++++++++++++++++++++++++++++++++++++

#
# MACHINE 1
#
print 'CONNECT TO NODE MANAGER ON MACHINE1'
nmConnect(ADMIN_USERNAME, sys.argv[1], NMLISTENADDR1, NMLISTENPORT, DOMAIN_NAME, DOMAIN_HOME, NMTYPE)

print 'START ADMIN SERVER ON MACHINE1'
nmStart(SERVER1);

print 'CONNECT TO ADMIN SERVER'
connect(ADMIN_USERNAME, sys.argv[1], 't3://' + SERVER1_LISTENADDR + ':' + SERVER1_LISTENPORT)

print 'START MANAGED SERVERS ON MACHINE1'
start(SERVER2,'Server')
start(SERVER4,'Server')
start(SERVER6,'Server')
start(SERVER8,'Server')

print 'DISCONNECT FROM THE ADMIN SERVER'
disconnect()

print 'DISCONNECT FROM NODE MANAGER ON MACHINE1'
nmDisconnect()

#
# MACHINE 2
#
print 'CONNECT TO NODE MANAGER ON MACHINE2'
nmConnect(ADMIN_USERNAME, sys.argv[1], NMLISTENADDR2, NMLISTENPORT, DOMAIN_NAME, DOMAIN_HOME, NMTYPE)

print 'START MANAGED SERVERS ON MACHINE2'
start(SERVER3,'Server')
start(SERVER5,'Server')
start(SERVER7,'Server')
start(SERVER9,'Server')

print 'DISCONNECT FROM NODE MANAGER ON MACHINE2'
nmDisconnect()
