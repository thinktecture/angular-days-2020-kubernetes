# Kubernetes Deployments

Consider following this guide to deploy everything to kubernetes

## Create Namespaces

```bash
# create namespaces for all samples
./01-create-namespaces.sh

```

## Deploy NGINX Ingress & CertManager

Some examples in this repository use ingress to configure inbound traffic using custom domain names and SSL certificates issued by Let's Encrypt

```bash
# deploy NGINX ingress
./02-deploy-nginx-ingress.sh

# deploy CertManager
./03-deploy-certmanager.sh

```

## Create an Azure DNS Zone

Create a DNS Zone in Azure for your domain:

```bash
# create a new top-level DNS zone for the domain
az network dns zone create \
  --resource-group tt-conferences \
  --name thinktecture-demos.com

```

Next, you need to get the IP address associated to NGINX Ingress

```bash
# get external address associated to ingress
kubectl get svc -n nginx-ingress-controller
# NAME                                               TYPE           CLUSTER-IP    EXTERNAL-IP
# nginx-ingress-ingress-nginx-controller             LoadBalancer   10.0.34.127   51.144.189.92

```

Having the external IP address (here `51.144.189.92`), we can create a A records for the required sub-domains using Azure CLI

```bash
# canary.thinktecture-demos.com
az network dns record-set a add-record -g tt-conferences \
  -z canary.thinktecture-demos.com \
  -n canary -a 51.144.189.92

# deployment.thinktecture-demos.com
az network dns record-set a add-record -g tt-conferences \
  -z deployment.thinktecture-demos.com \
  -n deployment -a 51.144.189.92

# hpa.thinktecture-demos.com
az network dns record-set a add-record -g tt-conferences \
  -z hpa.thinktecture-demos.com \
  -n hpa -a 51.144.189.92

```

## Configure nameserver settings

Update the nameserver settings of your domain and point to the Azure nameservers associated to your Azure DNS zone. You can get all nameservers using CLI as shown below:

```bash
# Get Azure DNS Nameservers for custom domain
az network dns zone show -n thinktecture-demos.com \
  -g tt-conferences \
  --query 'nameServers' -o jsonc

```

## Deploy Cluster Issuer for Let's Encrypt

Deploy the `ClusterIssuer` for the Let's Encrypt TLS certificates. Ensure to provide a valid email address in [the ClusterIssuer declaration](tls/cluster-issuer.yml) and consider using Let's Encrypt staging API during development time (see corresponding comment in cluster-issuer.yml).

```bash
kubectl apply -f ./tls
```

## Deploy Simple Pod Example

```bash
# deploy simple pod example
kubectl apply -f ./pod

```

See [Pod Readme](pod/README.md) for further instructions

## Deploy Deployment Example

```bash
# deploy deployment example
kubectl apply -f ./deployment

```

Acquiring the certificate from Let's Encrypt could take a few seconds. 

## Deploy HPA Example

```bash
# deploy hpa example
kubectl apply -f ./hpa

```

Acquiring the certificate from Let's Encrypt could take a few seconds. For more information see the [corresponding README](hpa/README.md).

## Deploy Canary Example

```bash
# deploy canary (regular) example
kubectl apply -f ./canary/regular

# deploy canary (preview) example
kubectl apply -f ./canary/preview
```

Acquiring the certificate from Let's Encrypt could take a few seconds. For more information see the [corresponding README](canary/README.md).

### Verify certificates

```bash
# get certificate for specific namespace
kubectl get certificate -o wide --namespace <NAMESPACE>

# or for all namespaces
kubectl get certificate -o wide --all-namespaces

```