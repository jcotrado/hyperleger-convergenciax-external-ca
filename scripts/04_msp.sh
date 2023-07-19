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

cp $EXTERNAL_CA_CFG/$org/tls-int/ca-chain.pem $TLS_DIRECTORY_PATH/ca.crt

cp $EXTERNAL_CA_CFG/$org/tls-int/clients/$name/msp/signcerts/cert.pem $TLS_DIRECTORY_PATH/server.crt

key=$(find $EXTERNAL_CA_CFG/$org/tls-int/clients/$name/msp/keystore -name *_sk)
cp $key $TLS_DIRECTORY_PATH/server.key

}

echo "###################################################################"
echo "# Copiar material criptografico de a los msp de user, peer, orderer"
echo "###################################################################"
echo "###################################################################"
echo "###################################################################"



echo "########################################"
echo "# createChannelMSP"
echo "########################################"
createChannelMSP org1.convergenciax.com
createChannelMSP org2.convergenciax.com
createChannelMSP org3.convergenciax.com
createChannelMSP convergenciax.com

echo "########################################"
echo "# org1, Org2 y Org3 a sus Peers "
echo "########################################"

createLocalMSP org1.convergenciax.com peer0@org1.convergenciax.com peer
createTLSDirectory org1.convergenciax.com peer0@org1.convergenciax.com peer

createLocalMSP org2.convergenciax.com peer0@org2.convergenciax.com peer
createTLSDirectory org2.convergenciax.com peer0@org2.convergenciax.com peer

createLocalMSP org2.convergenciax.com peer0@org2.convergenciax.com peer
createTLSDirectory org2.convergenciax.com peer0@org2.convergenciax.com peer

createLocalMSP org3.convergenciax.com peer0@org3.convergenciax.com peer
createTLSDirectory org3.convergenciax.com peer0@org3.convergenciax.com peer


echo "########################################"
echo "# Orderer "
echo "########################################"

# Orderer
createLocalMSP convergenciax.com orderer.convergenciax.com orderer
createTLSDirectory convergenciax.com orderer.convergenciax.com orderer

echo "########################################"
echo "# Admins User de Org1, Org2 , Org3 y convergenciax "
echo "########################################"

# Admins
createLocalMSP org1.convergenciax.com admin@org1.convergenciax.com user
createTLSDirectory org1.convergenciax.com admin@org1.convergenciax.com user

createLocalMSP org2.convergenciax.com admin@org2.convergenciax.com user
createTLSDirectory org2.convergenciax.com admin@org2.convergenciax.com user

createLocalMSP org3.convergenciax.com admin@org3.convergenciax.com user
createTLSDirectory org3.convergenciax.com admin@org3.convergenciax.com user

createLocalMSP convergenciax.com admin@convergenciax.com user
createTLSDirectory convergenciax.com admin@convergenciax.com user

