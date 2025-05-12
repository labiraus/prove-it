#!/bin/bash
echo -e "\033[34mAdding Kubernetes Gateway API CRD\033[0m"
# This may not be needed in the future, but Kubernetes Gateway API has only just come out of beta
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.0.0/standard-install.yaml

# Add istio to helm
echo -e "\033[34mPulling istio into helm repo\033[0m"
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update

# Install istio helm chart
echo -e "\033[34mInstalling Istio with helm\033[0m"
kubectl create namespace istio-system
helm install istio-base istio/base -n istio-system --set defaultRevision=default --wait
helm install istiod istio/istiod -n istio-system --wait

echo -e "\033[34mWaiting for Istio installation to stabilise\033[0m"
kubectl wait --for=condition=available --timeout=600s deployment -l app=istiod -n istio-system

echo -e "\033[34mInstalling Grafana\033[0m"
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons/grafana.yaml

echo -e "\033[34mInstalling Prometheus\033[0m"
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons/prometheus.yaml

echo -e "\033[34mRunning Skaffold\033[0m"
skaffold run -f ./benchmarking/skaffold-goapi.yaml
