SHELL:=/bin/bash
UNAME_S := $(shell uname -s)

# Infra

kind:
	kind create cluster --config kind.yaml

minikube:
	minikube start

# Install

# istioctl profile list

profile:
	istioctl profile dump demo > profile.yaml

install: profile
	istioctl install -f profile.yaml
	#kubectl apply -f samples/addons -n istio-system

verify:
	istioctl verify-install -f profile.yaml

uninstall:
	#kubectl delete -f samples/addons -n istio-system
	istioctl manifest generate --set profile=demo | kubectl delete -f -
	kubectl delete namespace istio-system

# Dashboard

kiali:
	istioctl dashboard kiali

grafana:
	istioctl dashboard grafana

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
