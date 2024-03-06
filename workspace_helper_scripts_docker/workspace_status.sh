currdir=${PWD}
echo "current directory ${PWD}"

# docker user variables
docker_end_user="punkrobot"
docker_user_home="/home/${docker_end_user}"

# absolute path within docker
nstgro_workspace_name="nstgro_ws"
workspace_src_dir="${docker_user_home}/${nstgro_workspace_name}/src/"
echo "checking status of repos in ${workspace_src_dir}"
echo ""

# navigate to source directory
cd ${workspace_src_dir}

# git status on all
for DIR in *; do echo $DIR; cd $DIR; git status; cd ..; done

# go back to current
cd ${currdir}
