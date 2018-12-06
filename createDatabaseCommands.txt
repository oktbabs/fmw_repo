create database oelvmdb controlfile reuse Logfile 
Group 1 ('/mydatabases/oelvmdb/log01a.log', 
'/mydatabase02/oelvmdb/log01b.log') size 50M,
Group 2 ('/mydatabases/oelvmdb/log02a.log',
'/mydatabase02/oelvmdb/log02b.log') size 50M,
Group 3 ('/mydatabases/oelvmdb/log03a.log',
'/mydatabase02/oelvmdb/log03b.log') size 50M,
Group 4 ('/mydatabases/oelvmdb/log04a.log',
'/mydatabase02/oelvmdb/log04b.log') size 50M
Datafile '/mydatabases/oelvmdb/oelvmdb_system.dbf' 250M 
AUTOEXTEND ON MAXSIZE 500M
Undo tablespace oelvmdb_undo1
Datafile '/mydatabases/oelvmdb/oelvmdb_undo1.dbf' 50M
Default temporary tablespace oelvmdbtemp tempfile
'/mydatabases/oelvmdb/oelvmdbtemp1.dbf' size 75M
Extent management local 
Character set AL32UTF8
MAXLOGFILES 10
MAXLOGMEMBERS 10
MAXLOGHISTORY 1
MAXDATAFILES 500; 