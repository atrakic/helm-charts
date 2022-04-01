MAKEFLAGS += --silent

name := $(shell cat Chart.yaml | grep -m 1 ^name:| awk '{print $$2}' | xargs)
version := $(shell cat Chart.yaml | grep -m 1 ^version:| awk '{print $$2}' | xargs)

all:
	helm dependency update --skip-refresh
	helm lint
	helm package .
	helm template --debug $(name)-$(version).tgz

test:
	helm test --debug .

clean:
	rm -rf $(name)-$(version).tgz
