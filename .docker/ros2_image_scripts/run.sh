#!/bin/bash

# This run script starts the docker container with --network=host. This allows
# ROS nodes running on the host to interact with ROS nodes running in the
# container.
# Note that running this way is not in itself sufficient -- the ROS environments
# on host and container must also be compatible. This means:
# - ROS_MASTER_URI must match
# - DDS domain IDs must match if the host is starting ROS2/IHMC nodes

# set up variables
image_name="nstgro_research_ros2"
container_name="punkrobot_ros2"
color_blob_workspace_name="color_blob_ws"
helper_scripts_dir="workspace_helper_scripts_docker"
docker_folder="punkrobot"

# get this directory
thisdir=$(dirname "$(readlink -f "$0")")

# allow container to show GUIs
xhost +si:localuser:root

docker run -it                                                                                                  \
           --rm                                                                                                 \
           --env="DISPLAY=$DISPLAY"                                                                             \
           --env="QT_X11_NO_MITSHM=1"                                                                           \
           --env="XAUTHORITY=$XAUTH"                                                                            \
           --volume="$XAUTH:$XAUTH"                                                                             \
           -e DISPLAY                                                                                           \
           -v /dev:/dev                                                                                         \
           -v /tmp/.X11-unix:/tmp/.X11-unix                                                                     \
           -v ${thisdir}/../../${color_blob_workspace_name}/:/${docker_folder}/${color_blob_workspace_name}/    \
           -v ${thisdir}/../../${helper_scripts_dir}/:/${docker_folder}/${helper_scripts_dir}/                  \
           --network=host                                                                                       \
           --privileged                                                                                         \
           --ipc=host                                                                                           \
           --pid=host                                                                                           \
           -e ROS_DOMAIN_ID=56                                                                                  \
           --entrypoint /bin/bash                                                                               \
           --name $container_name                                                                               \
           $image_name
