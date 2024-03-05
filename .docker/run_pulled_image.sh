#!/bin/bash

pulled_image_name="ghcr.io/esheetz/nstgro_research_docker"
pulled_image_tag="feature-create-docker-image"
container_name="punkrobot_nstgro"
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
           $pulled_image_name:$pulled_image_tag
