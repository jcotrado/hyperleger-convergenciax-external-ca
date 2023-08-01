cd /home/jcotrado/HLFconvergenciax/external-ca

docker-compose -f docker-compose-ca-int.yaml down
sleep 2
docker-compose -f docker-compose-ca-root.yaml down
sleep 2
rmdir --ignore-fail-on-non-empty ./pki-ca/convergenciax.com
rmdir --ignore-fail-on-non-empty ./pki-ca/org1.convergenciax.com
rmdir --ignore-fail-on-non-empty ./pki-ca/org2.convergenciax.com
rmdir --ignore-fail-on-non-empty ./pki-ca/org3.convergenciax.com


#tar -xvf 03_enrroladosIntermediosCA+TLS.tar
tar -xvf 04_clientesEmitidos.tar 

docker-compose -f docker-compose-ca-root.yaml up -d
sleep 2
#./scripts/01_rootca.sh
docker-compose -f docker-compose-ca-int.yaml up -d
sleep 2
#./scripts/02_intca.sh

#./scripts/03_identityEmitirCertificado.sh
#./scripts/04_msp.sh


