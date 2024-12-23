all:
	helm dependency build --skip-refresh
	helm template --debug .

install:
	helm upgrade --install argocd -n argocd --create-namespace .

debug:
	helm show values argo --repo https://argoproj.github.io/argo-helm
