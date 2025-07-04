# Development Guide

This section outlines the way we develop this project, focusing on development, tooling, deployment, and support considerations. It outlines the practices and principles we value.

## Development Principles

We follow a set of development principles that guide our work on this project. These principles are designed to ensure that our development process is efficient, effective, and aligned with best practices.

### Everything as Code

We embrace treating as much as possible as code, incorporating best practices from software development in every aspect of our work. We prioritize utilizing technologies and tools that allow us to leverage version control and adhere to established development practices like branching and code reviews. This applies to source code, infrastructure code, utility scripts, and basically everything that can be depicted as some sort of code.

When it comes to configuration management, we opt for approaches that align with software development principles. If there are multiple ways to apply a configuration, such as through a web UI or an API, we prioritize the API method. This preference is due to its reproducibility, (hopefully) idempotence, and potential for automation, ensuring consistency and facilitating efficient management of configurations.

By treating various aspects of our work as code, we can leverage the benefits of version control, automation, and reproducibility.

### Test Driven Development

We follow Test-Driven Development (TDD) principles, using TDD to design our systems.

### Version Control

We make all changes to code, test, infrastructure, configuration, and ultimately production via version control.

Version control extends beyond just managing code repositories like Git. It encompasses a broader scope that includes controlling the versions of tools and third-party software utilized within our environments. By actively managing these dependencies, we ensure that our software remains stable, consistent, and immune to uncontrolled changes originating from external sources.

We employ version control to manage and track changes made to our production systems, ensuring that modifications are controlled, traceable, and reversible.

By extending version control to encompass the management of tools, third-party software, and production environments, we maintain a firm grip on the external factors that can impact our software development and runtime environments. This approach allows us to minimize the risk of uncontrolled changes.

### Trunk-Based Development

We follow a trunk-based development approach, which means that we primarily focus our development efforts on the `main` branch of our repository. This approach encourages frequent and continuous integration of code changes into the `main` branch, allowing us to avoid long-lived feature branches and promote a fast-paced development cycle. We still rely on branching and Pull Requests, but our branches do not live for longer than one day (more on that in the coming sections).

The `main` branch represents the releasable state of the software. It serves as the mainline branch from which stable releases are made.

Any branch other than `main` is considered a short-lived branch. These branches are used for feature development, bug fixing, and any other updates. There are no specific naming conventions for these branches. These branches do not live for longer than one day.

Git tags are always created from the `main` branch, ensuring that they represent stable and release-worthy versions of the software. The creation of tags is done exclusively through our deployment pipeline without manual interaction, ensuring consistent and reproducible release processes.

Each developer is streaming small commits either into a short-lived branch with a pre-integration step of running the build first (which must pass) and integrates into the `main` branch through a Pull-Request.

