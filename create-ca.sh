#!/usr/bin/env bash

rm -rf pca
mkdir pca

cd pca
mkdir certs newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial

cp ../openssl.cnf .

echo "Generating root CA key..."

openssl genrsa -aes256 -out private/ca.key.pem 2048

echo "===> Root key saved in pca/private/ca.key.pem"
echo ""

chmod 400 private/ca.key.pem

echo "Generating root CA certificate..."
echo ""

openssl req -config openssl.cnf \
      -key private/ca.key.pem \
      -new -x509 -days 3650 -sha256 -extensions v3_ca \
      -out certs/ca.cert.pem

echo "===> Root CA cert saved in pca/certs/ca.cert.pem"
echo ""

echo "Now run sign-ca.sh <CSR file> to create the subordinate CA."

cd ..
