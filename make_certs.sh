#!/bin/bash
#####################################
#   To run, copy this file to the $DOMAIN_HOME/certs directory
#   Modify the Domain variable to reflect the domain you require
#####################################

# Source the setWLSEnv file
/u01/app/oracle/product/fmw/wlserver_10.3/server/bin/setWLSEnv.sh > /dev/null &2>&1

# Set the environment variables
certdir="/u01/app/oracle/shared/admin/domains/finance.domain/certs"
keystore="appIdentityKeyStore.jks"
Domain="fin"
passwd="Oracle01"
logfile=./make_certs.log
Servers="wok-stg-soa${Domain}01 wok-stg-soa${Domain}02 wok-stg-soa${Domain}-admin-vip wok-stg-soa${Domain}-apphost1-vip wok-stg-soa${Domain}-apphost2-vip wok-stg-soa${Domain}-osbhost1-vip wok-stg-soa${Domain}-osbhost2-vip wok-stg-soa${Domain}-soahost1-vip wok-stg-soa${Domain}-soahost2-vip"
counter=0

logit() {
if ! tty -s
        then
                printf "`date '+DATE: %m/%d/%y %H:%M:%S' ` $1 \n" >> $2
        else
                printf "`date '+DATE: %m/%d/%y %H:%M:%S'` $1 \n" | tee -a $2
fi
}

logit "Starting make_certs.sh script" $logfile

cd $certdir
if [ "$?" -ne "0" ]
then
  logit "$certdir does not exist" $logfile
  exit -1
fi
if [ -f $keystore ]
then
  logit "This keystore exists, remove it and run this scipt again"
  exit -1
fi

for i in `echo $Servers`
do
  logit "Generating key for $i" $logfile
  java utils.CertGen ${passwd} ${i}_cert ${i}_key domestic ${i}.sbetenv.ads
  logit "Key generated for $i" $logfile
  logit "Adding to the $keystore keystore"
  counter=$(( counter + 1 ))
  java utils.ImportPrivateKey ${keystore} ${passwd} appIdentity${counter} ${passwd} ${i}_cert.pem ${i}_key.pem
  logit "Added appIdentity${counter} key to $keystore" $logfile
done
logit "Finished script make_certs.sh" $logfile
