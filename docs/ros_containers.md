# ROS Containers

## Using Official ROS Dockers

To use official ROS docker images when creating your own custom ROS images, refer to:
- [ROS docker tutorials](https://wiki.ros.org/docker/Tutorials/Docker)
- [ROS docker image registry](https://registry.hub.docker.com/_/ros/)
- [Docker's ROS image documentation](https://hub.docker.com/_/ros/)

In particular, [docker's ROS image documentation](https://hub.docker.com/_/ros/) includes several helpful examples of Dockerfiles, including:
- Creating a Dockerfile to run simple ROS2 demos
- Creating a Dockerfile for custom ROS package development, which overlays a workspace of source code into the image and allows the code to be built within the docker
- Creating a Dockerfile to run simple ROS1 demos (which inspired the _ROS noetic tutorial image_ described below)



## Tutorial ROS Noetic Image

This repo contains a simple ROS noetic image within the directory `ros_noetic_tutorial_image/`.  This is meant to be a basic example of how to start from the ROS noetic docker image, customize the image, and run some code.

Get to the `ros_noetic_tutorial_image` source code from the top level repo:
```
cd ros_noetic_tutorial_image
```

Build the image:
```
./build.sh
```
This will take a little time.

Confirm the image has been built:
```
docker image ls
```

Run docker container using the built image:
```
./run.sh
```
When the container starts, the ROS1 talker/listener tutorial will be launched.  You should see output from both the talker and listener nodes.

While the container is running, you should see it in the list of containers:
```
docker container ls -a
```

As long as the docker is still running, enter the container using:
```
./exec.sh
```

Once inside of the container, source the ROS noetic workspace by running:
```
source ros_entrypoint.sh
```

When the container is closed, it will automatically be removed from the list of containers.
