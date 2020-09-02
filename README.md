# Angular Days 2020 - SPAs in Kubernetes

This repository contains all source code used as part of the half-day workshop on "Running SPAs in Kubernetes".

## Create Azure Environment

You can create a new environment in Azure using the [create environment script](scripts/create-environment.sh). The script will create the following resources in Azure

- 1 Resource Group
- 1 Azure Container Registry (ACR)
- 1 Azure Kubernetes Service (AKS)

In order to use the script, a local installation of [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) is required. Additionally, ensure you are authenticated `az login` and desired Azure Subscription is selected (see `az account list` and `az account set`).

Consider changing the `ACR_SUFFIX` variable. (ACR requires a globally unique instance name).

## Create Docker Images

Ensure you have installed [Docker](https://docker.com) on your local machine. If Docker is installed and running, you can create the Docker-Images using

```bash
# build frontend v1 image
docker build . -f dockerfiles/v1.Dockerfile -t <YOUR_ARC_NAME>.azurecr.io/ngdays2020/frontend-v1:0.0.1

# build frontend v2 image
docker build . -f dockerfiles/v2.Dockerfile -t <YOUR_ARC_NAME>.azurecr.io/ngdays2020/frontend-v2:0.0.1

```

## Publish Docker Images to ACR

First, you have to authenticate with the corresponding ACR instance. You can do so, by using `az acr login` as shown below:

```bash
# authenticate at ACR
az acr login -n <YOUR_ACR_NAME>

```

Once authenticated, you can push the images using regular `docker` CLI commands:

```bash
# push frontend-v1 image
docker push <YOUR_ACR_NAME>.azurecr.io/ngdays2020/frontend-v1:0.0.1

# push frontend-v2 image
docker push <YOUR_ACR_NAME>.azurecr.io/ngdays2020/frontend-v2:0.0.1

```

## Destroy Azure Environment

You can destroy the sample environment in Azure using the [destroy environment script](scripts/destroy-environment.sh).

In order to use the script, a local installation of [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) is required. Additionally, ensure you are authenticated `az login` and desired Azure Subscription is selected (see `az account list` and `az account set`).
