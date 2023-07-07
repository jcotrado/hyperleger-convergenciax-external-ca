export EXTERNAL_CA_CFG=/home/jcotrado/HLFconvergenciax/external-ca
sudo chown -R jcotrado:jcotrado $EXTERNAL_CA_CFG/pki-ca


##################
#CONVERGENCIAX
##################
export CSR_NAME_CONVERGENCIAX="C=CL,ST=Metropolitana,L=Santiago,O=ConvergenciaX,OU=ConvergenciaX-Hyperledger"
#Enroll bootstrapt identity of int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/convergenciax.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7060 --csr.names "$CSR_NAME_CONVERGENCIAX"

#Enroll bootstrapt identidad de TLS int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/convergenciax.com/tls-int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7061 --csr.names "$CSR_NAME_CONVERGENCIAX"

##################
#ORG1
##################
export CSR_NAME_ORG1="C=CL,ST=Metropolitana,L=Santiago,O=Org1,OU=ConvergenciaX-Hyperledger"
#Enroll bootstrapt identity of int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org1.convergenciax.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7054 --csr.names "$CSR_NAME_ORG1"

#Enroll bootstrapt identidad de TLS int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org1.convergenciax.com/tls-int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7055 --csr.names "$CSR_NAME_ORG1"

##################
#ORG2
##################
export CSR_NAME_ORG2="C=CL,ST=Metropolitana,L=Santiago,O=Org2,OU=ConvergenciaX-Hyperledger"
#Enroll bootstrapt identity of int CA, genera pki-ca/int/clients/admin/msp/*,  IssuerPublicKey, IssuerRevocaionPublicKey, fabric-ca-client-config.yaml
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org2.convergenciax.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:8056 --csr.names "$CSR_NAME_ORG2"

#Enroll bootstrapt identidad de TLS int CA, genera /tls-int/clients/admin/fabric-ca-client-config.yaml
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org2.convergenciax.com/tls-int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:8057 --csr.names "$CSR_NAME_ORG2"

##################
#ORG3
##################
export CSR_NAME_ORG3="C=CL,ST=Metropolitana,L=Santiago,O=Org3,OU=ConvergenciaX-Hyperledger"
#Enroll bootstrapt identity of int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org3.convergenciax.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7058 --csr.names "$CSR_NAME_ORG3"

#Enroll bootstrapt identidad de TLS int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org3.convergenciax.com/tls-int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7059 --csr.names "$CSR_NAME_ORG3"

