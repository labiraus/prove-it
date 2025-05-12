#!/bin/bash

# Kubernetes' namespace
NAMESPACE="benchmarking-goapi"

# Kubectl command
KUBECTL_COMMAND="kubectl -n $NAMESPACE"

echo "Deleting jobs starting with \"jmeter\"..."

# Get all jobs that start with "jmeter"
JOBS=$($KUBECTL_COMMAND get jobs --no-headers -o custom-columns=":metadata.name" | grep -i 'jmeter')

# Loop through each job and delete it
for JOB in $JOBS; do
  echo "Deleting job: $JOB"
  $KUBECTL_COMMAND delete job $JOB
done

echo "Jobs deleted."
