#!/bin/bash

thisdir=$(dirname "$(readlink -f "$0")")
nstgro_workspace_name="../nstgro_ws"
workspace_yaml_file="nstgro_workspace.yaml"

# make workspace directory
mkdir ${thisdir}/${nstgro_workspace_name}
mkdir ${thisdir}/${nstgro_workspace_name}/src
echo "created workspace ${thisdir}/${nstgro_workspace_name}"

# import workspace
echo "cloning workspace into ${thisdir}/${nstgro_workspace_name}/src/..."
cd ${thisdir}/${nstgro_workspace_name}/src/
vcs import < ${thisdir}/${workspace_yaml_file}
cd ${thisdir}
echo "completed!"
