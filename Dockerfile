FROM ros:noetic-robot

# install ros packages
RUN apt-get update && apt-get install -y \
      ros-${ROS_DISTRO}-ros-tutorials \
      ros-${ROS_DISTRO}-common-tutorials && \
    rm -rf /var/lib/apt/lists/*

# install catkin
RUN apt-get update && apt-get install -y \
      ros-${ROS_DISTRO}-catkin \
      python3-catkin-tools \
      python3-osrf-pycommon

# install git
RUN apt-get update && apt-get install -y \
      git

# install vcstool
RUN apt-get install -y \
      python3-vcstool

# update and upgrade required before installing next steps
RUN apt-get -y update --fix-missing && \
    apt-get -y upgrade

# install MoveIt
RUN apt install --no-install-recommends -y \
      ros-noetic-moveit && \
    rm -rf /var/lib/apt/lists/*
# TODO more minimal MoveIt install? because this is massive and takes forever to build image

# update and upgrade required before installing next steps
RUN apt-get -y update --fix-missing && \
    apt-get -y upgrade

# install val_vr_ros dependencies
RUN DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends -y \
      ros-noetic-pcl-ros

# set git permissions
RUN git config --global --add safe.directory "*"
# TODO ask Emma about why this is ok

# launch ros package
# ENTRYPOINT ["/bin/bash", "source /workspace_helper_scripts_docker/initialize_workspace.sh"]
CMD ["roslaunch", "roscpp_tutorials", "talker_listener.launch"]
# TODO change command to something else; this is unnecessary
# ideally change to 'source initialize_workspace.sh'
