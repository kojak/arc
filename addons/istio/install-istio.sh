#!/usr/bin/env bash

declare -r here="$(dirname "$(pwd -P)/${BASH_SOURCE[0]}")"
pushd "$here"

kubectl apply -f namespace.yaml

helm template istio-init --name istio-init --namespace istio-system | kubectl apply -f -

declare crd_count
while true
do
    crd_count=$(echo $(kubectl get crds | grep 'istio.io' | wc -l))
    echo "CRDs: $crd_count"
    if [ $crd_count -eq 23 ]
    then
        echo "OK."
        break
    else
        echo "Waiting..."
    fi
    sleep 1
done

helm template \
    --name istio \
    --namespace istio-system \
    --values values.yaml \
    istio \
    | kubectl apply -f -

kubectl label namespace default --overwrite=true istio-injection=enabled

declare phase
while true
do
    phase=$(kubectl get -n istio-system pod -l app=sidecarInjectorWebhook -o jsonpath='{.items[0].status.phase}')
    echo "Webhook phase: $phase"
    if [[ $phase == "Running" ]]
    then
        echo "OK."
        break
    else
        echo "Waiting..."
    fi
    sleep 1
done

popd
