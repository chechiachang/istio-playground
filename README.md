istio-playground
===

# Get Started

```
go get github.com/chechiachang/istio-playground
cd ${GOPATH}/src/github.com/chechiachang/istio-playground
go get -u ./...

go run cmd/server/main.go
```

# Deploy

```
make build push tag
kubectl apply -f deploy/
```

# Use API on K8s

```
POD_ID=$(kc get po --selector='app=istio-playground,component=api-server'  -o=go-template="{{range .items}}{{.metadata.name}}{{end}}")

kubectl exec -it ${POD_ID} --container istio-playground curl istio-playground/ping
{"message":"pong"}

kubectl exec -it ${POD_ID} --container istio-playground curl istio-playground/v1/message
{"message":"v1"}
```
