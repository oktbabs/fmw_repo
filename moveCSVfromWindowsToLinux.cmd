
set PATH=%PATH%;C:\Program Files (x86)\OpenSSH\bin

cd C:\TEMP\appPostLaunch

pscp.exe -pw Kala8Kuta -r C:\TEMP\appPostLaunch\inputAppProperties2.csv  oracle@oelvmapps01.mycompany.com:/tmp/appCSVFolder

