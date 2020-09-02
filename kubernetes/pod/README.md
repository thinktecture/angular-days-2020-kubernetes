# Pod Deployment Sample

This will run a single instance of the Container (smallest unit of work in Kubernetes is a Pod).

You can access a pod in Kubernetes using port-forwarding. The following script will configure port-forwarding from your local machine (port `8080`) to port `80` of the pod deployed to the Kubernetes namespace `ngdays-2020-pod`:

```bash
 kubectl port-forward -n ngdays-2020-pod $(kubectl get po -n ngdays-2020-pod -o custom-columns=:metadata.name --no-headers) 8080:80

```