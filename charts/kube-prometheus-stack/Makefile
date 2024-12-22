all:
	helm dependency build --skip-refresh
	helm template .

debug:
	helm show values kube-prometheus-stack --repo https://prometheus-community.github.io/helm-charts
