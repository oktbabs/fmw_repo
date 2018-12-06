
#++++++++++++++++++++++++++++++++++++++++++++++++++++++"
# Script Name  : vbox_initScript_And_LogLocation_First.sh  +"
# Written By   : Timmy Babayeju                       +"
# From Company : Fujitsu                              +"
# To  Company  : FSA                                  +"
# Description  : Checks if Instatiation folders       +" 
#                exists or creates the folders        +" 
#++++++++++++++++++++++++++++++++++++++++++++++++++++++"
# 

instanFS=/tmp/appPostLaunch
if [ -d $instanFS -a -d $instanFS/logs ]
then
    echo "...... $instanFS ...already exists"  
    echo "...... $instanFS/logs ...already exists"  
else
    echo "...... $instanFS ...does not  exist"
    echo " ....Creating $instanFS and $instanFS/logs filesystem..."
    mkdir  -p $instanFS/logs
    echo
    echo
fi
