#!/bin/bash

# global variables
RG_NAME=dev-thh
AKS_NAME=aks-demo

az aks get-credentials -n $AKS_NAME -g $RG_NAME

kubectl config get-contexts $AKS_NAME

kubectl config use-context $AKS_NAME