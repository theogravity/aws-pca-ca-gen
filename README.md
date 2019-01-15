# aws-pca-ca-gen

Generate a root CA and create a signed subordinate CA from the generated AWS PCA (Private Certificate Authority) CSR.

## Introduction

In order to create an AWS PCA, the CA that AWS generates from your parameters must be signed by a root CA. If you do not
have a root CA, you must create one, and creating one is not very straightforward. I used two guides to create a set of
scripts to generate a correct root CA and sign the CSR with the right parameters.

- http://bluechiptek.com/blog/using-aws-private-certificate-authority-certificates-to-secure-access-to-kubernetes-helm
- https://jamielinux.com/docs/openssl-certificate-authority/create-the-root-pair.html

If you do not know anything about Private Key Infrastructure (PKI) or how certificates work, please read:

https://smallstep.com/blog/everything-pki.html

It will be one of the most valuable reads of your engineering career as you will encounter working with certificates frequently.

## Notice

The configuration used to generate the key and certificates may not necessarily represent secure or best practices.
Please consult or work with a security expert to determine the right Private Key Infrastructure for your organization.
The provided scripts are for educational purposes only. See `LICENSE` for more info.

## Steps

### Generate the root CA

- Place the Certificate Signing Request (CSR) file that is generated from AWS PCA (if you use the UI to download the
CSR, it will be called `CSR.pem`) in this project's directory.
- Run `create-ca.sh` to create the root CA. Fill in the details as prompted. Password is optional,
if you use a password, use the same one when prompted.

### Generate the signed PCA CA certificate

- Run `sign-ca.sh <CSR file> to sign the CSR` (eg, `./sign-ca.sh CSR.pem)`
- Confirm signing the certificate (y)
- Commit (y)

### Generated Files:

These are the only files you should care about.

- `pca/certs/ca.cert.pem`: Root CA certificate
- `pca/certs/pca.cert.pem`: Subordinate CA certificate used for AWS PCA
- `pca/private/ca.key.pem`: Root CA certificate key

### PCA CA Import

- Use `pca/certs/pca.cert.pem` for the `Certificate Body`
- Use `pca/certs/ca.cert.pem` for the `Certificate Chain`

Your PCA CA should be ready to go at this point!

### See Also

- [aws-pca](https://www.npmjs.com/package/aws-pca) - node.js library to generate and fetch certificates using PCA

