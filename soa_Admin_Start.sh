/u01/app/oracle/product/fmw12213/oracle_common/common/bin/wlst.sh

nmConnect('weblogic','Kala8Kuta', 'oelvmapps01-adminvhn.mycompany.com','7001','soa_domain','/u01/app/oracle/admin/aservers/soa_domain')

nmConnect('weblogic','Kala8Kuta', 'localhost','7001','soa_domain','/u01/app/oracle/admin/aservers/soa_domain')

nmStart('AdminServer')

connect('weblogic','Kala8Kuta','t3://oelvmapps01-adminvhn.mycompany.com:7001')

connect('weblogic','Kala8Kuta','t3://localhost:7001')


nmEnroll('/u01/app/oracle/admin/aservers/soa_domain','/u01/app/oracle/admin/aservers/system/nodemanager')