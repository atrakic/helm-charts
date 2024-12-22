# helm-charts

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

```console
helm repo add atrakic https://atrakic.github.io/helm-charts/
helm repo update
helm search repo atrakic
helm install <my-release> atrakic/<chart>
```

## License
[![license](https://img.shields.io/github/license/atrakic/helm-charts.svg)](https://github.com/atrakic/helm-charts/blob/main/LICENSE)

## Helm charts build status
[![Release Charts](https://github.com/atrakic/helm-charts/actions/workflows/release.yaml/badge.svg)](https://github.com/atrakic/helm-charts/actions/workflows/release.yaml)
