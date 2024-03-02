# Docker Image Integration in GitHub

Docker image integration in GitHub differs from integration in GitLab.  See [workflow syntax for GitHub actions](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions) for a general overview of creating and running workflows.

In general, workflow files must be specified in a YAML file with either `.yml` or `.yaml` extensions.  Workflow files must be stored in the `.github/workflows/` directory in the repository.

To quickly get started, the default worflow file (suggested name `.github/workflows/docker-image.yml`) suggested by GitHub for creating a workflow that builds a docker image is as follows:

```
name: Docker Image CI

on:
  push:
    branches: [ "master" ]
  pull_request:
    branches: [ "master" ]

jobs:

  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    - name: Build the Docker image
      run: docker build . --file Dockerfile --tag my-image-name:$(date +%s)

```
