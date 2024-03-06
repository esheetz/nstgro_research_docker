currdir=${PWD}
echo "current directory ${PWD}"

# docker user variables
docker_folder="punkrobot"

# absolute path within docker
nstgro_workspace_name="nstgro_ws"
workspace_src_dir="/${docker_folder}/${nstgro_workspace_name}/src/"
echo "checking status of repos in ${workspace_src_dir}"
echo ""

# navigate to source directory
cd ${workspace_src_dir}

# git status on all
for DIR in *; do echo $DIR; cd $DIR; git status; cd ..; done

# go back to current
cd ${currdir}
