
#++++++++++++++++++++++++++++++++++++++++++++++++++++
# Script Name  : ShutdownAdmin_And_ManagedServer.py +
# Written By   : Timmy Babayeju                     +
# From Company : Fujitsu                            +
# To  Company  : FSA                                +
#++++++++++++++++++++++++++++++++++++++++++++++++++++



print 'CONNECT TO NODE MANAGER ON MACHINE1';
nmConnect(ADMIN_USERNAME, sys.argv[1], NMLISTENADDR1, NMLISTENPORT, DOMAIN_NAME, DOMAIN_HOME, NMTYPE)

print 'CONNECT TO ADMIN SERVER';
connect(ADMIN_USERNAME, sys.argv[1], 't3://' + SERVER1_LISTENADDR + ':' + SERVER1_LISTENPORT)

print 'STOPPING MANAGED SERVERS ON MACHINE1';

shutdown(SERVER2,'Server','true',1000,'true')
shutdown(SERVER4,'Server','true',1000,'true')
shutdown(SERVER6,'Server','true',1000,'true')
shutdown(SERVER8,'Server','true',1000,'true')

print 'DISCONNECT FROM NODE MANAGER ON MACHINE1';
nmDisconnect();

print 'CONNECT TO NODE MANAGER ON MACHINE2';
nmConnect(ADMIN_USERNAME, sys.argv[1], NMLISTENADDR2, NMLISTENPORT, DOMAIN_NAME, DOMAIN_HOME, NMTYPE)

print 'STOPPING MANAGED SERVERS ON MACHINE2'
shutdown(SERVER3,'Server','true',1000,'true')
shutdown(SERVER5,'Server','true',1000,'true')
shutdown(SERVER7,'Server','true',1000,'true')
shutdown(SERVER9,'Server','true',1000,'true')

print 'STOPPING ADMIN SERVER ON MACHINE2';
shutdown(SERVER1,'Server','true',1000,'true')

print 'DISCONNECT FROM NODE MANAGER ON MACHINE2'
nmDisconnect()

