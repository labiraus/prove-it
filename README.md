# prove-it
Benchmarking Utilities

## DevContainers

This project uses [DevContainers](https://code.visualstudio.com/docs/devcontainers/containers) to provide a consistent development environment. To use the DevContainer, you need to have the following installed:
- Docker or a compatible container runtime:
    - [Docker Desktop](https://www.docker.com/)
    - [Podman](https://podman.io/)
    - [Rancher](https://rancher.com/)
- [Visual Studio Code](https://code.visualstudio.com/) with the [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension

This will provide you with the following features:
- Golang 1.24.2 (latest at the time of writing)
- [make](https://www.gnu.org/software/make/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
- [Skaffold](https://skaffold.dev/)
- [Helm](https://helm.sh/)
- [FluxCD](https://fluxcd.io/)
- [k9s](https://k9scli.io/)

It also provides the following services:
- [PostgreSQL](https://www.postgresql.org/)
- [Redis](https://redis.io/)
- [MongoDB](https://www.mongodb.com/)
- [RabbitMQ](https://www.rabbitmq.com/)
