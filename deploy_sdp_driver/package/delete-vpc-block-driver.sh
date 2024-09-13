#!/bin/bash

# Installing VPC block volume CSI Driver to the IKS cluster

set -o nounset
set -o errexit
# set -x


#
kubectl delete CSIDriver vpc.block.csi.ibm.io
kubectl delete StorageClass -l app=ibm-vpc-block-csi-driver
kubectl delete VolumeSnapshotClass -l app=ibm-vpc-block-csi-driver

kubectl delete -n kube-system daemonset -l app=ibm-vpc-block-csi-driver
kubectl delete -n kube-system deployment -l app=ibm-vpc-block-csi-driver
kubectl delete -n kube-system ServiceAccount -l app=ibm-vpc-block-csi-driver
kubectl delete ClusterRole -l app=ibm-vpc-block-csi-driver
kubectl delete ClusterRoleBinding -l app=ibm-vpc-block-csi-driver
kubectl delete -n kube-system configmap -l app=ibm-vpc-block-csi-driver
kubectl delete -n kube-system Secret -l app=ibm-vpc-block-csi-driver