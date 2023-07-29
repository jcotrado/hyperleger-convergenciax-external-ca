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

#echo "---- issueCertificatesPKI--->" $ca $ca_port $org  $id_name $id_secret $id_type $csr_names $csr_hosts
# issueCertificatesPKI int 8054 org1.convergenciax.com admin@org1.convergenciax.com adminpw admin "$CSR_NAME_ORG1" "localhost"
#                      $1  $2   $3                        $4                          $5      $6      $7            $8

export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/$org/$ca/clients/admin
fabric-ca-client register --id.name $id_name --id.secret $id_secret --id.type $id_type -u http://admin:adminpw@localhost:$ca_port

export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/$org/$ca/clients/$id_name
echo "issueCertificatesPKI: Registro/Enroll de nueva identidad $id_name en [$FABRIC_CA_CLIENT_HOME]"
echo "issueCertificatesPKI: fabric-ca-client--enroll -u http://$id_name:$id_secret@localhost:$ca_port --csr.names $csr_names --csr.hosts $csr_hosts" 

fabric-ca-client enroll -u http://$id_name:$id_secret@localhost:$ca_port --csr.names $csr_names --csr.hosts $csr_hosts 

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

#echo "---- issueTLSCertificates ---> " $tls $tls_port $org  $id_name $id_secret $id_type $csr_names $csr_hosts
##issueTLSCertificates tls-int 8055 org1.convergenciax.com admin@org1.convergenciax.com  adminpw  admin  "$CSR_NAME_ORG1" "admin@org1.convergenciax.com,localhost"
#                      $1       $2   $3                        $4                          $5      $6      $7         $8

export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/$org/$tls/clients/admin
fabric-ca-client register --id.name $id_name --id.secret $id_secret --id.type $id_type -u http://admin:adminpw@localhost:$tls_port

export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/$org/$tls/clients/$id_name
echo "issueTLSCertificates: Solicitud de Certificado de nueva TLS $id_name en [$FABRIC_CA_CLIENT_HOME]"
echo "issueTLSCertificates: fabric-ca-client--enroll -u http://$id_name:$id_secret@localhost:$tls_port --csr.names $csr_names --csr.hosts $csr_hosts"
fabric-ca-client enroll -u http://$id_name:$id_secret@localhost:$tls_port --csr.names $csr_names --csr.hosts $csr_hosts --enrollment.profile tls


#export FABRIC_CA_CLIENT_HOME=$PWD/pki-ca/org1.convergenciax.com/tls-int/clients/admin
#fabric-ca-client register --id.name admin3@org1.convergenciax.com --id.secret password --id.type admin -u http://admin:adminpw@localhost:8055
#export FABRIC_CA_CLIENT_HOME=$PWD/pki-ca/org1.convergenciax.com/tls-int/clients/admin3@org1.convergenciax.com
#fabric-ca-client enroll -u http://admin3@org1.convergenciax.com:password@localhost:8055 --csr.names "$CSR_NAME_ORG1" --csr.hosts "admin3@org1.convergenciax.com,localhost" --enrollment.profile tls

}



##################################################################################
######### ORG1 Se crean MSP: admin, client, ordereres y peer de la organizaciones
##################################################################################

echo "##################################################################################"
echo "##  ORG1 Se crean MSP: admin, cliente y peer de la organizacion"
echo "##################################################################################"

export CSR_NAME_ORG1="C=CL,ST=Metropolitana,L=Santiago,O=Org1,OU=ConvergenciaX-HLF"

issueCertificatesPKI int 8054 org1.convergenciax.com admin@org1.convergenciax.com adminpw admin "$CSR_NAME_ORG1" "localhost"
issueTLSCertificates tls-int 8055 org1.convergenciax.com admin@org1.convergenciax.com adminpw admin "$CSR_NAME_ORG1" "admin@org1.convergenciax.com,localhost"

issueCertificatesPKI int 8054 org1.convergenciax.com client@org1.convergenciax.com clientpw client "$CSR_NAME_ORG1" "localhost"
issueTLSCertificates tls-int 8055 org1.convergenciax.com client@org1.convergenciax.com clientpw client "$CSR_NAME_ORG1" "client@org1.convergenciax.com,localhost"

issueCertificatesPKI int 8054 org1.convergenciax.com peer0.org1.convergenciax.com peerpw peer "$CSR_NAME_ORG1" "localhost"
issueTLSCertificates tls-int 8055 org1.convergenciax.com peer0.org1.convergenciax.com peerpw peer "$CSR_NAME_ORG1" "peer0.org1.convergenciax.com,localhost"

##################################################################################
######### ORG2 Se crean MSP: admin, cliente y peer de la organizacion
##################################################################################
echo "##################################################################################"
echo "##  ORG2 Se crean MSP: admin, cliente y peer de la organizacion"
echo "##################################################################################"

export CSR_NAME_ORG2="C=CL,ST=Metropolitana,L=Santiago,O=Org2,OU=ConvergenciaX-HLF"

