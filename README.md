# Emscripten CI

The main purpose of this repository is hosting the [Dockerfile](./Dockerfile)
for building the Docker image used for the
[Emscripten CircleCI build](https://circleci.com/gh/emscripten-core/emscripten).

## :whale: Pre-built Docker Image
This [Dockerfile](./Dockerfile) allows to build a Docker image, with the tools
required for the Emscripten CI build. The image is hosted at
[Docker Hub](https://hub.docker.com/r/emscripten/emscripten-ci) and used
by the [CircleCI Emscripten Project](https://circleci.com/gh/emscripten-core/emscripten).

The following sections describe the important parts of the [Dockerfile](./Dockerfile).
### Base Image
The `FROM` instruction sets the base image for the final Docker image. Also, all subsequent instructions are executed using this base image.

See [FROM](https://docs.docker.com/engine/reference/builder/#from) (Docker Reference).

### Package Installation (apt-get)
Additional packages/tools required by the Emscripten CI build are installed via apt-get using the `RUN` instruction.

It is good practice to execute `apt-get update && apt-get install * && apt-get
clean cache` using a single `RUN` instruction, as each docker instruction is
creating a new read-only layer. Running `apt-get clean` helps keeping the
resulting image size low (which would not be the case if `apt-get install` was
executed as a separate `RUN` instruction).

It's recommended to sort the package names alphabetically. For better
traceability we created separate package sections for build, docs and test
packages.

See [best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/).

Use the following commands for updating the `emscripten-ci` pre-built Docker image:

:warning: Write access to the [Docker Hub repository](https://hub.docker.com/r/emscripten/emscripten-ci) is required.

1. Clone/pull the latest version of this repository

2. Pick a name for the new release.  e.g. NAME=jammy.v2

3. Build docker image locally from the repository root (location of [Dockerfile](/Dockerfile)):

    `docker build . --tag emscripten/emscripten-ci:$NAME`

4. Login to your Docker Hub account (if not logged in already):

    `docker login`

5. Push docker image to Docker Hub:

    `docker push emscripten/emscripten-ci:$NAME`

6. Update the `latest` tag to point to your new image:

    `docker tag emscripten/emscripten-ci:$NAME emscripten/emscripten-ci:latest && docker push emscripten/emscripten-ci:latest`

See [Docker CLI reference](https://docs.docker.com/engine/reference/commandline/cli/) for further details.
