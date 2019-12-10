source ./env.vars

create_cluster() {

cluster_opts=(--batch-mode \
  --default-admin-password='password' \
  --default-environment-prefix='${USERNAME}' \
  --git-api-token=${TOKEN} \
  --git-provider-kind='github' \
  --git-username=${USERNAME} \
  --cpu=4 \
  --disk-size=150GB \
  --memory=16384MB \
  --vm-driver='kvm2') 

jx create cluster minikube "${cluster_opts[@]}"

[[ -d "${HOME}/.jx/cloud-environments/env-minikube/" ]] || mkdir -p ${HOME}/.jx/cloud-environments/env-minikube/
cp -p ./myvalues.yaml ${HOME}/.jx/cloud-environments/env-minikube/

}

install_jx() {

if [[ $(minikube status | grep -q 'stopped') ]]; then echo "minikube up"; else minikube start; fi

jx_opts=(--cleanup-temp-files=true \
  --provider=minikube \
  --namespace=jx \
  --default-admin-password=password \
  --default-environment-prefix=${USERNAME} \
  --git-username=${USERNAME} \
  --git-provider-kind=github \
  --git-provider-url=${GIT_URL})

jx install "${jx_opts[@]}"

}

dash_deployment() {
    minikube stop ; minikube delete ; rm -rf ~/.jx/ ~/.minikube/ ~/.kube/ ~/.helm/
}

read -d '' USAGE <<- EOF
Usage: deploy [options] 
-h, --help            show this help message and exit
-c, --create          create cluster
-d, --destroy         destroy the cluster
EOF


if [[ $# < 1 ]]; then echo "${USAGE}"; fi
while [[ $# > 0 ]]; do OPTS="$1"; shift

case $OPTS in
      -c|--create)
      echo "Creating cluster"
      create_cluster
      shift
     ;; 
      -d|--destroy)
      echo "Dashing deployment"
      dash_deployment
      shift
     ;;
     -j|--jx)
      echo "Creating cluster"
      install_jx
      shift
     ;; 
      -h|--help)
      echo "Help options include"
      shift
     ;;
      *)
      echo "${USAGE}" # unknown option
     ;;
      \?)
      echo "${USAGE} option" # unknown option
    ;;
esac
done

