export EXTERNAL_CA_CFG=/home/jcotrado/HLFconvergenciax/external-ca/pki-ca
sudo chown -R jcotrado:jcotrado $EXTERNAL_CA_CFG

function createChannelMSP(){


org=$1
MSP_PATH=$EXTERNAL_CA_CFG/$org/msp

echo "-----------------------------------------------------------"
echo "createChannelMSP - Copiando certificados a msp [$MSP_PATH]"
echo "-----------------------------------------------------------"
mkdir -p $MSP_PATH
mkdir -p $MSP_PATH/cacerts && cp $EXTERNAL_CA_CFG/$org/root/ca-cert.pem $MSP_PATH/cacerts/ca-cert.pem
mkdir -p $MSP_PATH/intermediatecerts && cp $EXTERNAL_CA_CFG/$org/int/ca-cert.pem $MSP_PATH/intermediatecerts/ca-cert.pem
mkdir -p $MSP_PATH/tlscacerts && cp $EXTERNAL_CA_CFG/$org/tls-root/ca-cert.pem $MSP_PATH/tlscacerts/ca-cert.pem
mkdir -p $MSP_PATH/tlsintermediatecerts  && cp $EXTERNAL_CA_CFG/$org/tls-int/ca-cert.pem $MSP_PATH/tlsintermediatecerts/ca-cert.pem

}


function createLocalMSP(){

org=$1
name=$2
type=$3

LOCAL_MSP_PATH=$EXTERNAL_CA_CFG/$org/${type}s/$name/msp
echo "-----------------------------------------------------------"
echo "createLocalMSP - Copiando certificados a local msp [$LOCAL_MSP_PATH]"
echo "-----------------------------------------------------------"

mkdir -p $LOCAL_MSP_PATH
cp $EXTERNAL_CA_CFG/$org/msp/config.yaml $LOCAL_MSP_PATH

mkdir -p $LOCAL_MSP_PATH/cacerts && cp $EXTERNAL_CA_CFG/$org/root/ca-cert.pem $LOCAL_MSP_PATH/cacerts/ca-cert.pem
mkdir -p $LOCAL_MSP_PATH/intermediatecerts && cp $EXTERNAL_CA_CFG/$org/int/ca-cert.pem $LOCAL_MSP_PATH/intermediatecerts/ca-cert.pem
mkdir -p $LOCAL_MSP_PATH/tlscacerts && cp $EXTERNAL_CA_CFG/$org/tls-root/ca-cert.pem $LOCAL_MSP_PATH/tlscacerts/ca-cert.pem
mkdir -p $LOCAL_MSP_PATH/tlsintermediatecerts  && cp $EXTERNAL_CA_CFG/$org/tls-int/ca-cert.pem $LOCAL_MSP_PATH/tlsintermediatecerts/ca-cert.pem
mkdir -p $LOCAL_MSP_PATH/signcerts  && cp -r $EXTERNAL_CA_CFG/$org/int/clients/$name/msp/signcerts $LOCAL_MSP_PATH
mkdir -p $LOCAL_MSP_PATH/keystore  && cp -r $EXTERNAL_CA_CFG/$org/int/clients/$name/msp/keystore $LOCAL_MSP_PATH

}

function createTLSDirectory(){

org=$1
name=$2
type=$3

TLS_DIRECTORY_PATH=$EXTERNAL_CA_CFG/$org/${type}s/$name/tls
echo "-----------------------------------------------------------"
echo "createTLSDirectory - Copiando certificados a TLS [$TLS_DIRECTORY_PATH]"
echo "-----------------------------------------------------------"

mkdir -p $TLS_DIRECTORY_PATH

cp $EXTERNAL_CA_CFG/$org/tls-int/ca/ca-chain.pem $TLS_DIRECTORY_PATH/ca.crt

cp $EXTERNAL_CA_CFG/$org/tls-int/clients/$name/msp/signcerts/cert.pem $TLS_DIRECTORY_PATH/server.crt

key=$(find $EXTERNAL_CA_CFG/$org/tls-int/clients/$name/msp/keystore -name *_sk)
cp $key $TLS_DIRECTORY_PATH/server.key

}

createChannelMSP org1.convergenciax.com
#createChannelMSP org2.convergenciax.com
#createChannelMSP org3.convergenciax.com
#createChannelMSP acme.com

createLocalMSP org1.convergenciax.com peer0@org1.convergenciax.com peer
createTLSDirectory org1.convergenciax.com peer0@org1.convergenciax.com peer



# Orderer
#createLocalMSP acme.com orderer.convergenciax.com orderer
#createTLSDirectory acme.com orderer.convergenciax.com orderer

# Admins

createLocalMSP org1.convergenciax.com admin@org1.convergenciax.com user
createTLSDirectory org1.convergenciax.com admin@org1.convergenciax.com user



#createLocalMSP acme.com admin@acme.com user
#createTLSDirectory acme.com admin@acme.com user

