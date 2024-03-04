#!/bin/bash

thisdir=$(dirname "$(readlink -f "$0")")
val_workspace_name="../val_ws"
workspace_yaml_file="val_workspace.yaml"

# make workspace directory
mkdir ${val_workspace_name}
mkdir ${val_workspace_name}/src
echo "created workspace ${thisdir}/${val_workspace_name}"

# import workspace
echo "cloning workspace into ${thisdir}/${val_workspace_name}/src/..."
cd ${thisdir}/${val_workspace_name}/src/
vcs import < ${thisdir}/${workspace_yaml_file}
cd ${thisdir}
echo "completed!"
