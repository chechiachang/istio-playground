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

### Trafic management

```
kubectl get virtualservices,destinationrules
NAME                                          GATEWAYS             HOSTS   AGE
virtualservice.networking.istio.io/bookinfo   [bookinfo-gateway]   [*]     3d22h

kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml
kubectl get virtualservices,destinationrules
NAME                                             GATEWAYS             HOSTS           AGE
virtualservice.networking.istio.io/bookinfo      [bookinfo-gateway]   [*]             3d22h
virtualservice.networking.istio.io/details                            [details]       4s
virtualservice.networking.istio.io/productpage                        [productpage]   4s
virtualservice.networking.istio.io/ratings                            [ratings]       4s
virtualservice.networking.istio.io/reviews                            [reviews]       4s

kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml
```

### Fail injection

Default rule
```
kubectl apply -f samples/bookinfo/networking/destination-rule-all.yaml
```

Inject delay
```
kubectl apply -f samples/bookinfo/networking/virtual-service-ratings-test-delay.yaml
```

Clean up
```
kubectl delete -f samples/bookinfo/networking/virtual-service-all-v1.yaml
```

### Traffic Shifting

```
kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-50-v3.yaml
```
