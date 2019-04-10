# ARC.
Install minikube and jx using the links to the resources below.

## Resources.

Links to useful resources and documentation.

```
# Jenkins X.

https://jenkins-x.io/getting-started/create-cluster/#using-minikube-local
https://github.com/jenkins-x

# Minikube.

https://kubernetes.io/docs/tasks/tools/install-minikube/
https://github.com/kubernetes/minikube
```

## Known issues.

```
Use writethrough disk caching on KVM's.
```

## ToDo.

```
Shell auto completion for minikube and jx.
Developer workflow - create issue, branch feature, commit & push, pull request. 
Maintainer workflow - list pull request, branch feature, merge feature, commit & push to master.
``` 

## Prerequisites 

Fork all the biomex repos owned by the top level maintainer via the Bitbucket GUI. Currectly all repos are maintained by sbadakhc. 

## Clone your forks.

Use the ssh protocol and your attlassion user name.

```
git clone git@bitbucket.org:<username>/biomex-sdlc.git
```

Create the env.vars file in the cloned repo directory with your github credentials and api key.

```
TOKEN="XXXX"
USERNAME="username"
EMAIL="email"
```

## Create the K8s cluster

```
./deploy.sh -c 
```

## Verfify the installation.

```
minikube status
jx status
docker images
kubectl get po
```

## Access to consoles.
```
minikube dashboard
jx open jenkins
```

## Import the biomex repos and attempt a build.

```
jx import --no-draft=true --no-jenkinsfile=true <repo>
```

Uninstall the cluster.

```
./deploy.sh -d 
```
