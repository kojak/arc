# ARC

ARC is in an implementation of the Autonomous Remote Collaboration pattern based on JenkinsX running on minikube. This pattern stresses the importance of parity between the developers local environment and the cloud. The ability to develop cloud native applications offline with the same toolset that is made available via the cloud is a key feature of the pattern. Emphasis is placed on the developers ability to work remotely in an autonomous way by eliminating dependencies on tooling and processes which would otherwise require unnecessary attention and intervention.  

![Alt text](screenshot.png?raw=true "ARC")

## Techincal details.

ARC installs JenkinsX on a kubernetes cluster which is deployed via minikube on the developers virtual machine. All the major hypervisors are supported and have been tested on MacOS and Linux. Developers can deploy there preffered tooling as docker containers on their localhost just as they would do on any Kubernetes cluster in cloud.

## Resources.

Links to useful resources and documentation.

## JenkinsX.

```
https://jenkins-x.io/getting-started/create-cluster/#using-minikube-local
https://github.com/jenkins-x

curl -L https://github.com/jenkins-x/jx/releases/download/[LATEST_VERSION]/jx-linux-amd64.tar.gz | tar xzv -C ~/.jx/bin
sudo mv jx /user/local/bin
jx completion bash > jx
sudo mv jx /etc/bash_completion.d/
```

## Minikube.

```
https://kubernetes.io/docs/tasks/tools/install-minikube/
https://github.com/kubernetes/minikube

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64   && chmod +x minikube
sudo install minikube /usr/local/bin
minikube completion bash > minikube
sudo mv minikube /etc/bash_completion.d/
```

## Kubectl.

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

## Known issues.

```
# Enable writethrough disk caching on Linux KVM's.
# Enable pull request on all repos in Gitea.
# Add the Gitea token to the jenkins credentials.
# Update build configuration with the credentials.
# ChecK the Workspace Cleanup Plugin version. 
```

## To Do.

```
Developer workflow - create issue, branch feature, commit & push, pull request. 
Maintainer workflow - list pull request, branch feature, merge feature, commit & push to master.
``` 

## Prerequisites 

Install Minikube and JenkinsX by following the links above to their respective websites. 

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
eval $(minikube docker-env)
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
