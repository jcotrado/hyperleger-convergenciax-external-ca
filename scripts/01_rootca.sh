export EXTERNAL_CA_CFG=/home/jcotrado/HLFconvergenciax/external-ca
sudo chown -R jcotrado:jcotrado $EXTERNAL_CA_CFG/pki-ca

echo "####################################################################################################"
echo "# CONVERGENCIAX - CREACION DE USUARIO/CLIENTE admin en raiz de confianza root (root y tls-root)"
echo "####################################################################################################"


echo "########################"
echo "#CONVERGENCIAX - Registra la CA intermedia en cada PKI de entidad"
echo "#"
echo "# 1) enrola el usuario admin en root CA"
echo "# 2) registra el  usuario/password de "int.ca.convergenciax.com" en la rootCA (Se utilizara al emitir el certificado intermedio)"
echo "# 3) enrola el usuario admin en root TLS"
echo "# 4) registra el  usuario/password de "tls.int.ca.convergenciax.com"  en la rootTLS (Se utilizara al emitir el certificado intermedio)"
echo "########################"


########################
#ORG1
########################


#Enroll bootstrapt identity of int CA, con el cliente admin
export CSR_NAME_ORG1="C=CL,ST=Metropolitana,L=Santiago,O=org1.convergenciax.com,OU=ConvergenciaX-HLF"
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org1.convergenciax.com/root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7054 --csr.names "$CSR_NAME_ORG1" # --csr.cn root.ca.org1.convergenciax.com

#Registar un "CA intermedia" con usuario int.ca.convergenciax.com para root CA ye indica que es una CA Intermerdia con  'hf.IntermediateCA=true', el usuario admin esta autorizado a firmar nuevas CA intermedias
fabric-ca-client register --id.name int.ca.org1.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7054

#
#Enroll bootstrapt identidad de TLS root CA
#
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org1.convergenciax.com/tls-root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7055 --csr.names "$CSR_NAME_ORG1" # --csr.cn tls.root.ca.org1.convergenciax.com

#Registar un "CA intermedia" con usuario tls.int.ca.org1.convergenciax.com para root TLS ye indica que es una CA Intermerdia con  'hf.IntermediateCA=true', el usuario admin esta autorizado a firmar nuevas CA intermedias
fabric-ca-client register --id.name tls.int.ca.org1.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7055

##################
#ORG2
##################
export CSR_NAME_ORG2="C=CL,ST=Metropolitana,L=Santiago,O=org2.convergenciax.com,OU=ConvergenciaX-HLF"
#Enroll bootstrapt identity of int CA, genera pki-ca/int/clients/admin/msp/*,  IssuerPublicKey, IssuerRevocaionPublicKey, fabric-ca-client-config.yaml
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org2.convergenciax.com/root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7056 --csr.names "$CSR_NAME_ORG2" #--csr.cn root.ca.org2.convergenciax.com
#Registar la CA intermedia en root CA, genera clients/admin/fabric-ca-client-config.yaml
fabric-ca-client register --id.name int.ca.org2.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7056

#Enroll bootstrapt identidad de TLS root CA, genera /tls-root/clients/admin/fabric-ca-client-config.yaml
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org2.convergenciax.com/tls-root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7057 --csr.names "$CSR_NAME_ORG2" # --csr.cn tls.root.ca.org2.convergenciax.com
#Registar la CA intermedia en el TLS root CA
fabric-ca-client register --id.name tls.int.ca.org2.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7057

##################
#ORG3
##################
export CSR_NAME_ORG3="C=CL,ST=Metropolitana,L=Santiago,O=org3.convergenciax.com,OU=ConvergenciaX-HLF"
#Enroll bootstrapt identity of int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org3.convergenciax.com/root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7058 --csr.names "$CSR_NAME_ORG3" # --csr.cn root.ca.org3.convergenciax.com
#Registar la CA intermedia en root CA, genera clients/admin/fabric-ca-client-config.yaml
fabric-ca-client register --id.name int.ca.org3.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7058


#Enroll bootstrapt identidad de TLS root CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org3.convergenciax.com/tls-root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7059 --csr.names "$CSR_NAME_ORG3" # --csr.cn tls.root.ca.org3.convergenciax.com
#Registar la CA intermedia en el TLS root CA
fabric-ca-client register --id.name tls.int.ca.org3.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7059

#
### Enrola y registra la CA raiz
#
#Enroll bootstrapt identity de root CA

export CSR_NAME_CONVERGENCIAX="C=CL,ST=Metropolitana,L=Santiago,O=convergenciax.com,OU=ConvergenciaX-HLF"
# Enrola al usuario admin en la root CA.  / Enroll bootstrapt identity de root CA.
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/convergenciax.com/root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7060 --csr.names "$CSR_NAME_CONVERGENCIAX" # --csr.cn root.ca.convergenciax.com

#Registar un "CA intermedia" int.ca.convergenciax.com para root CA ye indica que es una CA Intermerdia con  'hf.IntermediateCA=true', el usuario admin esta autorizado a firmar nuevas CA intermedias
fabric-ca-client register --id.name int.ca.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7060

#
### Enrola y registra la TLS raiz
#

#Enroll bootstrapt identidad de  root TLS CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/convergenciax.com/tls-root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7061 --csr.names "$CSR_NAME_CONVERGENCIAX" # --csr.cn tls.root.ca.convergenciax.com
#Registar la CA intermedia para root TLS
fabric-ca-client register --id.name tls.int.ca.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7061
