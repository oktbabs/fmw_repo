koja=`lsnrctl status|grep 'TNS:no listener'|head -1`
if [ -n "$koja" ]
then
echo "Listener is not running. Needs to be started"
lsnrctl start
echo '-------------------------------'
lsnrctl status
else
          echo "Listener is currently running."
fi
