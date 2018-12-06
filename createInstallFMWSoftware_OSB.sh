setenvFmw(){

export SOFTWAREDIR=/media/sf_LINUX_ORASOFT/12C_Response_Folder
export ORACLE_BASE=/u01/app/oracle
export TEMP_DIR=${SOFTWAREDIR}/tmp
export PATCH_HOME=${SOFTWAREDIR}/patches
export WLS_FILE_NAME=fmw_12.2.1.3.0_infrastructure.jar
export SOA_FILE_NAME=fmw_12.2.1.3.0_soa.jar
export OSB_FILE_NAME=fmw_12.2.1.3.0_osb.jar
export IDM_FILE_NAME=fmw_12.2.1.3.0_idm.jar
export OUD_FILE_NAME=fmw_12.2.1.3.0_oud.jar
export OHS_FILE_NAME=fmw_12.2.1.3.0_ohs_linux64.bin
export OID_FILE_NAME=fmw_12.2.1.3.0_oid_linux64.bin
export MW_HOME=$ORACLE_BASE/product/fmw12213
export ORACLE_HOME=$MW_HOME
export JAVA_VERSION=jdk1.8.0_131
export JAVA_HOME=$ORACLE_BASE/product/java/${JAVA_VERSION}
export ANT_HOME=$MW_HOME/oracle_common/modules/thirdparty/org.apache.ant/1.9.8.0.0/apache-ant-1.9.8
export OEPE_HOME=$SOFTWAREDIR/oepe-12.2.1.3
export DOMAIN_NAME=osb_domain
export ASERVER=$ORACLE_BASE/admin/aservers
export MSERVER=$ORACLE_BASE/admin/mservers
export DOMAIN_HOME=$ASERVER/$DOMAIN_NAME
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MW_HOME/lib
export PATH=$PATH:$JAVA_HOME/bin:$DOMAIN_HOME/bin:$MW_HOME/oracle_common/common/bin:$ANT_HOME/bin:$MW_HOME/OPatch/bin:$LD_LIBRARY_PATH:.

}

createdomainFolder(){

echo "---- Creating FMW Folders -----"
echo

#sudo mkdir -p $ORACLE_BASE/{admin/{aservers,mservers}/{system,runtime/logs},{soacluster,osbCluster}/{jms,tlogs},product/fmw/java}
sudo mkdir -p $ORACLE_BASE/admin/{mservers,system,runtime/{logs,osb_Cluster/{tlogs,jms,jta}}}
#sudo mkdir -p $ORACLE_BASE/admin/soacluster/{jms,tlogs}
#sudo mkdir -p $ORACLE_BASE/admin/{aservers,mservers}/{system,runtime/logs}
}

createFMWFolder(){
sudo mkdir -p $ORACLE_BASE/product/java 
#sudo mkdir -p $MW_HOME

sudo chown -R oracle:oinstall $ORACLE_BASE
}

createoraInventory(){

echo
echo " ---- Create OraInventory -----"
echo

mkdir -p  $ORACLE_BASE/oraInventory
cd $ORACLE_BASE/oraInventory

echo inventory_loc=$ORACLE_BASE >oraInst.loc
echo inst_group=oinstall >>oraInst.loc

}

install_java(){


echo
echo " ---- Installing Java -----"
echo

cp -r ${SOFTWAREDIR}/${JAVA_VERSION}  $ORACLE_BASE/product/java/

}

install_wls_coh_12213(){

echo
echo "---- Installing WLS -----"
echo 

${JAVA_HOME}/bin/java -Xms1024m -Xmx1024m -Djava.io.tmpdir=${TEMP_DIR} -jar ${SOFTWAREDIR}/${WLS_FILE_NAME} -silent -responseFile ${SOFTWAREDIR}/wls_coh_response12213.rsp -invPtrLoc ${ORACLE_BASE}/oraInventory/oraInst.loc -ignoreSysPrereqs -jreLoc $JAVA_HOME
}


install_soa_12213(){

echo
echo "---- Installing SOA -----"
echo

${JAVA_HOME}/bin/java  -Xms1024m -Xmx1536m -Djava.io.tmpdir=${TEMP_DIR} -jar ${SOFTWAREDIR}/${SOA_FILE_NAME} -silent -responseFile ${SOFTWAREDIR}/soa_bpm_response12213.rsp -invPtrLoc ${ORACLE_BASE}/oraInventory/oraInst.loc -ignoreSysPrereqs -jreLoc $JAVA_HOME

}


install_oepe(){

echo
echo " ---- Installing OEPE -----"
echo

cp -r $OEPE_HOME  $MW_HOME/

}

install_osb_12213(){

echo
echo '----  Install_OSB  ----'
echo

${JAVA_HOME}/bin/java  -Xms1024m -Xmx1536m -Djava.io.tmpdir=${TEMP_DIR} -jar ${SOFTWAREDIR}/${OSB_FILE_NAME} -silent -responseFile ${SOFTWAREDIR}/osb_response12213.rsp -invPtrLoc ${ORACLE_BASE}/oraInventory/oraInst.loc -ignoreSysPrereqs -jreLoc $JAVA_HOME

}


install_idm_12213(){

echo
echo '----  Install_IDM  ----'
echo


${JAVA_HOME}/bin/java  -Xms1024m -Xmx1536m -Djava.io.tmpdir=${TEMP_DIR} -jar ${SOFTWAREDIR}/${IDM_FILE_NAME} -silent -responseFile ${SOFTWAREDIR}/idm_response12213.rsp -invPtrLoc ${ORACLE_BASE}/oraInventory/oraInst.loc -ignoreSysPrereqs -jreLoc $JAVA_HOME

}

