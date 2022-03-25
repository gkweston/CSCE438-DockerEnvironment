# csce438:dev
# --------------------------- NOTES --------------------------------
# First build the base image by running:
#           
#           `docker build -t csce438:base /base`
# 
# To start:
#   1. Run
#          `sh ./start_dev_env.sh`
#   2. Go to "Remote Explorer" tab in VSCode and remote into csce438/mp2:dev
# 
# To open a new shell:
#   1. Open a new instance of bash
#   2. Navigate to this directory
#   3. Run
#           `docker exec -it $(cat .dev_container) /bin/bash`
# 
# To stop:
#   1. Set default path in stop script and run
#           `sh ./stop_dev_env.sh`
#   (OR) Run
#           `sh ./stop_dev_env.sh <path_to_save>`
#
# ------------------------------------------------------------------
FROM csce438:base
RUN mkdir -p /root/.vscode-server
COPY ./.vscode-server /root/.vscode-server

RUN mkdir /root/src
COPY ./src /root/src/
