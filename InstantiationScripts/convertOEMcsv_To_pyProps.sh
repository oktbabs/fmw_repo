
#+++++++++++++++++++++++++++++++++++++++++++++"
# Script Name  : convertOEMcsv_To_pyProps.sh +"
# Written By   : Timmy Babayeju              +"
# From Company : Fujitsu                     +"
# To  Company  : FSA                         +"
#+++++++++++++++++++++++++++++++++++++++++++++"
# Description  : Script converts csv comma   +"
# delimited to name variable pair before any +"
# shell or python scripts can be executed.   +"
#+++++++++++++++++++++++++++++++++++++++++++++"

#!/bin/sh
CSVHOME=/tmp/appCSVFolder


sed -i 's/#,/#/g' $CSVHOME/inputAppProperties.csv
sed -i 's/---,//g'  $CSVHOME/inputAppProperties.csv
sed -i 's/,/=/g'   $CSVHOME/inputAppProperties.csv
