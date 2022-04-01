all:
	ct lint --config ct.yaml
	ct install --debug --config ct.yaml
