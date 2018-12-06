#TVIP=( 10.134.2.31  10.134.2.34   10.134.2.35  10.134.2.60  10.134.2.61  10.134.2.40  10.134.2.65  10.134.2.33)
#AA=( $SERVER1_LISTENADDR $SERVER2_LISTENADDR $SERVER3_LISTENADDR $SERVER4_LISTENADDR $SERVER5_LISTENADDR $SERVER6_LISTENADDR $SERVER7_LISTENADDR  $SERVER8_LISTENADDR $SERVER9_LISTENADDR)
#AA=$SERVER1_LISTENADDR $SERVER2_LISTENADDR $SERVER3_LISTENADDR $SERVER4_LISTENADDR $SERVER5_LISTENADDR $SERVER6_LISTENADDR $SERVER7_LISTENADDR  $SERVER8_LISTENADDR $SERVER9_LISTENADDR
#ip addr|grep inet|grep eth0|awk -F'[/ ]' '{print "/sbin/ifconfig",  $13, $6, $9}'|sed '1d' >allVIPEntries.txt

#ip addr|grep inet|grep eth0|awk -F'[/ ]' '{print $13, $6, $9}'|sed '1d' >allVIPEntries.txt
ip addr|grep inet|grep eth|awk -F'[/ ]' '{print $13, $6, $9}'|cut -d" " -f2 >allVIPEntries.txt
#. inputAppProperties.properties

dos2unix inputAppProperties2.*
. inputAppProperties2.csv

AA=( $SERVER1_LISTENADDR $SERVER3_LISTENADDR $SERVER4_LISTENADDR $SERVER5_LISTENADDR $SERVER6_LISTENADDR $SERVER7_LISTENADDR  $SERVER8_LISTENADDR )

echo $AA

echo $FRONTENDHOST
#for r in "${TVIP[@]}"
for r in "${AA[@]}"
do
  if grep  "$r" allVIPEntries.txt
  then
      echo "Good ... $r ... is online .."
      echo
  else
      echo "Really Bad .  $r... is NOT online .."
      echo "...Exiting . Cannot continue...."
      echo  "......All VIPS have to be online before you can continue......"
      echo
      exit
  fi
done



