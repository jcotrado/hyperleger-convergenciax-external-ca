export EXTERNAL_CA_CFG=/home/jcotrado/HLFconvergenciax/external-ca

function issuePKICertificate {
ca=$1
ca_port=$2
org=$3
id_name=$4
id_secret=$5
id_type=$6
csr_names=$7
csr_hosts=$8


export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/$org/$ca/clients/admin

#registro de nueva identidad $id_name en CA ADMIN (tiene permisos)
fabric-ca-client register --id.name $id_name --id.secret $id_secret --id.type=$id_type -u http://admin:adminpw@localhost:$ca_port


# Enrolar nueva identidad registrada
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/$org/$ca/clients/$id_name

fabric-ca-client enroll -u http://$id_name:$id_secret@localhost:$ca_port --csr.names "$csr_names" --csr.hosts "$csr_hosts"

}

function issueTLSCertificate {

tls=$1
tls_port=$2
org=$3
id_name=$4
id_secret=$5
id_type=$6
csr_names=$7
csr_hosts=$8

export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/$org/$tls/clients/admin

#registro de nueva identidad $id_name en CA ADMIN (tiene permisos)
fabric-ca-client register --id.name $id_name --id.secret $id_secret --id.type=$id_type -u http://admin:adminpw@localhost:$tls_port


# Enrolar nueva identidad registrada
export FABRIC_CA_CLIENT_HOME=$EXTERNAL_CA_CFG/pki-ca/$org/$tls/clients/$id_name

fabric-ca-client enroll -u http://$id_name:$id_secret@localhost:$tls_port --csr.names "$csr_names" --csr.hosts "$csr_hosts"

    
}

>>>> sigue minutos 00:46:00