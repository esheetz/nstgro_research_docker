# check for positional arguments
if [[ $# -eq 0 ]]; then
    echo "ERROR: no positional arguments given"
    echo "please provide a single user to transfer ownership to"
    exit 1 # terminate and indicate error
elif [[ $# -eq 1 ]]; then
    echo "received user: $1"
else
    echo "ERROR: too many positional arguments given (received $#, but expected 1)"
    echo "please provide a single user to transfer ownership to"
    exit 1 # terminate and indicate error
fi

# get directory of this file
thisdir=$(dirname "$(readlink -f "$0")")
nstgro_workspace_name="nstgro_ws"
val_workspace_name="val_ws"
nstgro_ws_src_dir="${thisdir}/../${nstgro_workspace_name}/src/"
val_ws_src_dir="${thisdir}/../${val_workspace_name}/src/"

# transfer ownership to given user
echo "transfering ownership of source directories 'nstgro_ws/src/' and 'val_ws/src/' to user $1"
echo ""
sudo chown $1:$1 -R $nstgro_ws_src_dir $val_ws_src_dir

echo "verify ownership of $nstgro_ws_src_dir:"
echo ""
ls -ll $nstgro_ws_src_dir
echo ""

echo "verify ownership of $val_ws_src_dir:"
echo ""
ls -ll $val_ws_src_dir
echo ""

echo "completed transfer of ownership from docker to host"
exit 0
