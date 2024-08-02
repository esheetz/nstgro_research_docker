#!/bin/bash

# docker user variables
docker_folder="punkrobot"

# workspace names
val_workspace_name="val_ws"
nstgro_workspace_name="nstgro_ws"
ros1_workspace_name="ros1_ws"

# source ROS workspace
source /opt/ros/$ROS_DISTRO/setup.bash

# set up ROS1 workspace
cd /${docker_folder}/${ros1_workspace_name}/
catkin clean
catkin init
catkin build

# set up val workspace
cd /${docker_folder}/${val_workspace_name}/
catkin clean
catkin init
catkin build

# source val workspace
source devel/setup.bash

# set up NSTGRO workspace
cd /${docker_folder}/${nstgro_workspace_name}/
catkin clean
catkin init
