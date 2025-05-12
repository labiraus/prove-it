# JMeter

## Overview
Apache JMeter is an open-source software designed to load test functional behavior and measure performance. It is primarily used for testing web applications, but it can also handle various other services. With its comprehensive features, JMeter supports diverse protocols and offers an intuitive graphical interface for creating test plans.


## Running JMeter

JMeter runs automatically when starts in Kubernetes. In case you want to re-run it again manually in k8s or run it out of kubernetes environment:

[How to run JMeter](../../docs/how-to/benchmarking/jmeter/run-manually.md)


## Getting JMeter results

After JMeter execution, we have to extract the results from the pod. To understand how it works:

[How to get the JMeter results](../../docs/how-to/benchmarking/jmeter/copy-results.md)


## Troubleshooting

If the JMeter container fails to start with reason `exec /entrypoint.sh: no such file or directory` and you are using Visual Studio Code, ensure that the end of line sequence for the entrypoint.sh file is set to "LF" and not "CRLF". After opening the file, this can be changed by clicking the appropriate option in the bottom right of the screen. Alternatively, you can change this through the command palette by pressing CTRL+SHIFT+P and typing "Change end of line sequence"