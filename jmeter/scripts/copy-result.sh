#!/bin/bash

# The MSYS_NO_PATHCONV environment variable in Git Bash is used to disable
# the automatic conversion of Unix-style paths to Windows-style paths.
# When this variable is set to 1, Git Bash will not alter paths, allowing
# commands to interpret paths exactly as they are written, which is
# particularly useful for commands that expect Unix-style paths without
# any modifications.
export MSYS_NO_PATHCONV=1

# Kubernetes' namespace
NAMESPACE="benchmarking-goapi"

# Get the running pods
PODS=$(kubectl get pods -n $NAMESPACE --field-selector=status.phase=Running -o json)

# Search for pods that start with "jmeter" and get the most recent executed
LATEST_JMETER_POD=$(echo "$PODS" | jq -r '.items[] | select(.metadata.name | contains("jmeter-")) | .metadata.creationTimestamp + " " + .metadata.name' | sort | tail -n 1 | awk '{print $2}')

# Checks if the jmeter's was found
if [ -z "$LATEST_JMETER_POD" ]; then
  echo "No JMeter's pod found!"
  sleep 5
  exit 1
fi

echo "JMeter's pod found: $LATEST_JMETER_POD"

# Create result folder
DESTINATION="./results"
mkdir -p "$DESTINATION"

# Copying the results
SOURCE="$NAMESPACE/$LATEST_JMETER_POD:/jmeter/results"
kubectl cp  "$SOURCE"  "$DESTINATION"



if [ $? -eq 0 ]; then
  echo "Results copied successfully the the directory: ./results"
else
  echo "Fail when trying to copy the results"
fi
sleep 5
