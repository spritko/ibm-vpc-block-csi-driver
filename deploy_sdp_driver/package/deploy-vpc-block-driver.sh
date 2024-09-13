#!/bin/bash

# Installing VPC block volume CSI Driver to the IKS cluster

set -o nounset
set -o errexit
# set -x

readonly PKG_DIR="$( dirname -- "$BASH_SOURCE"; )"
mkdir -p $PKG_DIR/deploy
cp  ${PKG_DIR}/5.2_acadia.yaml  ${PKG_DIR}/deploy/5.2_acadia.yaml

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo $OSTYPE
  encodeVal=$(base64 -w 0 ${PKG_DIR}/slclient_Gen2.toml)
  sed "s/REPLACE_ME/$encodeVal/g" ${PKG_DIR}/storage-secret-store.yaml > ${PKG_DIR}/deploy/storage-secret-store.yaml
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo $OSTYPE
  encodeVal=$(base64 -i ${PKG_DIR}/slclient_Gen2.toml)
  sed "s/REPLACE_ME/$encodeVal/g" ${PKG_DIR}/storage-secret-store.yaml > ${PKG_DIR}/deploy/storage-secret-store.yaml
fi
#
kubectl apply -f ${PKG_DIR}/deploy/storage-secret-store.yaml
kubectl apply -f ${PKG_DIR}/deploy/5.2_acadia.yaml

