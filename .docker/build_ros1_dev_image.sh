#!/bin/bash

thisdir=$(dirname "$(readlink -f "$0")")
tag_name="nstgro_research_ros1"

DOCKER_BUILDKIT=1 docker build --pull                                       \
                               --no-cache                                   \
                               --network host                               \
                               --file ${thisdir}/Dockerfile                 \
                               --progress=plain                             \
                               --tag $tag_name                              \
                               --target ros1-val-dev                        \
                               ${thisdir}                                   # specifies what directory all of the docker stuff is in

docker image prune --filter label=stage=builder
