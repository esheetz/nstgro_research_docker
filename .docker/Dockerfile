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
RUN echo "alias valkyrie='echo "Sourcing Valkyrie workspace!"; source /val_ws/devel/setup.bash; cd /val_ws'" >> ~/.bashrc
RUN echo "alias nstgro='echo "Sourcing NSTGRO workspace!"; source /nstgro_ws/devel/setup.bash; cd /nstgro_ws'" >> ~/.bashrc
RUN echo "alias valkyrie_nstgro='echo "Sourcing additional workspaces!"; source /val_ws/devel/setup.bash; echo "Workspace: /val_ws/devel/setup.bash"; source /nstgro_ws/devel/setup.bash; echo "Workspace: /nstgro_ws/devel/setup.bash"'" >> ~/.bashrc

# set default shell to bash
SHELL ["/bin/bash", "-c"]
# set entrypoint
ENTRYPOINT bash

# TODO run scripts when container first starts?
# CMD works on its own, but then does not support an entrypoint into the container
#CMD /bin/bash -c "source /root/.bashrc && source /workspace_helper_scripts_docker/initialize_workspace.sh"
# RUN is borrowed from at_lite docker (branch humble-devel), but does not seem to have effect
#RUN . /workspace_helper_scripts_docker/initialize_workspace.sh
