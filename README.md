# ARC

ARC is in an implementation of the Autonomous Remote Collaboration pattern based on JenkinsX running on minikube. This pattern stresses the importance of parity between the developers local environment and the cloud. The ability to develop cloud native applications offline with the same toolset that is made available via the cloud is a key feature of the pattern. Emphasis is placed on the developers ability to work remotely in an autonomous way by eliminating dependencies on tooling and processes which would otherwise require unnecessary attention and intervention.  

![Alt text](screenshot.png?raw=true "ARC")

## Techincal detials.

ARC installes JenkinsX on a kubernetes cluster which is deployed via minikube on the developers virtual machine. All the major hypervisors are supported and have been tested on MacOS and Linux. Developers can deploy there preffered tooling as docker containers on their localhost just as they would do on any Kubernetes cluster in cloud.

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

## Import your repos and attempt a build.

```
jx import --no-draft=true --no-jenkinsfile=true <repo>
```

Uninstall the cluster.

```
./deploy.sh -d 
```
