from java.io import File
from java.io import FileOutputStream
f=File('/tmp/appPostLaunch/logs/wlst.log')
fos=FileOutputStream(f)
theInterpreter.setOut(fos)

