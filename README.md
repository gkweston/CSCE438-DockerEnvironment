# CSCE438 Docker Environment
An AmazonLinux Docker image with all dependancies up to MP2/MP3, configurable with VSCode, with resource allocation through Docker. Portable for MacOS/Linux/Windows/WSL2.

Install Docker and clone this git repo before following the steps below.

## Pulling from Docker Hub (much faster!)
Skip straight to the fun by running:

    sh docker_pull.sh


## Building the base image locally
If you don't want to pull the image from Docker Hub, use the following steps to build it locally. Feel free to add your own dependancies to the build chain in `/base/Dockerfile`.

Make sure Docker is running, then from this directory run:

    docker build -t csce438:base ./base

This will provision the amazonlinux image with project dependancies (CMake, gRPC, etc.). Keep this image on hand for the next step.

## Using a dev container
You only need to build or pull from Docker Hub once, as long as you don't delete the image (tagged cscee438:base).

### Starting the dev container
Next run:

    sh start_dev_env.sh </absolute/path/to/your/workspace>

You can type in the absolute path to your project folder, or use something like:

    sh start_dev_env.sh $(pwd)/MP_3

Where you call this from your git repo directory, and `MP_3` contains all your project files, build files, and other stuff.

NOTE: I like to keep my dev files in something like `<path/to/git/repo>/MP_3/src`. Then just `cd src` after remoting into the container. This keeps your dev directory (`src`) clean from any system config files (which are different on different OS's and generally are formatted as: `.system_file_name`.

## Using VSCode in the dev container
You can simply open an IDE in your project workspace folder, but if you use common extensions (like a linter), they will not recognize any dependancies on the dev container. These include gRPC headers if you don't have them installed on the host.

But getting around this is relatively easy.

### Attaching VSCode to remote
Install VSCode's Docker extension(s), if you're not prompted to already.

MacOS
    
    Open VSCode > "Remote Explorer (left side bar) > Click the 'add window' button on "/systemzRfun csce438:base"

Windows/WSL2
    
    Open VSCode > "WSL: Ubuntu" (green button, bottom left) > "Attach to Running Container" > Select "/systemzRfun csce438:base"
    OR
    Open VSCode > "Docker" (left side bar, it's the whale!) > right click "csce438:base" > "Attach Visual Studio Code"

You should now be running a new VSCode window in the dev container, with all your project files.

When you install extensions in the "Extensions" tab on the left side, make sure you select to install them in your container.

For anybody who might have difficulty getting extensions to work/persist on the container, please reach out and I'm happy to provide support: gkweston@tamu.edu. Extensions can be a little tricky on MacOS for a few reasons...

### Updating includes
Finally, install the Microsoft C/C++ Extension on the dev container.

In the container, go to `/root/.vscode`, you will find the file `c_cpp_properties.json`. Open this in `[VSCode|Emacs|Nano|Vim?]` and in the `configurations["includePath]` entry add `"/grpc/**"`, so it might look something like:

    {
        "configurations": [
            {
                "name": "Linux",
                "includePath": [
                    "${workspaceFolder}/**",
                    "/grpc/**"
                ],
                "defines": [],
                "compilerPath": "/usr/bin/gcc",
                "cStandard": "gnu11",
                "cppStandard": "gnu++14",
                "intelliSenseMode": "linux-gcc-x64"
            }
        ],
        "version": 4
    }

You only need to do setup steps once, then in the future simply run the start script with the path to your workspace.

You are now the proud owner of a dedicated CSCE438 docker container, yay! 🙂

### Opening a new shell in the same container
Start a new shell in the container by running:

    ./new_shell.sh

Or
  
    docker exec -it <cont_name> /bin/bash

Where the default name is `systemzRfun`.

### Some notes
* Be careful!! Any saved changes will be reflected on the host machine.
 
* You can run `start_dev_env.sh` from anywhere on the host, so it may be useful to set an alias or variable. To save alias, concat this to your `~/.bashrc`

        alias <your_cmd_name>='absolute/path/to/start_dev_env.sh'

    Then, if you `source ~/.bashrc`, or restart your shell, you can start the container by calling:
    
        <your_cmd_name> absolute/path/to/mount

* You could also skip all this source'ing and stuff by calling

       docker run -w /root -itv --name <cont_name> <path/to/mount>:/root csce438:base /bin/bash

    from anywhere on the host, or setting this as an alias, but doing this won't warn you about the mount path. If you use a different `cont_name` than my default, you will have to change `new_shell.sh` or use the command with the name you passed.
