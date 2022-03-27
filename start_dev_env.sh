# Start the dev container mounted to the folder passed as arg 1
# 
# (A) Be careful!!!! Any saved changes will be reflected on
#     the host machine for your mounted directory. This can
#     also include any VSCode extensions you want to keep
#     persistant on the dev environment.
# 
# (B) You can run this script from anywhere on your host,
#     so it may be useful to set an alias or variable.
# 
#     To save alias, concat this to your ~/.bashrc
# 
#           `alias <your_cmd_name>='/path/to/start_dev_env.sh`
# 
#     Then, if you `source ~/.bashrc`, or restart your shell,
#     calling `<your_cmd_name> /path/to/mount` will start
#     the container.
# 
#  (C) You can skip all the source'ing and stuff by calling
# 
#                 `docker run -w /root -itv <path/to/mount>:/root csce438:base /bin/bash`
# 
#      from anywhere on the host, or setting this as an alias,
#      but doing this won't warn you about the mount path.

PROJ_PATH=$1
NAME="systemzRfun"

if [ ${#PROJ_PATH} -eq 0 ];
then
        echo "Pass the absolute path of the dir you would like to mount as argument to this script.";
        echo "";
        echo "Example:";
        echo "./start_dev_env.sh \$(pwd)";
        echo "OR";
        echo "./start_dev_env.sh /my/drive/or/folder/to/mount/";
else
	docker container prune -f;
        echo "Starting dev container: ${NAME}";
	echo "Mounted to: ${PROJ_PATH}";
        docker run -w /root --name ${NAME} -itv ${PROJ_PATH}:/root csce438:base /bin/bash;
fi
