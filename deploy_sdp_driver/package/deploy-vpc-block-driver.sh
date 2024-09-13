#!/bin/bash

# Installing VPC block volume CSI Driver to the IKS cluster

set -o nounset
set -o errexit
# set -x

update_stg_secret=0

readonly PKG_DIR="$( dirname -- "$BASH_SOURCE"; )"
mkdir -p $PKG_DIR/deploy
cp  ${PKG_DIR}/5.2_acadia.yaml  ${PKG_DIR}/deploy/5.2_acadia.yaml

if [[ $update_stg_secret -ne 0 ]]; then
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
  echo "Updating storage-secret-store"
  kubectl apply -f ${PKG_DIR}/deploy/storage-secret-store.yaml
fi
kubectl apply -f ${PKG_DIR}/deploy/5.2_acadia.yaml

