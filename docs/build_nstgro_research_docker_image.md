# Locally Build NSTGRO Research Docker Image

This repo is set up so all we should have to do is pull the most recent image from the container registry and begin code development.  However, if the image needs to be built or rebuilt locally, we can use the following steps from the top level directory.

1.  Set up the required workspaces:
    ```
    ./workspaces/setup_val_workspace.sh
    ./workspaces/setup_nstgro_workspace.sh
    ```
    These scripts create the workspaces `val_ws` and `nstgro_ws` within this repo.  Note that these workspaces are in the `.gitignore` file so they will not be added to this repo.  Also note that the `val_ws` includes minimal JSC internal dependencies, while the `nstgro_ws` includes only publicly available repos.

2.  Build the image:
    ```
    ./.docker/build.sh
    ```
    This will take a little time.

3.  Confirm the image has been built:
    ```
    docker image ls
    ```

4.  Run docker container using the built image:
    ```
    ./.docker/run.sh
    ```
    This command maps the created `val_ws` and `nstgro_ws` workspaces into the container, as well as several helper scripts inside directory `workspace_helper_scripts_docker`.

5.  While the container is running, you should see it in the list of containers:
    ```
    docker container ls -a
    ```

6.  As long as the docker is still running, enter the container using:
    ```
    ./.docker/exec.sh
    ```

7.  Once inside of the container, setup the mounted workspaces:
    ```
    source /workspace_helper_scripts_docker/initialize_workspace.sh
    ```
    This will source the ROS noetic workspace, build the `val_ws`, source the `val_ws`, and initialize the `nstgro_ws`.

8.  Once inside the container, the `nstgro_ws` can be built as usual (note the previous script will `cd` into the appropriate workspace directory):
    ```
    catkin build
    ```
