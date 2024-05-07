#!/bin/bash

thisdir=$(dirname "$(readlink -f "$0")")
ros1_workspace_name="../ros1_ws"
workspace_yaml_file="ros1_workspace.yaml"

# make workspace directory
mkdir ${thisdir}/${ros1_workspace_name}
mkdir ${thisdir}/${ros1_workspace_name}/src
echo "created workspace ${thisdir}/${ros1_workspace_name}"

# import workspace
echo "cloning workspace into ${thisdir}/${ros1_workspace_name}/src/..."
cd ${thisdir}/${ros1_workspace_name}/src/
vcs import < ${thisdir}/${workspace_yaml_file}
cd ${thisdir}
echo "completed!"
