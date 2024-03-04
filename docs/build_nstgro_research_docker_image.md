# Locally Build NSTGRO Research Docker Image

This repo is set up so all we should have to do is pull the most recent image from the image registry and begin code development.  However, if the image needs to be built or rebuilt locally, we can use the following steps from the top level directory.

Set up the required workspaces:
```
./setup_val_workspace.sh
./setup_nstgro_workspace.sh
```
These scripts create the workspaces `val_ws` and `nstgro_ws` within this repo.  Note that these workspaces are in the `.gitignore` file so they will not be added to this repo.  Also note that the `val_ws` includes minimal JSC internal dependencies, while the `nstgro_ws` includes only publicly available repos.

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
This command maps the created `val_ws` and `nstgro_ws` workspaces into the container, as well as several helper scripts inside directory `workspace_helper_scripts_docker`.

While the container is running, you should see it in the list of containers:
```
docker container ls -a
```

As long as the docker is still running, enter the container using:
```
./exec.sh
```

Once inside of the container, setup the mounted workspaces:
```
source /workspace_helper_scripts_docker/initialize_workspace.sh
```
This will source the ROS noetic workspace, build the `val_ws`, source the `val_ws`, and initialize the `nstgro_ws`.

Once inside the container, the `nstgro_ws` can be built as usual (note the previous script will `cd` into the appropriate workspace directory):
```
catkin build
```
