# Basic Docker Commands

## Docker Image Commands

```
# list docker images
docker image ls

# remove docker image
docker image rm <image-name>:<tag>
# image name and tag should autocomplete on tab
```



## Docker Container Commands

```
# list docker containers
docker container ls

# list all docker containers
docker container ls -a

# run docker container and automatically remove container on exit
docker run -it --rm <image-name>

# run docker container; container will be given a random name
docker run -it <image-name>

# run docker container with given name
docker run -it --rm --name <container-name> <image-name>

# enter docker container
docker exec -it <container-name> bash

# use entrypoint within container
source ros_entrypoint.sh

# remove docker container
docker container rm <container-name>
```



## Container Registry Commands

```
# login to GitHub Container Registry
export GHCR_PAT=<YOUR-TOKEN>
echo $GHCR_PAT | docker login ghcr.io -u <YOUR-USERNAME> --password-stdin

# pull image from registry
docker pull ghcr.io/<NAMESPACE>/<IMAGE-NAME>:<TAG>
# note that for images built/pushed using GitHub workflow:
#     <NAMESPACE> is also the account username
#     <IMAGE-NAME> will default to repo name
#     <TAG> will default to branch name

# pull image from registry by image tag
docker pull ghcr.io/<NAMESPACE>/<IMAGE-NAME>@<YOUR-SHA-VALUE>
# note that <YOUR-SHA-VALUE> can be found in container registry

# push image to registry
docker push ghcr.io/<NAMESPACE>/<IMAGE-NAME>:<TAG>
# note that for images built/pushed using GitHub workflow:
#     <NAMESPACE> is also the account username
#     <IMAGE-NAME> will default to repo name
#     <TAG> can be anything, usually `latest`
```