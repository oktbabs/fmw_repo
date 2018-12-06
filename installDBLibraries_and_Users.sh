
echo " ....Install database libraries .........."

sudo yum -y install binutils compat-libcap1 compat-libstdc++-33  compat-libstdc++-33.i686 glibc  glibc.i686   glibc-devel  glibc-devel.i686  ksh  libaio  libaio.i686  libaio-devel  libaio-devel.i686  libX11 libX11.i686  libXau  libXau.i686 libXi libXi.i686 libXtst  libXtst.i686 libgcc  libgcc.i686  libstdc++  libstdc++.i686  libstdc++-devel  libstdc++-devel.i686  libxcb libxcb.i686 make  nfs-utils net-tools smartmontools sysstat unixODBC unixODBC-devel gcc gcc-c++ libXext libXext.i686 zlib-devel zlib-devel.i686  *xc* *xt* *xorg* *xdp* *xc* *xt* *xv* *xm* *xy* xorg kernel-uek-devel gcc  xorg-x11-utils  make kernel-devel kernel-headers kernel-uek-devel-$(uname -r)

echo
echo
echo " ..............CreateOracleUser .........."
echo
echo


CreateOracleUser(){
#Creating oracle pointer File and permission.

echo "Creating Oracle user and Groups"
echo 
echo
/usr/sbin/groupadd -g 1006 oinstall
/usr/sbin/groupadd -g 1002 dba
/usr/sbin/groupadd -g 1004 vboxsf
/usr/sbin/useradd -d /home/oracle -g oinstall -s /bin/bash -u 4152 oracle
/usr/sbin/usermod -G dba,oinstall,vboxsf oracle

mkdir /u01
chown -R oracle:oinstall /u01
}

CreateOracleUser
passwd oracle
