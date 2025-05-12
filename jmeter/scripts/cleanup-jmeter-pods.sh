#!/bin/bash

# Kubernetes' namespace
NAMESPACE="benchmarking-goapi"

echo "Deleting pods starting with \"jmeter\"..."

# Loop through pods and delete those starting with "jmeter"
kubectl get pods --no-headers -o custom-columns=":metadata.name" -n $NAMESPACE | grep -i 'jmeter' | while read -r POD; do
    echo "Deleting pod: $POD"
    kubectl delete pod $POD -n $NAMESPACE
done

echo "Pods deleted."
