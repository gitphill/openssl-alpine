#!/usr/bin/env bash
if [ $# -eq 0 ]
  then
    echo "Please inform a prefix for the keys. Optionally, inform as your second parameter the bit length to be used by your key generator"
    exit 1
fi
cert_prefix=$1
if [ $# -eq 2 ] 
  then
    bitlength=$2
else
    bitlength=2048
fi

mkdir $cert_prefix
cd $cert_prefix

openssl genrsa -out "${cert_prefix}_privatekey.pem" $bitlength
openssl req -newkey rsa:$bitlength -x509 -key "${cert_prefix}_privatekey.pem" -out "${cert_prefix}_publickey.cer"
openssl pkcs8 -topk8 -nocrypt -in "${cert_prefix}_privatekey.pem" -out "${cert_prefix}_privatekey.pkcs8"
openssl x509 -pubkey -noout -in "${cert_prefix}_publickey.cer"  > "${cert_prefix}_publickey.pem"

echo "Keys created in the folder: $(pwd)"