FROM mcr.microsoft.com/devcontainers/go:latest

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        curl \
        gnupg \
        iputils-ping \
        file \
        socat \
    # Add PostgreSQL repository
    && curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /usr/share/keyrings/postgresql.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    # Add MongoDB repository
    && curl -fsSL https://pgp.mongodb.com/server-6.0.asc | gpg --dearmor -o /usr/share/keyrings/mongodb.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/mongodb.gpg] https://repo.mongodb.org/apt/debian $(lsb_release -cs)/mongodb-org/6.0 main" > /etc/apt/sources.list.d/mongodb-org-6.0.list \
    && apt-get update

RUN apt-get -y install --no-install-recommends \
        openjdk-17-jre-headless \
        redis-tools \
        postgresql-client-17 \
        mongodb-mongosh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download and install AWS CLI
RUN curl -fLsS https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
        -o /tmp/awscliv2.zip \
    && unzip /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/aws /tmp/awscliv2.zip

# Download and install rabbitmqadmin
RUN curl -fLsS https://github.com/rabbitmq/rabbitmqadmin-ng/releases/download/v2.1.0/rabbitmqadmin-2.1.0-x86_64-unknown-linux-gnu \
        -o /usr/local/bin/rabbitmqadmin \
    && chmod +x /usr/local/bin/rabbitmqadmin

# Download and extract Kafka
RUN curl -fLsS https://dlcdn.apache.org/kafka/4.0.0/kafka_2.13-4.0.0.tgz \
        -o /tmp/kafka.tgz \
    && tar -xzf /tmp/kafka.tgz -C /usr/local \
    && ln -s /usr/local/kafka_2.13-4.0.0/bin/* /usr/local/bin/ \
    && mkdir -p /tmp/kafka-logs \
    && chmod 777 /tmp/kafka-logs \
    && rm /tmp/kafka.tgz

USER vscode
# install latest gorm gen tool
RUN go install gorm.io/gen/tools/gentool@latest
USER root

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1

COPY ./.rediscli.rc ~/.rediscli.rc
COPY ./.bashrc /home/vscode/.bashrc
RUN chown vscode:vscode /home/vscode/.bashrc
COPY ./.aws /home/vscode/.aws
RUN chown -R vscode:vscode /home/vscode/.aws