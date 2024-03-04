#!/bin/bash

val_workspace_name="val_ws"
nstgro_workspace_name="nstgro_ws"

# source ROS workspace
source /opt/ros/$ROS_DISTRO/setup.bash

# set up val workspace
cd /${val_workspace_name}/
catkin init
catkin build

# source val workspace
source devel/setup.bash

# set up NSTGRO workspace
cd /${nstgro_workspace_name}/
catkin clean
catkin init
