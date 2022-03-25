# CSCE438 Docker Environment
An AmazonLinux Docker image with all dependancies up to MP3, configurable with VSCode, with resource allocation through Docker. Portable for MacOS/Linux/Windows/WSL2.

For all steps below, run from your prefered bash/zsh instance (including on WSL2).

## Pulling from Docker Hub
TODO

## Building the base image locally
If you don't want to pull the image from Docker Hub, use the following steps to build it locally. Feel free to add your own dependancies to the build chain in `/base/Dockerfile`, or create your own Dockerfile to inherit this image and add more tools to it.

Make sure Docker is running, then from this directory run:

    docker build -t csce438:base ./base

This will provision the amazonlinux image with project dependancies (CMake, gRPC, etc.). Keep this image on hand for the next step.

## Using a dev container
You only need to build/pull from Docker Hub once. Unless you delete the container, from then on use the following steps to run it:

### Starting the dev container
Next run:

    sh start_dev_env.sh <project/path/to/mount>

TODO-> output to .dev_container so we can docker exec (!)

### Using VSCode in the dev container

TODO-> Get persistant VSCode extensions
TODO-> Probably get a vanilla container and set up VSCode extensions

You can simply open a VSCode instance in your `project/path/to/mount` folder, but if you use common extensions (like a linter), they will not recognize any dependancies on the dev container (but rather the host).

Getting around this is relatively easy:

    Open VSCode > Click "Remote Explorer (left side bar) > Select your container

As long as you have the Docker extension(s) (which it should prompt you for) installed, you will now be running VSCode out of the remote. This means you can install/uninstall extensions and as long the `.vscode-server` dir is saved in your mounted file, you shouldn't have to do this every time.

When you install extensions in the "Extensions" tab on the left side, make sure you select your container.

### Opening a new shell in the same container
TODO
If you need another shell (for testing client/host), run:
    
    docker exec -it $(cat .dev_container) /bin/bash



### Some notes

A) Be careful!!!! Any saved changes will be reflected on the host machine for your mounted directory. This can also include any VSCode extensions you want to keep persistant on the dev environment.
 
B) You can run this script from anywhere on your host, so it may be useful to set an alias or variable. To save alias, concat this to your `~/.bashrc`

    `alias <your_cmd_name>='/path/to/start_dev_env.sh`

Then, if you `source ~/.bashrc`, or restart your shell, calling:
    
    <your_cmd_name> /path/to/mount

will start the container.
 
(C) You can skip all the source'ing and stuff by calling

    docker run -w /root -itv <path/to/mount>:/root csce438:base /bin/bash

from anywhere on the host, or setting this as an alias, but doing this won't warn you about the mount path.

You may have to give executable permissions to this file to run
