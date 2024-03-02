# Locally Build NSTGRO Research Docker Image

This repo is set up so all we should have to do is pull the most recent image from the image registry and begin code development.  However, if the image needs to be built or rebuilt locally, we can use the following steps from the top level directory.

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
