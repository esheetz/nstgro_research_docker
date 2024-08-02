#!/bin/bash

# docker user variables
docker_folder="punkrobot"

# workspace names
color_blob_workspace_name="color_blob_ws"

# source ROS workspace
source /opt/ros/$ROS_DISTRO/setup.bash

# set up color blob workspace
cd /${docker_folder}/${color_blob_workspace_name}/
colcon clean workspace
