#!/bin/bash

kubectl create namespace ngdays-2020-pod
kubectl create namespace ngdays-2020-deployment
kubectl create namespace ngdays-2020-hpa
kubectl create namespace ngdays-2020-canary-regular
kubectl create namespace ngdays-2020-canary-preview
kubectl create namespace nginx-ingress-controller
kubectl create namespace cert-manager