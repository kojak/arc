# MONITORING

These instructions describe the deploymet of Prometheus and Grafana on minikube.

## Minikube Options
```
minikube start \
--memory=4096 \
--bootstrapper=kubeadm \
--extra-config=scheduler.address=0.0.0.0 \
--extra-config=controller-manager.address=0.0.0.0
```

## Helm Initialization
```
kubectl create serviceaccount tiller --namespace kube-system
kubectl create clusterrolebinding tiller-role-binding --clusterrole cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller
helm repo up
```

## Prometheus Operator
```
helm install stable/prometheus-operator --version=4.3.6 --name=monitoring --namespace=monitoring
```

## Alert Manager
```
kubectl port-forward -n monitoring alertmanager-monitoring-prometheus-oper-alertmanager-0 9093
```

## Grafana
```
kubectl port-forward $(kubectl get pods --selector=app=grafana -n monitoring --output=jsonpath="{.items..metadata.name}") -n monitoring 3000
```
User: admin
Pass: prom-operator


