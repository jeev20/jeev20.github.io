---
layout: post
title: Essential linux commands
date: 2024-05-23 23:30 +0200
categories: ["Miscellaneous"]
tags: [ "bash script", "helper"]
mermaid: true
published: true
---

The aim with this post is to centralize all my most used linux commands and their different use case descriptions using the tldr module.  

Someday when I wonder what the syntax was for a command, I have a place to refer, hopefully! 

### `scp`
```bash
scp

  Secure copy.
  Copy files between hosts using Secure Copy Protocol over SSH.
  More information: https://man.openbsd.org/scp.

  - Copy a local file to a remote host:
    scp path/to/local_file remote_host:path/to/remote_file

  - Use a specific port when connecting to the remote host:
    scp -P port path/to/local_file remote_host:path/to/remote_file

  - Copy a file from a remote host to a local directory:
    scp remote_host:path/to/remote_file path/to/local_directory

  - Recursively copy the contents of a directory from a remote host to a local directory:
    scp -r remote_host:path/to/remote_directory path/to/local_directory

  - Copy a file between two remote hosts transferring through the local host:
    scp -3 host1:path/to/remote_file host2:path/to/remote_directory

  - Use a specific username when connecting to the remote host:
    scp path/to/local_file remote_username@remote_host:path/to/remote_directory

  - Use a specific SSH private key for authentication with the remote host:
    scp -i ~/.ssh/private_key path/to/local_file remote_host:path/to/remote_file

  - Use a specific proxy when connecting to the remote host:
    scp -J proxy_username@proxy_host path/to/local_file remote_host:path/to/remote_file

```

### where 
```bash
where

  Reports all known instances of a command.
  It could be an executable in the PATH environment variable, an alias, or a shell builtin.
  More information: https://zsh.sourceforge.io/Doc/Release/Shell-Builtin-Commands.html.

  - Find all instances of a command:
    where command

```


### make
```bash
make

  Task runner for targets described in Makefile.
  Mostly used to control the compilation of an executable from source code.
  More information: https://www.gnu.org/software/make/manual/make.html.

  - Call the first target specified in the Makefile (usually named "all"):
    make

  - Call a specific target:
    make target

  - Call a specific target, executing 4 jobs at a time in parallel:
    make -j4 target

  - Use a specific Makefile:
    make --file path/to/file

  - Execute make from another directory:
    make --directory path/to/directory

  - Force making of a target, even if source files are unchanged:
    make --always-make target

  - Override a variable defined in the Makefile:
    make target variable=new_value

  - Override variables defined in the Makefile by the environment:
    make --environment-overrides target

```
### ssh
```bash
ssh

  Secure Shell is a protocol used to securely log onto remote systems.
  It can be used for logging or executing commands on a remote server.
  More information: https://man.openbsd.org/ssh.

  - Connect to a remote server:
    ssh username@remote_host

  - Connect to a remote server with a specific identity (private key):
    ssh -i path/to/key_file username@remote_host

  - Connect to a remote server using a specific [p]ort:
    ssh username@remote_host -p 2222

  - Run a command on a remote server with a [t]ty allocation allowing interaction with the remote command:
    ssh username@remote_host -t command command_arguments

  - SSH tunneling: [D]ynamic port forwarding (SOCKS proxy on localhost:1080):
    ssh -D 1080 username@remote_host

  - SSH tunneling: Forward a specific port (localhost:9999 to example.org:80) along with disabling pseudo-[T]ty allocation and executio[N] of remote commands:
    ssh -L 9999:example.org:80 -N -T username@remote_host

  - SSH [J]umping: Connect through a jumphost to a remote server (Multiple jump hops may be specified separated by comma characters):
    ssh -J username@jump_host username@remote_host

  - Agent forwarding: Forward the authentication information to the remote machine (see man ssh_config for available options):
    ssh -A username@remote_host
```

### shutdown
```bash
shutdown

  Shutdown and reboot the system.
  More information: https://manned.org/shutdown.8.

  - Power off ([h]alt) immediately:
    shutdown -h now

  - [r]eboot immediately:
    shutdown -r now

  - [r]eboot in 5 minutes:
    shutdown -r +5 &

  - Shutdown at 1:00 pm (Uses 24[h] clock):
    shutdown -h 13:00

  - [c]ancel a pending shutdown/reboot operation:
    shutdown -c
```

### docker
```bash
docker

  Manage Docker containers and images.
  Some subcommands such as docker run have their own usage documentation.
  More information: https://docs.docker.com/engine/reference/commandline/cli/.

  - List all Docker containers (running and stopped):
    docker ps --all

  - Start a container from an image, with a custom name:
    docker run --name container_name image

  - Start or stop an existing container:
    docker start|stop container_name

  - Pull an image from a Docker registry:
    docker pull image

  - Display the list of already downloaded images:
    docker images

  - Open an [i]nteractive [t]ty with Bourne shell (sh) inside a running container:
    docker exec -it container_name sh

  - Remove a stopped container:
    docker rm container_name

  - Fetch and follow the logs of a container:
    docker logs -f container_name
```