currdir=${PWD}
echo "current directory ${PWD}"

thisdir=$(dirname "$(readlink -f "$0")")
nstgro_workspace_name="nstgro_ws"
workspace_src_dir="${thisdir}/../${nstgro_workspace_name}/src/"
echo "checking status of repos in ${workspace_src_dir}"
echo ""

# navigate to source directory
cd ${workspace_src_dir}

# git status on all
for DIR in *; do echo $DIR; cd $DIR; git status; cd ..; done

# go back to current
cd ${currdir}
