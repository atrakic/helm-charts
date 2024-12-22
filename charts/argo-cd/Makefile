all:
	helm dependency build --skip-refresh
	helm template --debug .

debug:
	helm show values argo --repo https://argoproj.github.io/argo-helm
