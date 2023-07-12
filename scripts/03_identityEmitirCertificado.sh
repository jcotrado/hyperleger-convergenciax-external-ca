export EXTERNAL_CA_CFG=/home/jcotrado/HLFconvergenciax/external-ca
sudo chown -R jcotrado:jcotrado $EXTERNAL_CA_CFG/pki-ca

#Emitir un certificado en para PKI de identidad
function issueCertificatesPKI() {
ca=$1
ca_port=$2
org=$3
id_name=$4
id_secret=$5
id_type=$6
csr_names=$7
csr_hosts=$8

echo "issueCertificatesPKI ->" $ca $ca_port $org  $id_name $id_secret $id_type $csr_names $csr_hosts

# issueCertificatesPKI int 8054 org1.convergenciax.com admin@org1.convergenciax.com adminpw admin "$CSR_NAME_ORG1" "localhost"
#                      $1 $2   $3                        $4                          $5      $6      $7            $8

export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/$org/$ca/clients/admin
echo "FABRIC_CA_CLIENT_HOME->" $FABRIC_CA_CLIENT_HOME
##registro de nueva identidad $id_name en CA ADMIN (tiene permisos)
fabric-ca-client register --id.name $id_name --id.secret $id_secret --id.type=$id_type -u http://admin:adminpw@localhost:$ca_port
#echo "fabric-ca-client--register: --id.name $id_name --id.secret $id_secret --id.type=$id_type -u http://admin:adminpw@localhost:$ca_port" 

## Enrolar nueva identidad registrada
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/$org/$ca/clients/$id_name
echo "FABRIC_CA_CLIENT_HOME->" $FABRIC_CA_CLIENT_HOME
fabric-ca-client enroll -u http://$id_name:$id_secret@localhost:$ca_port --csr.names $csr_names --csr.hosts $csr_hosts
#echo "fabric-ca-client--enroll -u http://$id_name:$id_secret@localhost:$ca_port --csr.names $csr_names --csr.hosts $csr_hosts"
}

#Emitir un certificado en para conexiones TLS
function issueTLSCertificates(){

tls=$1
tls_port=$2
org=$3
id_name=$4
id_secret=$5
id_type=$6
csr_names=$7
csr_hosts=$8

echo "issueTLSCertificates ->" $tls $tls_port $org  $id_name $id_secret $id_type $csr_names $csr_hosts

##issueTLSCertificates tls-int 8055 org1.convergenciax.com admin@org1.convergenciax.com  admin adminpw "$CSR_NAME_ORG1" "admin@org1.convergenciax.com,localhost"
#                      $1       $2   $3                        $4                          $5      $6      $7         $8
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/$org/$tls/clients/admin

echo "FABRIC_CA_CLIENT_HOME->" $FABRIC_CA_CLIENT_HOME

#registro de nueva identidad $id_name en CA ADMIN (tiene permisos)
fabric-ca-client register --id.name $id_name --id.secret $id_secret --id.type=$id_type -u http://admin:adminpw@localhost:$tls_port
#echo "fabric-ca-client--register --id.name $id_name --id.secret $id_secret --id.type=$id_type -u http://admin:adminpw@localhost:$tls_port"

# Enrolar nueva identidad registrada
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/$org/$tls/clients/$id_name
echo "FABRIC_CA_CLIENT_HOME->" $FABRIC_CA_CLIENT_HOME

fabric-ca-client enroll -u http://$id_name:$id_secret@localhost:$tls_port --csr.names $csr_names --csr.hosts $csr_hosts
#echo "fabric-ca-client--enroll -u http://$id_name:$id_secret@localhost:$tls_port --csr.names $csr_names --csr.hosts $csr_hosts"
}

##################################################################################
######### ORG1 Se crean MSP: admin, cliente y peer de la organizacion
##################################################################################

echo "##################################################################################"
echo "##  ORG1 Se crean MSP: admin, cliente y peer de la organizacion"
echo "##################################################################################"

export CSR_NAME_ORG1="C=CL,ST=Metropolitana,L=Santiago,O=Org1,OU=ConvergenciaX-HLF"

#Emision de certificado para usuario admin identity
#issueCertificatesPKI int 8054 org1.convergenciax.com admin@org1.convergenciax.com adminpw admin "$CSR_NAME_ORG1" "localhost"
#issueTLSCertificates tls-int 8055 org1.convergenciax.com admin@org1.convergenciax.com adminpw admin "$CSR_NAME_ORG1" "admin@org1.convergenciax.com,localhost"

#Emision de certificado para  cliente identity y cliente TLS
#issueCertificatesPKI int 8054 org1.convergenciax.com client@org1.convergenciax.com clientpw client "$CSR_NAME_ORG1" "localhost"
#issueTLSCertificates tls-int 8055 org1.convergenciax.com client@org1.convergenciax.com clientpw client "$CSR_NAME_ORG1" "client@org1.convergenciax.com,localhost"

#Emision de certificado para peer nodo identity y para peer server TLS
#issueCertificatesPKI int 8054 org1.convergenciax.com peer0@org1.convergenciax.com peerpw peer "$CSR_NAME_ORG1" "localhost"
#issueTLSCertificates tls-int 8055 org1.convergenciax.com peer0@org1.convergenciax.com peerpw peer "$CSR_NAME_ORG1" "peer0@org1.convergenciax.com,localhost"

