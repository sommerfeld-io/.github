# Dev Container

This dev container is based on the `sommerfeldio/devcontainer` image and includes the Docker-in-Docker feature for running Docker commands inside the container.

The `docker-in-docker` feature is configured with `"moby": false` because the base image uses a Linux distribution called 'resolute', which is not supported by the default Moby installation path. Setting this option makes the feature install Docker CE instead, which works on non-standard distributions. Without this flag, the container build fails with `Unsupported distribution version 'resolute'`.
