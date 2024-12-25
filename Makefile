# Set the shell to bash always
SHELL := /bin/bash

.PHONY: all ct-test ct-install clean-helm install clean

BASEDIR=$(shell git rev-parse --show-toplevel)
KIND_CLUSTER_NAME ?= $(shell basename $$PWD)
KIND=$(shell which kind)

define KIND_CONFIG
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  # Patch kubeadm to add node labels for accepting ingress.
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
endef

export KIND_CONFIG

all:
	$(KIND) get kubeconfig --name $(KIND_CLUSTER_NAME) > /dev/null 2>&1 \
	|| echo "$$KIND_CONFIG" | $(KIND) create cluster --name=$(KIND_CLUSTER_NAME) --wait 120s --config=- $ 2>&1
	kubectl create ns argocd || true
	kubectl create ns monitoring || true
	# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	# kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
	kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.16.2/cert-manager.crds.yaml
	kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-cd/refs/heads/master/manifests/crds/application-crd.yaml
	kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-cd/refs/heads/master/manifests/crds/applicationset-crd.yaml
	kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-cd/refs/heads/master/manifests/crds/appproject-crd.yaml

install:
	pushd $(BASEDIR)/charts/argocd-apps; make -f $(BASEDIR)/charts/Makefile.charts $@; popd

ct-test:
	ct --config .github/configs/ct.yaml lint --debug

ct-install:
	ct --config .github/configs/ct.yaml install # --debug
	helm list -A --all

status:
	kubectl get applications.argoproj.io -A

clean-helm:
	helm ls --all --short | xargs -L1 helm delete

clean: clean-helm
	echo kind delete cluster --name $(KIND_CLUSTER_NAME)
