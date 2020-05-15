#! /bin/bash
## Creates a small Azure AKS cluster.
## Assumes you have the Azure CLI, and are logged in.

LOCATION=westeurope
GROUP_NAME=$1
KUBERNETES_VERSION=1.16.7
KUBERNETES_CLUSTER_NAME=${GROUP_NAME}-cluster

az group create --name ${GROUP_NAME} --location ${LOCATION}
az aks create --name ${KUBERNETES_CLUSTER_NAME} --kubernetes-version ${KUBERNETES_VERSION} --resource-group ${GROUP_NAME} --location ${LOCATION} --generate-ssh-keys --node-count 1
az aks get-credentials --resource-group ${GROUP_NAME} --name ${KUBERNETES_CLUSTER_NAME}
kubectl config use-context ${KUBERNETES_CLUSTER_NAME}