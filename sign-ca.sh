#!/usr/bin/env bash

PCA_CSR_FILE=$1

openssl ca -config pca/openssl.cnf -extensions v3_intermediate_ca -days 3650 -notext -md sha256 -in ${PCA_CSR_FILE} -out pca/certs/pca.cert.pem -policy policy_loose

echo "PCA certificate generated in pca/certs/pca.cert.pem"
