cd /home/jcotrado/HLFconvergenciax/external-ca
export EXTERNAL_CA_CFG=/home/jcotrado/HLFconvergenciax/external-ca/pki-ca
sudo chown -R jcotrado:jcotrado $EXTERNAL_CA_CFG
docker-compose -f docker-compose-ca-int.yaml down
sleep 2
docker-compose -f docker-compose-ca-root.yaml down
sleep 2
#rm -r ./pki-ca/convergenciax.com
#rm -r ./pki-ca/org1.convergenciax.com
#rm -r ./pki-ca/org2.convergenciax.com
#rm -r ./pki-ca/org3.convergenciax.com



#mkdir -p $EXTERNAL_CA_CFG/convergenciax.com/{int,root,tls-int,tls-root}
#mkdir -p $EXTERNAL_CA_CFG/org1.convergenciax.com/{int,root,tls-int,tls-root}
#mkdir -p $EXTERNAL_CA_CFG/org2.convergenciax.com/{int,root,tls-int,tls-root}
#mkdir -p $EXTERNAL_CA_CFG/org3.convergenciax.com/{int,root,tls-int,tls-root}



#tar xvf pki-ca.tar
#tar -xvf pki.01-subirDockerCA.tar
#tar -xvf pki.02-registrarAdminCA.tar
#tar -xvf pki.03_registrarIntermediosCA.tar
#tar -xvf pki.04-emitirIdentidades.tar
#tar -xvf pki.05-generarMSP.tar



docker-compose -f docker-compose-ca-root.yaml up -d
sleep 2
sudo chown -R jcotrado:jcotrado $EXTERNAL_CA_CFG
#./scripts/01_rootca.sh
docker-compose -f docker-compose-ca-int.yaml up -d
sleep 2
sudo chown -R jcotrado:jcotrado $EXTERNAL_CA_CFG
#./scripts/02_intca.sh

#./scripts/03_emitirIdentidades.sh
#./scripts/04_msp.sh


