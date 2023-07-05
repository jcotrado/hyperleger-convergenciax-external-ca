#CONVERGENCIAX
export CSR_NAME_CONVERGENCIAX="C=Chile,ST=Metropolitana, L=Santiago, O=ConvergenciaX, OU=ConvergenciaX HLF"
#Enroll bootstrapt identity of int CA
export FABRIC_CA_CLIENT_HOME= ../fabric-ca/convergenciax.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7056 --csr.name "$CSR_NAME_CONVERGENCIAX"
#Enroll bootstrapt identity of tls int CA
export FABRIC_CA_CLIENT_HOME= ../fabric-ca/convergenciax.com/tls-int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7057 --csr.name "CSR_NAME_CONVERGENCIAX"

#ORG1
export CSR_NAME_ORG1="C=Chile,ST=Metropolitana, L=Santiago, O=Org1, OU=ConvergenciaX HLF"
#Enroll bootstrapt identity of int CA
export FABRIC_CA_CLIENT_HOME= ../fabric-ca/org1.convergenciax.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7056 --csr.name "$CSR_NAME_ORG1"
#Enroll bootstrapt identity of tls int CA
export FABRIC_CA_CLIENT_HOME= ../fabric-ca/org1.convergenciax.com/tls-int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7057 --csr.name "$CSR_NAME_ORG1"

#ORG2
export CSR_NAME_ORG1="C=Chile,ST=Metropolitana, L=Santiago, O=Org2, OU=ConvergenciaX HLF"
#Enroll bootstrapt identity of int CA
export FABRIC_CA_CLIENT_HOME= ../fabric-ca/org2.convergenciax.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7056 --csr.name "$CSR_NAME_ORG2"
#Enroll bootstrapt identity of tls int CA
export FABRIC_CA_CLIENT_HOME= ../fabric-ca/org2.convergenciax.com/tls-int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7057 --csr.name "$CSR_NAME_ORG2"

#ORG3
export CSR_NAME_ORG1="C=Chile,ST=Metropolitana, L=Santiago, O=Org3, OU=ConvergenciaX HLF"
#Enroll bootstrapt identity of int CA
export FABRIC_CA_CLIENT_HOME= ../fabric-ca/org3.convergenciax.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7056 --csr.name "$CSR_NAME_ORG3"
#Enroll bootstrapt identity of tls int CA
export FABRIC_CA_CLIENT_HOME= ../fabric-ca/org3.convergenciax.com/tls-int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7057 --csr.name "$CSR_NAME_ORG3"