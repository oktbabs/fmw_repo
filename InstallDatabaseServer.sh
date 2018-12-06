create database vanilladb controlfile reuse Logfile 
Group 1 ('/mydatabases/vanilladb/log01a.log', 
'/mydatabase02/vanilladb/log01b.log') size 50M,
Group 2 ('/mydatabases/vanilladb/log02a.log',
'/mydatabase02/vanilladb/log02b.log') size 50M,
Group 3 ('/mydatabases/vanilladb/log03a.log',
'/mydatabase02/vanilladb/log03b.log') size 50M,
Group 4 ('/mydatabases/vanilladb/log04a.log',
'/mydatabase02/vanilladb/log04b.log') size 50M
Datafile '/mydatabases/vanilladb/vanilladb_system.dbf' 250M 
AUTOEXTEND ON MAXSIZE 500M
Undo tablespace vanilladb_undo1
Datafile '/mydatabases/vanilladb/vanilladb_undo1.dbf' 50M
Default temporary tablespace vanilladbtemp tempfile
'/mydatabases/vanilladb/vanilladbtemp1.dbf' size 75M
Extent management local 
Character set AL32UTF8
MAXLOGFILES 10
MAXLOGMEMBERS 10
MAXLOGHISTORY 1
MAXDATAFILES 500; 
