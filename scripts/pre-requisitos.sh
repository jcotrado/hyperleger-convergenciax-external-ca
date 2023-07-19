#Instalar y configurar golanguaje
#wget -c https://golang.org/dl/go1.20.5.linux-amd64.tar.gz
#sudo tar -C /usr/local -xvzf go1.20.5.linux-amd64.tar.gz
#apt install golang-go
#apt install gccgo-go
#mkdir -p ~/go/{bin,src,pkg}
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export GOBIN=/usr/local/go/bin
export GOROOT=/usr/local/go

#sudo apt install gcc
#apt install gccgo-go

#go get -u github.com/hyperledger/fabric/tree/main/cmd/configtxgen
#go get -u github.com/hyperledger/fabric/tree/main/cmd/configtxlator
#go get -u github.com/hyperledger/fabric/tree/main/cmd/peer
#go get -u github.com/hyperledger/fabric-sdk-node/tree/main/fabric-ca-client

export PATH=$PATH:$GOPATH/bin


#Pre-requisitos de fabric-ca-server
sudo apt install libtool libltdl-dev

####
## 00 Crear carpetas con configuraciones de las PKI de cada organizacion
####
export EXTERNAL_CA_CFG=/home/jcotrado/HLFconvergenciax/external-ca/pki-ca


mkdir -p $EXTERNAL_CA_CFG/convergenciax.com/{int,root,root/private,root/certs,tls-int,tls-root,tls-root/private,tls-root/certs }
mkdir -p $EXTERNAL_CA_CFG/org1.convergenciax.com/{int,root,tls-int,tls-root}
mkdir -p $EXTERNAL_CA_CFG/org2.convergenciax.com/{int,root,tls-int,tls-root}
mkdir -p $EXTERNAL_CA_CFG/org3.convergenciax.com/{int,root,tls-int,tls-root}

###
##
## Crear certificado raiz y tls raiz
#
echo "Creating Identity Root CA.."
touch $EXTERNAL_CA_CFG/convergenciax.com/root/index.txt $EXTERNAL_CA_CFG/convergenciax.com/root/identity-rca/serial
echo 1000 > $EXTERNAL_CA_CFG/convergenciax.com/root/serial
echo 1000 > $EXTERNAL_CA_CFG/convergenciax.com/root/crlnumber

openssl ecparam -name prime256v1 -genkey -noout -out $EXTERNAL_CA_CFG/convergenciax.com/root/private/rca.identity.convergenciax.com.key

openssl req -config openssl_root-identity.cnf -new -x509 -sha256 -extensions v3_ca -key $EXTERNAL_CA_CFG/convergenciax.com/root/private/rca.identity.convergenciax.com.key -out $EXTERNAL_CA_CFG/convergenciax.com/root/certs/rca.ident.cert -days 3650 -subj "/C=CL/ST=Metropolitana/L=Santiago/O=convergenciax.com/OU=ConvergenciaX-HLF/CN=rca.identity.convergenciax.com"

echo "Creating TLS Root CA.."
#mkdir -p $EXTERNAL_CA_CFG/convergenciax.com/tls-root/private $EXTERNAL_CA_CFG/convergenciax.com/tls-root/certs $EXTERNAL_CA_CFG/convergenciax.com/tls-root/newcerts $EXTERNAL_CA_CFG/convergenciax.com/tls-root/crl
touch tls-rca/index.txt tls-rca/serial
echo 1000 > $EXTERNAL_CA_CFG/convergenciax.com/tls-root/serial
echo 1000 > $EXTERNAL_CA_CFG/convergenciax.com/tls-root/crlnumber
openssl ecparam -name prime256v1 -genkey -noout -out $EXTERNAL_CA_CFG/convergenciax.com/tls-root/private/rca.tls.convergenciax.com.key
openssl req -config openssl_root-tls.cnf -new -x509 -sha256 -extensions v3_ca -key $EXTERNAL_CA_CFG/convergenciax.com/tls-root/private/rca.tls.convergenciax.com.key -out $EXTERNAL_CA_CFG/convergenciax.com/tls-root/certs/rca.tls.convergenciax.com.cert -days 3650 -subj "/C=CL/ST=Metropolitana/L=Santiago/O=convergenciax.com/OU=ConvergenciaX-HLF/CN=rca.tls.convergenciax.com"


echo "Creating and signing Identity Intermediate CA Cert.."
openssl ecparam -name prime256v1 -genkey -noout -out $ORG_DIR/ca/ica.identity.org1.example.com.key
openssl req -new -sha256 -key $ORG_DIR/ca/ica.identity.org1.example.com.key -out $ORG_DIR/ca/ica.identity.org1.example.com.csr -subj "/C=SG/ST=Singapore/L=Singapore/O=org1.example.com/OU=/CN=ica.ide
ntity.org1.example.com"
openssl ca -batch -config openssl_root-identity.cnf -extensions v3_intermediate_ca -days 1825 -notext -md sha256 -in $ORG_DIR/ca/ica.identity.org1.example.com.csr -out $ORG_DIR/ca/ica.identity.org1.
example.com.cert
cat $ORG_DIR/ca/ica.identity.org1.example.com.cert $PWD/identity-rca/certs/rca.identity.org1.example.com.cert > $ORG_DIR/ca/chain.identity.org1.example.com.cert

echo "Creating and signing TLS Intermediate CA Cert.."
openssl ecparam -name prime256v1 -genkey -noout -out $ORG_DIR/tlsca/ica.tls.org1.example.com.key
openssl req -new -sha256 -key $ORG_DIR/tlsca/ica.tls.org1.example.com.key -out $ORG_DIR/tlsca/ica.tls.org1.example.com.csr -subj "/C=SG/ST=Singapore/L=Singapore/O=org1.example.com/OU=/CN=ica.tls.org
1.example.com"
openssl ca -batch -config openssl_root-tls.cnf -extensions v3_intermediate_ca -days 1825 -notext -md sha256 -in $ORG_DIR/tlsca/ica.tls.org1.example.com.csr -out $ORG_DIR/tlsca/ica.tls.org1.example.c
om.cert
cat $ORG_DIR/tlsca/ica.tls.org1.example.com.cert $PWD/tls-rca/certs/rca.tls.org1.example.com.cert > $ORG_DIR/tlsca/chain.tls.org1.example.com.cert

echo "Starting Intermediate CA.."


###
# 01 - Inicializar los fabric-ca por cada organización de la red, 
#
#  Esto genera el keystore y la configuración inicial en la carpeta root/fabric-ca-server-config.yaml
###

export EXTERNAL_CA_CFG=/home/jcotrado/HLFconvergenciax/external-ca/pki-ca
rm -R  pki-ca/org1.convergenciax.com/
rm -R  pki-ca/org2.convergenciax.com/
rm -R  pki-ca/org3.convergenciax.com/
rm -R  pki-ca/convergenciax.com/


cd /home/jcotrado/HLFconvergenciax/external-ca
export EXTERNAL_CA_CFG=/home/jcotrado/HLFconvergenciax/external-ca/pki-ca

docker-compose -f docker-compose-ca-root.yaml up -d
./script/01_rootca.sh
docker-compose -f docker-compose-ca-int.yaml up -d
./script/01_intca.sh

./scripts/03_identityEmitirCertificado.sh
./scripts/04_msp.sh