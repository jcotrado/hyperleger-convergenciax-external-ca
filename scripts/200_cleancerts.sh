export EXTERNAL_CA_CFG=/home/jcotrado/HLFconvergenciax/external-ca/pki-ca


function cleanCA(){
    org=$1
    ca=$2

    export CA_PATH=$EXTERNAL_CA_CFG/$org/$ca
    sudo rm -r $CA_PATH/clients
    sudo rm -r $CA_PATH/msp
    sudo rm $CA_PATH/ca-cert.pem
    sudo rm $CA_PATH/fabric-ca-server.db
    sudo rm $CA_PATH/IssuerPublicKey
    sudo rm $CA_PATH/IssuerRevocationPublicKey
    export CA_CHAIN_FILE=$CA_PATH/ca-chain.pem
    if test -f "$CA_CHAIN_FILE"; then
        sudo rm $CA_CHAIN_FILE
    fi
}

function cleanOrgMSP(){
    org=$1

    export MSP_PATH=$EXTERNAL_CA_CFG/$org/msp
    sudo rm -r $MSP_PATH/cacerts
    sudo rm -r $MSP_PATH/intermediatecerts
    sudo rm -r $MSP_PATH/tlscacerts
    sudo rm -r $MSP_PATH/tlsintermediatecerts
}

function cleanLocalMSP(){
    org=$1
    name=$2
    type=$3

    export LOCAL_MSP_PATH=$EXTERNAL_CA_CFG/$org/${type}s/$name/msp
    export TLS_FOLDER_PATH=$EXTERNAL_CA_CFG/$org/${type}s/$name/tls

    sudo rm -r $LOCAL_MSP_PATH
    sudo rm -r $TLS_FOLDER_PATH
}

cleanCA convergenciax.com root
cleanCA convergenciax.com int
cleanCA convergenciax.com tls-root
cleanCA convergenciax.com tls-int
cleanCA org1.convergenciax.com root
cleanCA org1.convergenciax.com int
cleanCA org1.convergenciax.com tls-root
cleanCA org1.convergenciax.com tls-int
cleanCA org2.convergenciax.com root
cleanCA org2.convergenciax.com int
cleanCA org2.convergenciax.com tls-root
cleanCA org2.convergenciax.com tls-int
cleanCA org3.convergenciax.com root
cleanCA org3.convergenciax.com int
cleanCA org3.convergenciax.com tls-root
cleanCA org3.convergenciax.com tls-int

cleanOrgMSP org1.convergenciax.com
cleanOrgMSP org2.convergenciax.com
cleanOrgMSP org3.convergenciax.com
cleanOrgMSP convergenciax.com

cleanLocalMSP org1.convergenciax.com peer0.org1.convergenciax.com peer
cleanLocalMSP org2.convergenciax.com peer0.org2.convergenciax.com peer
cleanLocalMSP org3.convergenciax.com peer0.org3.convergenciax.com peer
cleanLocalMSP convergenciax.com orderer.convergenciax.com orderer

cleanLocalMSP org1.convergenciax.com admin@org1.convergenciax.com user
cleanLocalMSP org2.convergenciax.com admin@org2.convergenciax.com user
cleanLocalMSP org3.convergenciax.com admin@org3.convergenciax.com user
cleanLocalMSP convergenciax.com admin@acme.com user