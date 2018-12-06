sqlplus / as sysdba <<EOF
conn / as sysdba;
SET HEADING OFF
SET FEEDBACK OFF
SET LINESIZE 3800
SET TRIMSPOOL ON
SET TERMOUT OFF
SET SPACE 0
SET PAGESIZE 0
FORMAT COL A30;
SELECT name, open_mode from v\$pdbs; 
CREATE or REPLACE trigger OPEN_ALL_PLUGGABLES 
   after startup 
   on  database 
BEGIN 
   execute immediate 'alter pluggable database all open'; 
END open_all_pdbs;

alter pluggable database all save state;

exit
EOF

