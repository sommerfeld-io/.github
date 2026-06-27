# Software Tags and Versioning

Our software artifacts are distributed primarily as Docker images and follow a consistent tagging scheme. These tags also apply to other artifact formats where applicable.

- Latest but unreleased feature set `edge` (release candidate `rc` in older repos)
    - Tagged as `edge` (or `rc` in older repos) in Docker and other distribution formats.
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

## Maintenance and Updates

We maintain a single active line of development based on the `main` branch. There are no long-term support (LTS) releases, no backport branches, and no parallel maintenance of older versions.

Bug fixes and patches are always applied to the `main` bach and released as a new version on top of the current latest release - regardless of which version the bug was originally discovered in. For example, if the latest release is `0.10.0` and a bug is found that also exists in `0.5.0`, the fix will be released as `0.10.1`. A `0.5.1` will not be issued.

This means:

- To receive any bug fix, users must upgrade to the latest release.
- Older version tags remain available as immutable artifacts but are not patched or supported.
- Running a version other than the latest means running without fixes that may have been released since that version.
