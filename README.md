istio-playground
===

# Install

### K8s

```
minikube start
# or
make kind
```

### Fetch istio

```
curl -L https://istio.io/downloadIstio | sh -
sudo mv istio-1.6.4/bin/istioctl /usr/local/bin

istioctl version
1.6.4

cd istio-1.6.4
```

---

# Get started

Fetch examples
```
kpt 
```

```
minikube start

istioctl install --set profile=demo
kubectl label namespace default istio-injection=enabled

kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
```

```
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')
export INGRESS_HOST=$(minikube ip)
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
open http://$GATEWAY_URL/productpage
```

# Configuration

```
kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml
```


