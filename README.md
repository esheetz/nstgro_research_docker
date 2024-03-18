# NSTGRO Research Docker

Code to learn about dockers and build a docker image for my NASA Space Technology Graduate Research Opportunity (NSTGRO) research as part of my PhD.

* [Documentation](#documentation)
* [Docker Setup](#docker-setup)
* [Development within the Docker](#development-within-the-docker)
    * [Ownership/Permission Errors on Host](#ownership/permission-errors-on-host)
    * [Checking for Changes on Host](#checking-for-changes-on-host)
    * [Checking for Changes in Docker Container](#checking-for-changes-in-docker-container)



## Documentation

Part of the purpose of this repo is to provide some general learning/reminders about docker basics.  Please refer to the following pages for more information and practice with docker:
- [Basic Docker Commands](docs/basic_docker_commands.md)
- [ROS Docker Images and ROS Noetic Tutorial Image](docs/ros_containers.md)
- [Docker Image GitHub Integration](docs/docker_image_github_integration.md)
- [Build the NSTGRO Research Docker Image](docs/build_nstgro_research_docker_image.md)



## Docker Setup

The NSTGRO Research docker image has already been built and published to the GitHub Container Registry.  For information on how to build this image locally, see [Build the NSTGRO Research Docker Image](docs/build_nstgro_research_docker_image.md).

To use the image from the GitHub Container Registry:

1.  Pull the docker image:
    ```
    docker pull ghcr.io/esheetz/nstgro_research_docker:main
    ```
    This will take a long time.

2.  This docker image expects the `nstgro_ws` and `val_ws` to exist in the top level of this repository.  If these workspace are not already set up, run the scripts:
    ```
    ./workspaces/setup_val_workspace.sh
    ./workspaces/setup_nstgro_workspace.sh
    ```

3.  Run the docker container from the pulled image:
    ```
    ./.docker/run_pulled_image.sh
    ```
    This script maps the created `val_ws` and `nstgro_ws` workspaces into the container, as well as several helper scripts inside directory `workspace_helper_scripts_docker`.

4.  As long as the docker container is still running, enter the container using:
    ```
    ./.docker/exec_pulled_image.sh
    ```

5.  Once inside of the container, verify the setup of the mounted workspaces:
    ```
    source workspace_helper_scripts_docker/initialize_workspace.sh
    ```
    This will source the ROS noetic workspace, build the `val_ws`, source the `val_ws`, and initialize the `nstgro_ws`.  Note this only needs to be done once to properly configure and overlay the workspaces.  The corresponding `build` and `devel` spaces will be stored on the host, not within the docker container.  So once the workspaces are initialized and configured to extend the appropriate workspace, this script will not be needed.

6.  Once inside of the container, the `nstgro_ws` workspace can be built as usual (note the previous script will `cd` into the appropriate workspace directory):
    ```
    catkin build
    ```

7.  The docker image `~/.bashrc` is configured to automatically source the ROS noetic workspace, so all ROS command line tools will be available upon entering the container.  The docker image `~/.bashrc` also includes the following aliases that will help source workspaces for development:
    ```
    valkyrie            # source val_ws and cd into val_ws
    nstgro              # source nstgro_ws and cd into nstgro_ws
    valkyrie_nstgro     # source val_ws and source nstgro_ws (which extends val_ws), does not cd
    ```

8.  To exit container, `Ctrl-C` out of the terminal that ran the `run` script.  The container is run so that it will be automatically removed on exit.



## Development Within the Docker

This docker image is meant to version control the ROS distribution, thereby providing a stable environment for code development related to my NSTGRO research.  This is especially important as ROS noetic is no longer supported past Ubuntu 20.04 and NASA applications are migrating to ROS2.  While dockers are ideal for releasing stable versions of code, it can be tricky to conceptualize best practices while doing _code development_ inside of a docker.

This docker image is meant to support active code development in the following ways:
*  Since the source code is stored on the host machine and mapped into the docker, we do not have to worry about losing any development work.  Changes can be made to source code from within the docker container, and git push/pull operations can be performed from within the container as well.  But work is always saved on the host.
*  By providing version control on the ROS distribution, the docker image allows ROS1 code to be compiled on a ROS2 host machine.  Note that code must be built _inside the container_, but all `build` and `devel` spaces will be stored _on the host_.  This makes building and configuring workspaces straightforward, since code will not need to be recompiled every time the docker container starts.  Functionally, it will feel very similar to regular code development, since the appropriate workspaces can be sourced within the container and nodes can be launched within the container immediately.
*  Note that any changes to the workspace _do not require_ the docker image to be rebuilt.  The only time the image will need to be rebuilt is if a change to the workspace requires and _additional dependency_ that needs to be installed within the docker environment.
*  Note that since this particular docker image only uses publicly available GitHub repos, there should be no issues with pushing/pulling code securely from within the docker container.  As always, you will need access to your Personal Access Token to push.  There is no need to map keys/tokens into the docker.
*  Note that any modified code is _not stored as part of the docker_.  This is meant to make development simpler, as the docker image itself does not need to be updated every time code changes.
*  Note that depending on how user is set on host and in the docker, there may be issues with file permissions.

Since code can be pushed from both the host and the docker container, this repo includes a few scripts to help quickly check if there are changes made to any of the active development repositories in the `nstgro_ws` workspace.  See the following sub-sections for more.



### Ownership/Permission Errors on Host

If there are issues with permissions (for example, the docker owns files and will not allow the host to edit/save files without sudo access), run the following script to transfer ownership of all source code back to the given user:
```
./workspace_helper_scripts/set_host_source_ownership.sh <USER>
```
For example, to transfer ownership from the docker to user `esheetz`, run:
```
./workspace_helper_scripts/set_host_source_ownership.sh esheetz
```



### Checking for Changes on Host

To check if there are changes to commit in any repo within the `nstgro_ws` on the host, run the following script:
```
./workspace_helper_scripts/workspace_status.sh
```



### Checking for Changes in Docker Container

To check if there are changes to commit in any repo within the `nstgro_ws` in the docker container, run the following script:
```
workspace_helper_scripts_docker/workspace_status.sh
```
Note that this script is contained in one of the volumes mapped into the docker container at runtime.
