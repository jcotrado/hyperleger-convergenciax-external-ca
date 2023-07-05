export EXTERNAL_CA_CFG=/home/jcotrado/HLFconvergenciax/external-ca
#CONVERGENCIAX
export CSR_NAME_CONVERGENCIAX="C=CL,ST=Metropolitana,L=Santiago,O=ConvergenciaX,OU=ConvergenciaX-Hyperledger"
#Enroll bootstrapt identity of int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/convergenciax.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7060 --csr.names $CSR_NAME_CONVERGENCIAX
#Registar la CA intermedia en root CA
fabric-ca-client register --id.name int.ca.org3.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7060
#Enroll bootstrapt identidad de TLS root CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/convergenciax.com/tls-root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7061 --csr.names "$CSR_NAME_CONVERGENCIAX"
#Registar la CA intermedia en el TLS root CA
fabric-ca-client register --id.name tls.int.ca.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7061

#ORG1
export CSR_NAME_ORG1="C=CL,ST=Metropolitana,L=Santiago,O=Org1,OU=ConvergenciaX-Hyperledger"
#Enroll bootstrapt identity of int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org1.convergenciax.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7054 --csr.names "$CSR_NAME_ORG1"
#Registar la CA intermedia en root CA
fabric-ca-client register --id.name int.ca.org1.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7054
#Enroll bootstrapt identidad de TLS root CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org1.convergenciax.com/tls-root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7055 --csr.names "$CSR_NAME_ORG1"
#Registar la CA intermedia en el TLS root CA
fabric-ca-client register --id.name tls.int.ca.org1.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7055

#ORG2
export CSR_NAME_ORG2="C=CL,ST=Metropolitana,L=Santiago,O=Org2,OU=ConvergenciaX-Hyperledger"
#Enroll bootstrapt identity of int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org2.convergenciax.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7056 --csr.names "$CSR_NAME_ORG2"
#Registar la CA intermedia en root CA
fabric-ca-client register --id.name int.ca.org2.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7056
#Enroll bootstrapt identidad de TLS root CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org2.convergenciax.com/tls-root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7057 --csr.names "$CSR_NAME_ORG2"
#Registar la CA intermedia en el TLS root CA
fabric-ca-client register --id.name tls.int.ca.org2.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7057


#ORG3
export CSR_NAME_ORG3="C=CL,ST=Metropolitana,L=Santiago,O=Org3,OU=ConvergenciaX-Hyperledger"
#Enroll bootstrapt identity of int CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org3.convergenciax.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7058 --csr.names "$CSR_NAME_ORG3"
#Registar la CA intermedia en root CA
fabric-ca-client register --id.name int.ca.org3.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:9058
#Enroll bootstrapt identidad de TLS root CA
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org3.convergenciax.com/tls-root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7059 --csr.names "$CSR_NAME_ORG3"
#Registar la CA intermedia en el TLS root CA
fabric-ca-client register --id.name tls.int.ca.org3.convergenciax.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:9059




###########OTROS
#fabric-ca-client register --id.name admin2 --id.affiliation org1.department1 --id.attrs 'hf.Revoker=true,admin=true:ecert'
#fabric-ca-client register -d --id.name admin2 --id.affiliation org1.department1 --id.attrs '"hf.Registrar.Roles=peer,client",hf.Revoker=true'
#fabric-ca-client register -d --id.name admin2 --id.affiliation org1.department1 --id.attrs '"hf.Registrar.Roles=peer,client"' --id.attrs hf.Revoker=true



