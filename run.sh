image_name="nstgro_research"
container_name="punkrobot"

thisdir=$(dirname "$(readlink -f "$0")")
echo $thisdir

docker run -it                                          \
           -v ${thisdir}/docs/:/docs/                   \
           --name $container_name                       \
           $image_name
