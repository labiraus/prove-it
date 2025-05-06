#!/bin/bash

echo "Attempting to download rabbitmqadmin..."
for i in {1..10}; do
    curl -f -O http://rabbitmq:15672/cli/rabbitmqadmin && break || {
        echo "Retrying in 5 seconds..."
        sleep 5
    }
done

chmod +x rabbitmqadmin
sudo mv rabbitmqadmin /usr/local/bin/
echo "rabbitmqadmin installed successfully."