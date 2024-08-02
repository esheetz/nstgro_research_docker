# Locally Build NSTGRO Research Docker Images

This repo is set up so all we should have to do is pull the most recent images from the container registry and begin code development.  However, if the images need to be built or rebuilt locally, we can use the following steps from the top level directory.

1.  Set up the required workspaces:
    ```
    # ROS1 image workspaces
    ./workspaces/setup_val_workspace.sh
    ./workspaces/setup_nstgro_workspace.sh
    ./workspaces/setup_ros1_workspace.sh

    # ROS2 image workspaces
    ./workspaces/setup_color_blob_workspace.sh
    ```
    These scripts create the workspaces `val_ws`, `nstgro_ws`, generic `ros1_ws`, and `color_blob_ws` within this repo.  Note that these workspaces are in the `.gitignore` file so they will not be added to this repo.  Also note that the `val_ws` and `color_blob_ws` include minimal JSC internal dependencies, while the `nstgro_ws` includes only publicly available repos.

2.  Build the images:
    ```
    # ROS1 image
    ./.docker/build_ros1_dev_image.sh

    # ROS2 image
    ./.docker/build_ros2_dev_image.sh
    ```
    This will take a little time.  The ROS1 image includes a MoveIt installation, which will take very long. The ROS2 image should take less time.

3.  Confirm the images have been built:
    ```
    docker image ls
    ```

4.  Run docker container using the built images:
    ```
    # ROS1 container
    ./.docker/ros1_image_scripts/run.sh

    # ROS2 container
    ./.docker/ros2_image_scripts/run.sh
    ```
    This command maps the appropriate workspaces into the container, as well as several helper scripts inside directory `workspace_helper_scripts_docker`. The ROS1 container mounts `val_ws`, `nstgro_ws`, and `ros1_ws` workspaces into the container. The ROS2 container mounts `color_blob_ws` workspace into the container.

5.  While the container is running, you should see it in the list of containers:
    ```
    docker container ls -a
    ```

6.  As long as the docker is still running, enter the container using:
    ```
    # ROS1 container
    ./.docker/ros1_image_scripts/exec.sh

    # ROS2 container
    ./.docker/ros2_image_scripts/exec.sh
    ```

7.  Once inside of the container, setup the mounted workspaces:
    ```
    # ROS1 container
    source workspace_helper_scripts_docker/initialize_workspaces_ros1.sh

    # ROS2 container
    source workspace_helper_scripts_docker/initialize_workspaces_ros2.sh
    ```
    In the ROS1 container, this will source the ROS noetic workspace, build the generic `ros1_ws`, build the `val_ws`, source the `val_ws`, and initialize the `nstgro_ws`.
    In the ROS2 container, this will source the ROS2 humble workspace and initialize the `color_blob_ws`.

8.  Once inside the container, the workspaces can be built as usual (note the previous script will `cd` into the appropriate development workspace directory):
    ```
    # ROS1 container, build the nstgro_ws
    catkin build

    # ROS2 container, build the color_blob_ws
    colcon build
    ```
