# Software Tags and Versioning

Our software artifacts are distributed primarily as Docker images and follow a consistent tagging scheme. These tags also apply to other artifact formats where applicable.

- Release Candidate `rc`
    - Tagged as `rc` in Docker and other distribution formats.
    - Always built from the `main` branch.
    - Represents a releasable state of the software.
    - Not considered an official release, but may be used for staging or acceptance environments.
- Version Tags
    - Tagged with a [Semantic Versioning](https://semver.org) format such as `0.12.4`.
    - Represents an official release of the software.
    - Each version tag corresponds directly to a Git tag in the source repository.
    - These tags are immutable and indicate stable, production-ready artifacts.
- `latest`
    - Always points to the most recent official release (i.e. the latest version tag).
    - Identical to the Docker image and other artifacts tagged with the corresponding version.
    - Provided for convenience, particularly in development and quick-start scenarios.