issueCertificatesPKI int 8056 org2.convergenciax.com admin@org2.convergenciax.com adminpw admin "$CSR_NAME_ORG2" "localhost"
issueTLSCertificates tls-int 8057 org2.convergenciax.com admin@org2.convergenciax.com adminpw admin "$CSR_NAME_ORG2" "admin@org2.convergenciax.com,localhost"

issueCertificatesPKI int 8056 org2.convergenciax.com client@org2.convergenciax.com clientpw client "$CSR_NAME_ORG2" "localhost"
issueTLSCertificates tls-int 8057 org2.convergenciax.com client@org2.convergenciax.com clientpw client "$CSR_NAME_ORG2" "client@org2.convergenciax.com,localhost"

issueCertificatesPKI int 8056 org2.convergenciax.com peer0.org2.convergenciax.com peerpw peer "$CSR_NAME_ORG2" "localhost"
issueTLSCertificates tls-int 8057 org2.convergenciax.com peer0.org2.convergenciax.com peerpw peer "$CSR_NAME_ORG2" "peer0.org2.convergenciax.com,localhost"

##########################################################################
######### ORG3 Se crean MSP: admin, cliente y peer de la organizacion
##########################################################################
echo "##################################################################################"@
echo "##  ORG3 Se crean MSP: admin, cliente y peer de la organizacion"
echo "##################################################################################"

export CSR_NAME_ORG3="C=CL,ST=Metropolitana,L=Santiago,O=Org3,OU=ConvergenciaX-HLF"

issueCertificatesPKI int 8058 org3.convergenciax.com admin@org3.convergenciax.com adminpw admin "$CSR_NAME_ORG3" "localhost"
issueTLSCertificates tls-int 8059 org3.convergenciax.com admin@org3.convergenciax.com adminpw admin "$CSR_NAME_ORG3" "admin@org3.convergenciax.com,localhost"

issueCertificatesPKI int 8058 org3.convergenciax.com client@org3.convergenciax.com clientpw client "$CSR_NAME_ORG3" "localhost"
issueTLSCertificates tls-int 8059 org3.convergenciax.com client@org3.convergenciax.com clientpw client "$CSR_NAME_ORG3" "client@org3.convergenciax.com,localhost"

issueCertificatesPKI int 8058 org3.convergenciax.com peer0.org3.convergenciax.com peerpw peer "$CSR_NAME_ORG3" "localhost"
issueTLSCertificates tls-int 8059 org3.convergenciax.com peer0.org3.convergenciax.com peerpw peer "$CSR_NAME_ORG3" "peer0.org3.convergenciax.com,localhost"

################################################################################
######### CONVERGENCIA - Se crea admin y orderer, no requiere cliente por que no es transaccional.
################################################################################

echo "##################################################################################"
echo "##  Convergencia  Se crean MSP: admin y orderer"
echo "##################################################################################"

export CSR_NAME_CONVERGENCIAX="C=CL,ST=Metropolitana,L=Santiago,O=Orderer,OU=ConvergenciaX-HLF"

issueCertificatesPKI int 8060 convergenciax.com admin@convergenciax.com password admin "$CSR_NAME_CONVERGENCIAX" "localhost"
issueTLSCertificates tls-int 8061 convergenciax.com admin@convergenciax.com password admin "$CSR_NAME_CONVERGENCIAX" "admin@convergenciax.com,localhost"

issueCertificatesPKI int 8060 convergenciax.com orderer.convergenciax.com password orderer "$CSR_NAME_CONVERGENCIAX" "localhost"
issueTLSCertificates tls-int 8061 convergenciax.com orderer.convergenciax.com password orderer "$CSR_NAME_CONVERGENCIAX" "orderer.convergenciax.com,localhost"


########################################
# Prueba manual emision msp
########################################

#export EXTERNAL_CA_CFG=/home/jcotrado/HLFconvergenciax/external-ca
#export CSR_NAME_ORG1="C=CL,ST=Metropolitana,L=Santiago,O=Org1,OU=ConvergenciaX-HLF"
#
#export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org1.convergenciax.com/int/clients/admin
#fabric-ca-client register --id.name admin@org1.convergenciax.com --id.secret adminPruebaPassword --id.type=admin -u http://admin:adminpw@localhost:8054
#
#export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/org1.convergenciax.com/int/clients/adminPrueba@org1.convergenciax.com
#fabric-ca-client enroll -u http://admin:adminpw@localhost:7054 --csr.names "$CSR_NAME_ORG1" --csr.hosts localhost

#export FABRIC_CA_CLIENT_HOME=$PWD/pki-ca/org1.convergenciax.com/tls-int/clients/admin3@org1.convergenciax.com
#fabric-ca-client enroll -u http://admin3@org1.convergenciax.com:password@localhost:8055 --csr.names "$CSR_NAME_ORG1" --csr.hosts "admin3@org1.convergenciax.com,localhost" --enrollment.profile tls
