#!/bin/bash

https://github.com/jetstack/cert-manager/releases/download/v1.0.0-beta.1/cert-manager.yaml

 helm repo add jetstack https://charts.jetstack.io
 helm repo update

 helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v0.16.1