Basically we follow most recommendations from [trunkbaseddevelopment.com](https://trunkbaseddevelopment.com).

### Continuous Integration

We integrate code changes from all developers at least once per day. This frequent integration ensures that our software is thoroughly tested and checked with everyone's changes on a daily basis.

We work with short lived (feature) branches (if needed). But we won't hide work on separate branches for longer than a working day before integrating them together.

We don't merge the `main` branch into our feature branches to make them live longer! This is not a way to integrate everyone's changes into a single source of truth and prevents us from determining the releasability of our software.

We grow our code incrementally, making frequent small changes to our code - leaving our code in a working state after each small change.

We get feedback on the quality of our work after every small change through the use of automated tests in pipelines.

### Automated tests determine the releasability

We automate almost everything in our pipeline, and have enough automated testing to in place to validate and release our changes without dependence on manual regression testing, or approval QA and approval processes.

Manual tests are not forbidden. But since they only make us feel better and more save instead of providing a real judgement on the releasability of our software, the make-it-or-break-it decision always comes from our pipeline.

When we identify manual tests that are performed repeatedly, we actively work on transforming them into automated tests and integrate them into our pipelines.

### Keep the software always in a releasable state

While we may not release our software daily, our goal is to have the capability to release changes every day if required. That means we aim to ship a release-candidate at least once per day. To achieve this goal we have to keep our software in a releasable state all the time!

### Commit Messages

We use [semantic-release](https://github.com/semantic-release/semantic-release) to create Git tags and GitHub releases.It uses the latest Git tag to determine the current version of your project. When you run semantic-release, it analyzes your commit messages since the last release to determine the next version number.

Each commit message consists of a header, a body, and a footer (each separated by a blank line). This specification is inspired by the AngularJS commit message format. The `header` is mandatory. The `body` and `footer` are optional.

```plaintext
<type>: <short summary>
  │       │
  │       +-> Summary in present tense. Not capitalized. No period at the end.
  │
  +-> Commit Type: build|ci|docs|feat|fix|perf|refactor|test
```

The `<type>` and `<summary>` fields are mandatory. The `type` must be one of the following:

- *build*: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- *ci*: Changes to our CI configuration files and scripts (examples: CircleCi, SauceLabs)
- *chore*: Changes that don't modify src or test files (example: updating tasks, linting, etc.)
- *docs*: Documentation only changes
- *feat*: A new feature
- *fix*: A bug fix
- *perf*: A code change that improves performance
- *refactor*: A code change that neither fixes a bug nor adds a feature
- *revert*: Reverts a previous commit
- *style*: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- *test*: Adding missing tests or correcting existing tests

Use the summary field to provide a succinct description of the change:

- use the imperative, present tense: "change" not "changed" nor "changes"
- don't capitalize the first letter
- no dot (.) at the end

Just as in the summary, use the imperative, present tense: "fix" not "fixed" nor "fixes". Explain the motivation for the change in the commit message body. This commit message should explain *why* you are making the change. You can include a comparison of the previous behavior with the new behavior in order to illustrate the impact of the change.

The footer can contain information about breaking changes and deprecations and is also the place to reference GitHub issues and PRs that this commit closes or is related to.

```plaintext
BREAKING CHANGE: <breaking change summary>
<BLANK LINE>
<breaking change description + migration instructions>
<BLANK LINE>
Fixes #<issue number>
```

Breaking Change section should start with the phrase "BREAKING CHANGE: " followed by a summary of the breaking change, a blank line, and a detailed description of the breaking change that also includes migration instructions.

```plaintext
DEPRECATED: <what is deprecated>
<BLANK LINE>
<deprecation description + recommended update path>
<BLANK LINE>
Closes #<pr number>
```

Similarly, a Deprecation section should start with "DEPRECATED: " followed by a short description of what is deprecated, a blank line, and a detailed description of the deprecation that also mentions the recommended update path.

### Semantic Versioning for our Releases

At our organization, we adhere to [Semantic Versioning (SemVer)](https://semver.org) principles when releasing artifacts. This means that we follow a structured versioning format, consisting of major, minor, and patch numbers, to indicate changes and updates in our software. Unstable versions are marked as Alpha or Beta version.

Key definitions of Semantic Versioning:

- A normal version number must take the form `major.minor.bugfix` in non-negative integers, and must not contain leading zeroes. Each element must increase numerically. For instance: `1.9.0` -> `1.10.0` -> `1.11.0`.
- Once a versioned package has been released, the contents of that version must not be modified. Any modifications must be released as a new version.
- Major version zero (`0.x.x`)` is for initial development. Anything MAYmay change at any time. The public API should not be considered stable.
- Version `1.0.0` defines the initial public API.
- Patch version (`x.x.patch`) must be incremented if only backward compatible bug fixes are introduced. A bug fix is defined as an internal change that fixes incorrect behavior.
- Minor version (`x.minor.x`) must be incremented if new, backward compatible functionality is introduced to the public API. It must be incremented if any public API functionality is marked as deprecated. It may be incremented if substantial new functionality or improvements are introduced within the private code. It may include patch level changes. Patch version must be reset to 0 when minor version is incremented.
- Major version (`major.x.x`) must be incremented if any backward incompatible changes are introduced to the public API. It may also include minor and patch level changes. Patch and minor versions must be reset to 0 when major version is incremented.

Our Git tags always include a leading "v" before the version number.

### Releases and Deployments always are done through a pipeline

This means that all deployments to any test or production environment, whether it's a software version to some test environment or to production or a Docker image to DockerHub or any other kind of deployment, are carried out automatically via our deployment pipeline.

We deploy our changes into production based on the commit messages. We automate the deployment process as much as possible, so (according to the commit message) we create tags based on the commit message and trigger the deployment pipeline. Commit messages with the type `fix` or `feat` will trigger a new bugfix or minor release, respectively. A commit message with the type `BREAKING CHANGE` will trigger a major release. Releases are always based on the `main` branch.

### Artifacts are immutable

We are validating the delivered artifact with the pipeline. It is built once and deployed to all environments. A common anti-pattern is building an artifact for each environment. Each build is a possibility to introduce unintended changes. By promoting a single artifact through the stages we ensure that the deployed artifact is exactly the one that was tested.

## Ecosystem

Our development ecosystem consists of a set of tools, technologies, and practices that support our development process. This ecosystem is designed to provide a consistent, efficient, and effective environment for developing, testing, and deploying our software.

### Packaging and Distribution

The application will be packaged and published primarily as a Docker image, which is the default and recommended release format. While Docker images are the standard, alternative formats such as standalone binaries (e.g., for Go applications) may be provided if needed.

### Development Environment

Development primarily occurs on Ubuntu workstations. The IDE of choice for development is Visual Studio Code (VSCode). VSCode is preferred due to its support for DevContainers (an essential requirement) and GitHub Copilot.

### AI Support

Development efforts are supported by GitHub Copilot, with the potential for heavy reliance on this AI-assistant as its usefulness is validated over time.

### Source Code Hosting

All projects are hosted on GitHub.

### Pipelines and Workflows

The pipeline and workflow engine of choice is GitHub Actions.

### Application Language and Build Tool

Setup for all workstations and RasPi nodes is done using Ansible. All workstations are running Ubuntu.

## Task Management

To ensure that our development process is organized and efficient, we use a task management system to track and manage our work. This system helps us prioritize tasks, assign work, and track progress throughout the development lifecycle.

### Task and Todo Tracking

All task and todo tracking will be done through [a GitHub project](https://github.com/orgs/sommerfeld-io/projects/1/).

### User Stories and Job Stories

We want requirements to define small, focused needs rather than vast, vague projects. Depending on the nature of the task, we use user stories or job stories to describe our requirements. We aim to complete each story within a couple of days at most, keeping in mind that we integrate changes daily. So our stories must be designed accordingly.

If we can't express the need in terms of a story, we likely don't yet understand what our software is meant to achieve. If we can't think of an example that would demonstrate the need is fulfilled, we probably don't really understand the problem (domain) yet.

### Architecture Decisions

We use architecture decision records (ADRs) to document the key decisions made during the development of the CLI documentation tool. ADRs help us track the context, considerations, and outcomes of each decision, providing a clear rationale for future reference.

We treat ADRs as working items, updating them as necessary to reflect the current state of the issue. Thats why we manage and track ADRs as GitHub issues. This approach allows us to easily reference and link to ADRs from other parts of the documentation and use the GitHub issue for collaboration and discussion.

Architecture decisions are labeled as `ADR` and are tracked as GitHub issues. Each repository manages its own ADRs, so for a list of architecture decisions take a look into a project issues.

### Risks and Technical Debts

All issues labeled as `risk` (= some sort of risk or a technical debt) or `security` (= disclosed security issues - e.g. CVEs) [are tracked as GitHub issue](https://github.com/orgs/sommerfeld-io/projects/1/views/21) and carry the respective label. For more information on how to report a vulnerability, please refer to the [Security Policy](https://github.com/sommerfeld-io/.github/blob/main/SECURITY.md).
