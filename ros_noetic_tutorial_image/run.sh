image_name="nstgro_ros_noetic"
container_name="ros_noetic_tutorial"

docker run -it       						\
		   --rm      						\
		   --name $container_name 			\
		   $image_name
