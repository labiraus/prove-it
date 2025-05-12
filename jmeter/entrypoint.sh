#!/bin/bash
set -e
TEST_PLAN=${1:-go-api-plan.jmx}
RESULTS_FILE=${2:-go-api-plan-result.jtl}
SLEEP_TIME=${3:-300}
DASHBOARD_DIR=./results/dashboard

echo "Running test plan"
${JMETER_BIN}/jmeter -n -f -t ./plans/"${TEST_PLAN}" -l ./results/"${RESULTS_FILE}"

#It cleans the dashboard dir
if [ -d "${DASHBOARD_DIR}" ]; then
  rm -rf "${DASHBOARD_DIR}"/*
fi

echo "Generating dashboard"
${JMETER_BIN}/jmeter -f -g ./results/"${RESULTS_FILE}" -o ${DASHBOARD_DIR}
echo "JMeter executed successfully"

# Copy the results while it is sleeping. It is not possible copy the result after the job ends.
echo "Sleep time for copying results..."
sleep ${SLEEP_TIME}
echo "Time is over..."
