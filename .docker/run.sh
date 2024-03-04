#!/bin/bash

image_name="nstgro_research"
container_name="punkrobot"
nstgro_workspace_name="nstgro_ws"
val_workspace_name="val_ws"
helper_scripts_dir="workspace_helper_scripts_docker"

thisdir=$(dirname "$(readlink -f "$0")")
# echo $thisdir

docker run -it                                                                              \
           --rm                                                                             \
           -v ${thisdir}/../${val_workspace_name}/:/${val_workspace_name}/                  \
           -v ${thisdir}/../${nstgro_workspace_name}/:/${nstgro_workspace_name}/            \
           -v ${thisdir}/../${helper_scripts_dir}/:/${helper_scripts_dir}/                  \
           --network=host                                                                   \
           --entrypoint /bin/bash                                                           \
           --name $container_name                                                           \
           $image_name