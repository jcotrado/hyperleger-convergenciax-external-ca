export EXTERNAL_CA_CFG=/home/jcotrado/HLFconvergenciax/external-ca
sudo chown -R jcotrado:jcotrado $EXTERNAL_CA_CFG/pki-ca

echo "####################################################################################################"
echo "# CONVERGENCIAX - CREACION DE USUARIO/CLIENTE admin en raiz de confianza intermedia (int y tls-int)"
echo "####################################################################################################"


##################
#CONVERGENCIAX
##################
echo "##################"
echo "# CONVERGENCIAX"
echo "##################"

export CSR_NAME_CONVERGENCIAX="C=CL,ST=Metropolitana,L=Santiago,O=ConvergenciaX,OU=ConvergenciaX-HLF"
#Enroll bootstrapt identity of int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/convergenciax.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:8060 --csr.names "$CSR_NAME_CONVERGENCIAX" --csr.cn int.ca.convergenciax.com

#Enroll bootstrapt identidad de TLS int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/convergenciax.com/tls-int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:8061 --csr.names "$CSR_NAME_CONVERGENCIAX" --csr.cn tls.int.ca.convergenciax.com

##################
#ORG1
##################
echo "##################"
echo "# Org1"
echo "##################"
export CSR_NAME_ORG1="C=CL,ST=Metropolitana,L=Santiago,O=Org1,OU=ConvergenciaX-HLF"
#Enroll bootstrapt identity of int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org1.convergenciax.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:8054 --csr.names "$CSR_NAME_ORG1" --csr.cn int.ca.org1.convergenciax.com

#Enroll bootstrapt identidad de TLS int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org1.convergenciax.com/tls-int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:8055 --csr.names "$CSR_NAME_ORG1" --csr.cn tls.int.ca.org1.convergenciax.com

##################
#ORG2
##################
echo "##################"
echo "# Org2"
echo "##################"
export CSR_NAME_ORG2="C=CL,ST=Metropolitana,L=Santiago,O=Org2,OU=ConvergenciaX-HLF"
#Enroll bootstrapt identity of int CA, genera pki-ca/int/clients/admin/msp/*,  IssuerPublicKey, IssuerRevocaionPublicKey, fabric-ca-client-config.yaml
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org2.convergenciax.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:8056 --csr.names "$CSR_NAME_ORG2" --csr.cn int.ca.org2.convergenciax.com

#Enroll bootstrapt identidad de TLS int CA, genera /tls-int/clients/admin/fabric-ca-client-config.yaml
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org2.convergenciax.com/tls-int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:8057 --csr.names "$CSR_NAME_ORG2" --csr.cn tls.int.ca.org2.convergenciax.com

##################
#ORG3
##################
echo "##################"
echo "# Org3"
echo "##################"
export CSR_NAME_ORG3="C=CL,ST=Metropolitana,L=Santiago,O=Org3,OU=int.org3.convergenciax.com"
#Enroll bootstrapt identity of int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org3.convergenciax.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:8058 --csr.names "$CSR_NAME_ORG3" --csr.cn int.ca.org3.convergenciax.com

#Enroll bootstrapt identidad de TLS int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org3.convergenciax.com/tls-int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:8059 --csr.names "$CSR_NAME_ORG3" --csr.cn tls.int.ca.org3.convergenciax.com

