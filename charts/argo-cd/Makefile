CHART ?= argocd # $(shell basename $$PWD)

all:
	helm dependency build --skip-refresh
	helm template --debug .

install:
	helm upgrade --install --cleanup-on-fail --create-namespace $(CHART) -n $(CHART) .

uninstall:
	helm uninstall $(CHART) -n $(CHART)

debug:
	helm show values argo --repo https://argoproj.github.io/argo-helm
