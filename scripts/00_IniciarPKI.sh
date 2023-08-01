cd /home/jcotrado/HLFconvergenciax/external-ca

#rmdir --ignore-fail-on-non-empty ./pki-ca/convergenciax.com
#rmdir --ignore-fail-on-non-empty ./pki-ca/org1.convergenciax.com
#rmdir --ignore-fail-on-non-empty ./external-ca/pki-ca/org2.convergenciax.com
#rmdir --ignore-fail-on-non-empty ./external-ca/pki-ca/org3.convergenciax.com

#tar -xvf pki-ca.tar

docker-compose -f docker-compose-ca-root.yaml up -d
sleep 5
#./scripts/01_rootca.sh
docker-compose -f docker-compose-ca-int.yaml up -d
sleep 5
#./scripts/02_intca.sh

#./scripts/03_identityEmitirCertificado.sh
#./scripts/04_msp.sh
