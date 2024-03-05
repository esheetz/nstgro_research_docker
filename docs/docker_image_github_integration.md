# Docker Image Integration in GitHub

* [General GitHub Workflow Documentation](#general-github-workflow-documentation)
* [Quickstart with Building Docker Images in GitHub Workflow](#quickstart-with-building-docker-images-in-github-workflow)
* [Building and Publishing Docker Images to GitHub Container Registry](#building-and-publishing-docker-images-to-github-container-registry)



## General GitHub Workflow Documentation

Docker image integration in GitHub differs from integration in GitLab.  See [workflow syntax for GitHub actions](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions) for a general overview of creating and running workflows.

In general, workflow files must be specified in a YAML file with either `.yml` or `.yaml` extensions.  Workflow files must be stored in the `.github/workflows/` directory in the repository.



## Quickstart with Building Docker Images in GitHub Workflow

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



## Building and Publishing Docker Images to GitHub Container Registry

Just as in GitLab's integration for docker images, building and pushing the docker image to a registry is a two-step process.  The above example only builds a docker image, but does not put it in a registry to be accessed later.

There are several resources that demonstrate how to build/publish docker images.  This repo pushes images to the GitHub Container Registry (ghcr).  Please refer to [this documentation on working with the GitHub Container Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry).  Particularly helpful is [this example workflow for publishing images to GitHub Packages](https://docs.github.com/en/actions/publishing-packages/publishing-docker-images#publishing-images-to-github-packages).  After following these steps, the built docker image can be seen by viewing the main page of the repository and looking under the *Packages* heading on the right.
