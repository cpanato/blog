#!/bin/sh

# Install kubernetes and set config
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

mkdir ${HOME}/.kube
cp kubernetes/config.yaml ${HOME}/.kube/config

# Fill out missing params in kubectl config file
kubectl config set clusters.kubernetes.certificate-authority-data "$KUBE_CA_CERT"
kubectl config set clusters.kubernetes.server "$KUBE_ENDPOINT"
kubectl config set contexts.travis-context.namespace "$KUBE_NAMESPACE"
kubectl config set users.travis.client-certificate-data "$KUBE_TRAVIS_CERT"
kubectl config set users.travis.client-key-data "$KUBE_TRAVIS_KEY"