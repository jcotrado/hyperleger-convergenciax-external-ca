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
export EXTERNAL_CA_CFG=/home/jcotrado/HLFconvergenciax/external-ca/fabric-ca
mkdir -p $EXTERNAL_CA_CFG/convergenciax.com/{int,msp,peers,root,tls-int,tls-root,users}
mkdir -p $EXTERNAL_CA_CFG/org1.convergenciax.com/{int,msp,peers,root,tls-int,tls-root,users}
mkdir -p $EXTERNAL_CA_CFG/org2.convergenciax.com/{int,msp,peers,root,tls-int,tls-root,users}
mkdir -p $EXTERNAL_CA_CFG/org3.convergenciax.com/{int,msp,peers,root,tls-int,tls-root,users}

###
# 01 - Inicializar los fabric-ca por cada organización de la red, 
#
#  Esto genera el keystore y la configuración inicial en la carpeta root/fabric-ca-server-config.yaml
###
docker-compose -f ../docker-compose-ca-root.yaml up -d