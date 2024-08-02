###############################
### ROS1 IMAGE INSTRUCTIONS ###
###############################

# use ROS noetic as ros1-base image
FROM ros:noetic-robot AS ros1-base
# at this point ROS_DISTRO=noetic

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

# install vcstool and pip
RUN apt-get install -y \
      python3-vcstool \
      python3-pip

# install terminator
RUN apt-get update && apt-get install --no-install-recommends -y \
      terminator

# update and upgrade required before installing next steps
RUN apt-get -y update --fix-missing && \
    apt-get -y upgrade

# base image for MoveIt functionality
FROM ros1-base AS ros1-moveit-base

# install MoveIt
RUN apt install --no-install-recommends -y \
      ros-noetic-moveit && \
    rm -rf /var/lib/apt/lists/*
# TODO more minimal MoveIt install? because this is massive and takes forever to build image

# base image for statistics/data analysis
FROM ros1-moveit-base AS ros1-stats-base

# install python modules
RUN pip install -U \
      pandas \
      scikit-learn \
      statsmodels

# update and upgrade required before installing next steps
RUN apt-get -y update --fix-missing && \
    apt-get -y upgrade

# base image for Valkyrie
FROM ros1-stats-base AS ros1-val-base

# install val_vr_ros dependencies
RUN DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends -y \
      ros-noetic-pcl-ros

# development image for Valkyrie
FROM ros1-val-base AS ros1-val-dev

# set git permissions
RUN git config --global --add safe.directory "*"

# set up git-aware-prompt
RUN mkdir /.bash && cd /.bash && git clone https://github.com/jimeh/git-aware-prompt.git

# add git-aware-prompt commands to ~/.bashrc
RUN echo "export GITAWAREPROMPT='/.bash/git-aware-prompt'" >> ~/.bashrc
RUN echo "source /.bash/git-aware-prompt/main.sh" >> ~/.bashrc
RUN echo "export PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ '" >> ~/.bashrc

### HELPFUL ~/.bashrc COMMANDS ###
# source ROS workspace
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
# source val_ws
RUN echo "alias valkyrie='echo "Sourcing Valkyrie workspace!"; source /punkrobot/val_ws/devel/setup.bash; cd /punkrobot/val_ws'" >> ~/.bashrc
# source nstgro_ws
RUN echo "alias nstgro='echo "Sourcing NSTGRO workspace!"; source /punkrobot/nstgro_ws/devel/setup.bash; cd /punkrobot/nstgro_ws'" >> ~/.bashrc
# source both val_ws and nstgro_ws
RUN echo "alias valkyrie_nstgro='echo "Sourcing additional workspaces!"; source /punkrobot/val_ws/devel/setup.bash; echo "Workspace: /punkrobot/val_ws/devel/setup.bash"; source /punkrobot/nstgro_ws/devel/setup.bash; echo "Workspace: /punkrobot/nstgro_ws/devel/setup.bash"'" >> ~/.bashrc
RUN echo "cd /punkrobot/" >> ~/.bashrc

# set default shell to bash
SHELL ["/bin/bash", "-c"]
# set entrypoint
ENTRYPOINT bash

# either entrypoint or run scripts
# run stuff on entry by adding it to ~/.bashrc
# CMD works on its own, but then does not support an entrypoint into the container
#CMD /bin/bash -c "source /root/.bashrc && source /workspace_helper_scripts_docker/initialize_workspace.sh"
# RUN is borrowed from at_lite docker (branch humble-devel), but does not seem to have effect
#RUN . /workspace_helper_scripts_docker/initialize_workspace.sh



###############################
### ROS2 IMAGE INSTRUCTIONS ###
###############################

# use ROS humble as ros2-base image
FROM ros:humble AS ros2-base
# at this point ROS_DISTRO=humble

# install vcstool and pip
RUN apt-get update && apt-get install -y \
      python3-vcstool \
      python3-pip

# install terminator
RUN apt-get update && apt-get install --no-install-recommends -y \
      terminator

# update and upgrade required before installing next steps
RUN apt-get -y update --fix-missing && \
    apt-get -y upgrade

# base image for color blob dependencies
FROM ros2-base AS ros2-color-blob-base
# TODO

# base image for developing with color blob dependencies
FROM ros2-color-blob-base AS ros2-color-blob-dev

# set up git-aware-prompt
RUN mkdir /.bash && cd /.bash && git clone https://github.com/jimeh/git-aware-prompt.git

# add git-aware-prompt commands to ~/.bashrc
RUN echo "export GITAWAREPROMPT='/.bash/git-aware-prompt'" >> ~/.bashrc
RUN echo "source /.bash/git-aware-prompt/main.sh" >> ~/.bashrc
RUN echo "export PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ '" >> ~/.bashrc

### HELPFUL ~/.bashrc COMMANDS ###
# source ROS workspace
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
# source color_blob_ws
RUN echo "alias color_blob='echo "Sourcing Color Blob workspace!"; source /punkrobot/color_blob_ws/install/setup.bash; cd /punkrobot/color_blob_ws'" >> ~/.bashrc
# source both val_ws and nstgro_ws
#RUN echo "alias valkyrie_nstgro='echo "Sourcing additional workspaces!"; source /punkrobot/val_ws/devel/setup.bash; echo "Workspace: /punkrobot/val_ws/devel/setup.bash"; source /punkrobot/nstgro_ws/devel/setup.bash; echo "Workspace: /punkrobot/nstgro_ws/devel/setup.bash"'" >> ~/.bashrc
RUN echo "cd /punkrobot/" >> ~/.bashrc

# set default shell to bash
SHELL ["/bin/bash", "-c"]
# set entrypoint
ENTRYPOINT bash
