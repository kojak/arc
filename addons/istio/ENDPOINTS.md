To discover service endoints execute the following command.
```
kubectl get ep --all-namespaces
```

To access endpoints use the following port forwarding command.

```
kubectl port-forward $(kubectl get pods --selector=app=<app> -n <namespace> --output=jsonpath="{.items..metadata.name}") -n <namespace> <port>
```

For example to access grafana
```
k port-forward $(kubectl get pods --selector=app=grafana -n istio-system --output=jsonpath="{.items..metadata.name}") -n istio-system 3000
```
