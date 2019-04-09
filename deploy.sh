source ./env.vars

create_cluster() {

cluster_opts=(--batch-mode \
--no-default-environments=true \
--default-admin-password='password' \
--default-environment-prefix='biomexio' \
--git-api-token=${TOKEN} \
--git-provider-kind='github' \
--git-provider-url='https://github.com' \
--git-username=${USERNAME})

jx create cluster minikube "${cluster_opts[@]}"

cp -p ~/work/src/bitbucket.org/biomexio/biomex-sdlc/myvalues.yaml ~/.jx/cloud-environments/env-minikube/

}

addon_gitea() {

gitea_opts=(--username=${USERNAME} \
--password='password' \
--email=${EMAIL} \
--helm-update=true \
--install-dependencies=true)
    
jx create addon gitea "${gitea_opts[@]}"

}

install_jx() {

if [[ $(minikube status | grep -q 'stopped') ]]; then echo "minikube up"; else minikube start; fi

GIT_URL="http://gitea-gitea.jx.$(minikube ip).nip.io"

jx_opts=(--cleanup-temp-files=true \
--provider=minikube \
--default-admin-password='password' \
--default-environment-prefix='biomexio' \
--git-username=${USERNAME} \
--git-provider-kind='gitea' \
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
-i, --install         install jx
-d, --dash            destroy the cluster
EOF


if [[ $# < 1 ]]; then echo "${USAGE}"; fi
while [[ $# > 0 ]]; do OPTS="$1"; shift

case $OPTS in
    -c|--create)
    echo "Creating cluster"
    create_cluster
    addon_gitea
    shift
    ;; 
    -i|--install)
    echo "Installing jx"
    install_jx
    shift
    ;;
    -d| --dash)
    echo "Dashing deployment"
    dash_deployment
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