install_OIM_Patch(){

#cd $IDM_PATCH_HOME/oim/27363471
cd $IDM_PATCH_HOME/oim

#$MW_HOME/OPatch/opatch lsInventory
$MW_HOME/OPatch/opatch apply

}

install_OAM_Patch(){

cd $IDM_PATCH_HOME/oam/27150233

$MW_HOME/OPatch/opatch lsInventory

}

install_oud_12213(){

echo
echo '----  Install_IDM  ----'
echo


${JAVA_HOME}/bin/java  -Xms1024m -Xmx1536m -Djava.io.tmpdir=${TEMP_DIR} -jar ${SOFTWAREDIR}/${OUD_FILE_NAME} -silent -responseFile ${SOFTWAREDIR}/oud_response12213.rsp -invPtrLoc ${ORACLE_BASE}/oraInventory/oraInst.loc -ignoreSysPrereqs -jreLoc $JAVA_HOME

}

install_ohs_12213(){

echo
echo '----  Install_OHS  ----'
echo


#java -Xms1024m -Xmx1536m -Djava.io.tmpdir=${TEMP_DIR} -jar ${SOFTWAREDIR}/${OHS_FILE_NAME} -silentresponseFile ${SOFTWAREDIR}/ohs_response12213.rsp -invPtrLoc ${ORACLE_BASE}/oraInventory/oraInst.loc -ignoreSysPrereqs -jreLoc $JAVA_HOME
export PATH=$MW_HOME/OPatch:$PATH
#${SOFTWAREDIR}/${OHS_FILE_NAME} -silent -responseFile ${SOFTWAREDIR}/ohs_response12213.rsp -invPtrLoc ${ORACLE_BASE}/oraInventory/oraInst.loc -ignoreSysPrereqs -jreLoc $JAVA_HOME
${SOFTWAREDIR}/${OHS_FILE_NAME} -silent -responseFile ${SOFTWAREDIR}/ohs_122130_collocated.rsp -invPtrLoc ${ORACLE_BASE}/oraInventory/oraInst.loc -ignoreSysPrereqs -jreLoc $JAVA_HOME
}

install_ohs_patch12213(){

echo
echo '----  Install_OHS PATCH p27149535_122130_Linux-x86-64.zip ----'
echo

export PATH=$MW_HOME/OPatch:$PATH
cd $PATCH_HOME
unzip -o ${SOFTWAREDIR}/p27149535_122130_Linux-x86-64.zip
cd 27149535
opatch apply -silent

}

install_oid_12213(){

echo
echo '----  Install_OID  ----'
echo


export PATH=$MW_HOME/OPatch:$PATH
#${SOFTWAREDIR}/${OID_FILE_NAME} -silent -responseFile ${SOFTWAREDIR}/oid_response12213.rsp -invPtrLoc ${ORACLE_BASE}/oraInventory/oraInst.loc -ignoreSysPrereqs -jreLoc $JAVA_HOME

${SOFTWAREDIR}/${OID_FILE_NAME} -silent -responseFile ${SOFTWAREDIR}/oid_122130_collocated.rsp  -invPtrLoc ${ORACLE_BASE}/oraInventory/oraInst.loc -ignoreSysPrereqs -jreLoc $JAVA_HOME


}

install_oim(){

echo
echo '----Install_OIM----'
echo

cd $SOFTWAREDIR/OIM_11.1.1.9.0/Disk1
./runInstaller -silent -response  $SOFTWAREDIR/oimResponseFile.txt -invPtrLoc  $ORACLE_BASE/oraInventory/oraInst.loc -ignoreSysPrereqs -jreLoc $JAVA_HOME

}


install_webgate(){

echo
echo '----Install_WEBGATE----'
echo

cd $SOFTWAREDIR/OIM_11.1.1.9.0/Disk1
./runInstaller -silent -response  $SOFTWAREDIR/oimResponseFile.txt -invPtrLoc  $ORACLE_BASE/oraInventory/oraInst.loc -ignoreSysPrereqs -jreLoc $JAVA_HOME

}

install_iam(){

echo
echo '---- Install_IAM  ----'
echo


cd $SOFTWAREDIR/IAM_111230_with_SOA11119_with_patches/iam_generic_11.1.2.3.0/Disk1
./runInstaller -silent -response  $SOFTWAREDIR/iamResponseFile.txt -invPtrLoc  $ORACLE_BASE/oraInventory/oraInst.loc -ignoreSysPrereqs -jreLoc $JAVA_HOME

}
setenvFmw
echo
echo "------------------------------------------------------------"
echo
createdomainFolder
echo
echo "------------------------------------------------------------"
echo
createFMWFolder
echo
echo "------------------------------------------------------------"
echo
createoraInventory
echo "------------------------------------------------------------"
echo
install_java
sleep 10
echo
echo "------------------------------------------------------------"
echo
install_wls_coh_12213
sleep 10
echo
echo "------------------------------------------------------------"
echo
install_soa_12213
#install_idm_12213
#sleep 10
echo
echo "------------------------------------------------------------"
echo
####install_OIM_Patch
######install_OAM_Patch
echo
echo "------------------------------------------------------------"
echo
#install_oud_12213
#sleep 10
echo
echo "------------------------------------------------------------"
echo
#install_ohs_12213
#sleep 10
echo
echo "------------------------------------------------------------"
echo
#install_ohs_patch12213
#install_oid_12213
echo
echo "------------------------------------------------------------"
echo
#install_oepe
install_osb_12213
#install_oim
#install_iam
