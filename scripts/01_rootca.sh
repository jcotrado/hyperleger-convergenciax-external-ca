export EXTERNAL_CA_CFG=/home/jcotrado/HLFconvergenciax/external-ca
sudo chown -R jcotrado:jcotrado $EXTERNAL_CA_CFG/pki-ca

########################
#CONVERGENCIAX
########################

#
### Enrola y registra la CA raiz
#
export CSR_NAME_CONVERGENCIAX="C=CL,ST=Metropolitana,L=Santiago,O=Convergenciax,OU=ConvergenciaX-HLF"
#Enroll bootstrapt identity de root CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/convergenciax.com/root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7060 --csr.names "$CSR_NAME_CONVERGENCIAX" --csr.cn ca.root.convergenciax.com 

#Registar un "CA intermedia" para root CA
fabric-ca-client register --id.name int.ca.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7060


#
### Enrola y registra la TLS raiz
#

#Enroll bootstrapt identidad de  root TLS CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/convergenciax.com/tls-root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7061 --csr.names "$CSR_NAME_CONVERGENCIAX" --csr.cn tls.root.convergenciax.com
#Registar la CA intermedia para root TLS
fabric-ca-client register --id.name tls.int.ca.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7061

########################
#ORG1
########################
export CSR_NAME_ORG1="C=CL,ST=Metropolitana,L=Santiago,O=Org1,OU=ConvergenciaX-HLF"
#Enroll bootstrapt identity of int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org1.convergenciax.com/root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7054 --csr.names "$CSR_NAME_ORG1" --csr.cn ca.root.org1.convergenciax.com
#Registar la CA intermedia en root CA
fabric-ca-client register --id.name int.ca.org1.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7054

#Enroll bootstrapt identidad de TLS root CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org1.convergenciax.com/tls-root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7055 --csr.names "$CSR_NAME_ORG1" --csr.cn tls.root.org1.convergenciax.com
#Registar la CA intermedia en el TLS root CA
fabric-ca-client register --id.name tls.int.ca.org1.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7055

##################
#ORG2
##################
export CSR_NAME_ORG2="C=CL,ST=Metropolitana,L=Santiago,O=Org2,OU=ConvergenciaX-HLF"
#Enroll bootstrapt identity of int CA, genera pki-ca/int/clients/admin/msp/*,  IssuerPublicKey, IssuerRevocaionPublicKey, fabric-ca-client-config.yaml
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org2.convergenciax.com/root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7056 --csr.names "$CSR_NAME_ORG2" --csr.cn ca.root.org2.convergenciax.com
#Registar la CA intermedia en root CA, genera clients/admin/fabric-ca-client-config.yaml
fabric-ca-client register --id.name int.ca.org2.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7056

#Enroll bootstrapt identidad de TLS root CA, genera /tls-root/clients/admin/fabric-ca-client-config.yaml
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org2.convergenciax.com/tls-root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7057 --csr.names "$CSR_NAME_ORG2" --csr.cn tls.root.org2.convergenciax.com
#Registar la CA intermedia en el TLS root CA
fabric-ca-client register --id.name tls.int.ca.org2.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7057

##################
#ORG3
##################
export CSR_NAME_ORG3="C=CL,ST=Metropolitana,L=Santiago,O=Org3,OU=ConvergenciaX-HLF"
#Enroll bootstrapt identity of int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org3.convergenciax.com/root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7058 --csr.names "$CSR_NAME_ORG3" --csr.cn ca.root.org3.convergenciax.com
#Registar la CA intermedia en root CA, genera clients/admin/fabric-ca-client-config.yaml
fabric-ca-client register --id.name int.ca.org3.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7058


#Enroll bootstrapt identidad de TLS root CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org3.convergenciax.com/tls-root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7059 --csr.names "$CSR_NAME_ORG3" --csr.cn tls.root.org3.convergenciax.com
#Registar la CA intermedia en el TLS root CA
fabric-ca-client register --id.name tls.int.ca.org3.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7059
