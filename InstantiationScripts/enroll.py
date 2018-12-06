
#+++++++++++++++++++++++++++++++++++++++++"
# Script Name  : enroll.py                "
# Written By   : Timmy Babayeju          +"
# From Company : Fujitsu                 +"
# To  Company  : FSA                     +"
#+++++++++++++++++++++++++++++++++++++++++"

################ CONNECT WLST TO NODE MANAGER #############

print " ===> Enrolling WLST TO NODE MANAGER ..." 

try:
	print " ===> Enrolling WLST with Nodemanager ... "
	print " "
	nmEnroll(DOMAIN_HOME, NMHOME)
	print " ===> Enrolled WLST with Nodemanager successfully... "

except:
	print '===>> There is a problem connecting WLST to Nodemanager ...' 

