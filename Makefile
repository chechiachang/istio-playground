SHELL:=/bin/bash
UNAME_S := $(shell uname -s)

# Infra

kind:
	kind create cluster --config kind.yaml

kiali:
	istioctl dashboard kiali

# sample

samples:
	kpt pkg get https://github.com/istio/istio.git/samples@1.6.4 samples

#ifeq ($(UNAME_S),Linux)
#tag:
#	sed -i 's|image:.*|image: $(image_name)|g' deploy/deployment.yaml
#endif
#ifeq ($(UNAME_S),Darwin)
#tag:
#	sed -i "" 's|image:.*|image: $(image_name)|g' deploy/deployment.yaml
#endif
