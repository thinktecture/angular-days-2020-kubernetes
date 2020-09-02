# Verify Scaling

The sample hosts just a single page application using nginx. The overall utilization is quite low. Use `kubectl top pod` and `kubectl top node` to see actual load.

To get fundamental metadata about the scaling, use `kubectl get hpa letsscale -n ngdays-2020-hpa`.

## Simulate load

Easiest way to generate a bunch of load is by using a dedicated "development" box directly in the Kubernetes cluster and issue requests to the [Service](service.yml).

```bash
kubectl run -it --rm simulation --image=busybox /bin/sh
#Hit enter for command prompt
while true; do wget -q -O- http://frontend:8080; done

```

You can cancel the simulation at any point in time using `[CTRL]+C` and quit the `simulation` Pod using `CTRL+D`. Due to the `--rm` flag, Kubernetes will delete the Pod once exited.
