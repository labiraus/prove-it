# prove-it
Benchmarking Utilities

## DevContainers

This project uses [DevContainers](https://code.visualstudio.com/docs/devcontainers/containers) to provide a consistent development environment. To use the DevContainer, you need to have the following installed:
- Docker or a compatible container runtime:
    - [Docker Desktop](https://www.docker.com/)
    - [Podman](https://podman.io/)
    - [Rancher](https://rancher.com/) - `set DOCKER_HOST = npipe:////./pipe/docker_engine`
- [Visual Studio Code](https://code.visualstudio.com/) with the [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension

This will provide you with the following features:
- Golang 1.24.2 (latest at the time of writing)
- [make](https://www.gnu.org/software/make/) - [https://github.com/jungaretti/features/blob/main/src/make/install.sh]
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
- [Skaffold](https://skaffold.dev/)
- [Helm](https://helm.sh/)
- [FluxCD](https://fluxcd.io/)
- [k9s](https://k9scli.io/)

It also provides the following services:
- [PostgreSQL](https://www.postgresql.org/) can be accessed at `postgres:5432`.
    - `psql`
- [Redis](https://redis.io/) can be accessed at `redis:6379`.
    - `redis-cli ping`
- [MongoDB](https://www.mongodb.com/) can be accessed at `mongodb:27017`.
    - `mongosh`
- [RabbitMQ](https://www.rabbitmq.com/) can be accessed at `rabbitmq:5672`.
    - `rabbitmqadmin list queues`
- [Kafka](https://kafka.apache.org/) can be accessed at `kafka:9092`.
    - `kafka-topics.sh --bootstrap-server kafka:9092 --list`
