FROM ros:noetic-robot

# install ros packages
RUN apt-get update && apt-get install -y \
      ros-${ROS_DISTRO}-ros-tutorials \
      ros-${ROS_DISTRO}-common-tutorials && \
    rm -rf /var/lib/apt/lists/*

# install git
RUN apt-get update && apt-get install -y \
      git

# launch ros package
CMD ["roslaunch", "roscpp_tutorials", "talker_listener.launch"]
# TODO change command to something else; this is unnecessary
