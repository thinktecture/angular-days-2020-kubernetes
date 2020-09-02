#!/bin/bash

# global variables
RG_NAME=angular-days-2020
AZ_REGION=westeurope

# ACR requires unique name, customize the following variable!
ACR_SUFFIX=123

# Create a resource Group
az group create -n $RG_NAME -l $AZ_REGION

# Create an Azure Container Registry
az acr create -n ngdays2020munich$ACR_SUFFIX -g $RG_NAME --sku Basic --admin-enabled false -l $AZ_REGION

# Get ACR Id
ACR_ID=$(az acr show -n ngdays2020munich$ACR_SUFFIX -g $RG_NAME --query "id" -o tsv)

# Create AKS
az aks create -n ngdays2020 -g $RG_NAME --attach-acr $ACR_ID --node-count 2 --enable-managed-identity -l $AZ_REGION