##################################################################################
######### ORG2 Se crean MSP: admin, cliente y peer de la organizacion
##################################################################################
echo "##################################################################################"
echo "##  ORG2 Se crean MSP: admin, cliente y peer de la organizacion"
echo "##################################################################################"

export CSR_NAME_ORG2="C=CL,ST=Metropolitana,L=Santiago,O=Org2,OU=ConvergenciaX-HLF"

#echo "Emision de certificado para usuario admin identity---------------------"
#issueCertificatesPKI int 8056 org2.convergenciax.com admin@org2.convergenciax.com adminpw admin "$CSR_NAME_ORG2" "localhost"
#issueTLSCertificates tls-int 8057 org2.convergenciax.com admin@org2.convergenciax.com adminpw admin "$CSR_NAME_ORG2" "admin@org2.convergenciax.com,localhost"

#echo "Emision de certificado para  cliente identity y cliente TLS--------------"
#issueCertificatesPKI int 8056 org2.convergenciax.com client@org2.convergenciax.com clientpw client "$CSR_NAME_ORG2" "localhost"
#issueTLSCertificates tls-int 8057 org2.convergenciax.com client@org2.convergenciax.com clientpw client "$CSR_NAME_ORG2" "client@org2.convergenciax.com,localhost"

#echo "Emision de certificado para peer nodo identity y para peer server TLS----"
#issueCertificatesPKI int 8056 org2.convergenciax.com peer0@org2.convergenciax.com peerpw peer "$CSR_NAME_ORG2" "localhost"
#issueTLSCertificates tls-int 8057 org2.convergenciax.com peer0@org2.convergenciax.com peerpw peer "$CSR_NAME_ORG2" "peer0@org2.convergenciax.com,localhost"


##########################################################################
######### ORG3 Se crean MSP: admin, cliente y peer de la organizacion
##########################################################################
echo "##################################################################################"
echo "##  ORG3 Se crean MSP: admin, cliente y peer de la organizacion"
echo "##################################################################################"

export CSR_NAME_ORG3="C=CL,ST=Metropolitana,L=Santiago,O=Org3,OU=ConvergenciaX-HLF"
echo "Emision de certificado para usuario admin identity---------------------"
issueCertificatesPKI int 8058 org3.convergenciax.com admin@org3.convergenciax.com adminpw admin "$CSR_NAME_ORG3" "localhost"
issueTLSCertificates tls-int 8059 org3.convergenciax.com admin@org3.convergenciax.com adminpw admin "$CSR_NAME_ORG3" "admin@org3.convergenciax.com,localhost"

echo "Emision de certificado para  cliente identity y cliente TLS--------------"
issueCertificatesPKI int 8058 org3.convergenciax.com client@org3.convergenciax.com clientpw client "$CSR_NAME_ORG3" "localhost"
issueTLSCertificates tls-int 8059 org3.convergenciax.com client@org3.convergenciax.com clientpw client "$CSR_NAME_ORG3" "client@org3.convergenciax.com,localhost"

echo "Emision de certificado para peer nodo identity y para peer server TLS----"
issueCertificatesPKI int 8058 org3.convergenciax.com peer0@org3.convergenciax.com peerpw peer "$CSR_NAME_ORG3" "localhost"
issueTLSCertificates tls-int 8059 org3.convergenciax.com peer0@org3.convergenciax.com peerpw peer "$CSR_NAME_ORG3" "peer0@org3.convergenciax.com,localhost"

################################################################################
######### CONVERGENCIA - Se crea admin y orderer, no requiere cliente por que no es transaccional.
################################################################################

echo "##################################################################################"
echo "##  Convergencia  Se crean MSP: admin y orderer"
echo "##################################################################################"

export CSR_NAME_CONVERGENCIAX="C=CL,ST=Metropolitana,L=Santiago,O=ConvergenciaX,OU=ConvergenciaX-HLF"

echo "Emision de certificado para usuario admin identity......"
issueCertificatesPKI int 8060 convergenciax.com admin@convergenciax.com  password admin  "$CSR_NAME_CONVERGENCIAX" ""
issueTLSCertificates tls-int 8061 convergenciax.com admin@convergenciax.com password admin  "$CSR_NAME_CONVERGENCIAX" "admin@convergenciax.com,localhost"

echo "Emision de certificado para orderer nodo identity y orderer server TLS, no es usuario transaciones ..."
issueCertificatesPKI int 8060 convergenciax.com orderer.convergenciax.com  password orderer  "$CSR_NAME_CONVERGENCIAX" ""
issueTLSCertificates tls-int 8061 convergenciax.com orderer.convergenciax.com  password orderer  "$CSR_NAME_CONVERGENCIAX" "orderer.convergenciax.com,localhost"


########################################
# Prueba manual emision msp
########################################

#export EXTERNAL_CA_CFG=/home/jcotrado/HLFconvergenciax/external-ca
#export CSR_NAME_ORG1="C=CL,ST=Metropolitana,L=Santiago,O=Org1,OU=ConvergenciaX-HLF"
#
#export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org1.convergenciax.com/int/clients/admin
#fabric-ca-client register --id.name admin@org1.convergenciax.com --id.secret adminPruebaPassword --id.type=admin -u http://admin:adminpw@localhost:7054
#
#export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org1.convergenciax.com/int/clients/adminPrueba@org1.convergenciax.com
#fabric-ca-client enroll -u http://admin:adminpw@localhost:7054 --csr.names "$CSR_NAME_ORG1" --csr.hosts localhost