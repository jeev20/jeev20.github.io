---
layout: post
title: Useful linux commands
date: 2024-05-23 23:30 +0200
mermaid: true
published: true
---

The aim with this post is to centralize all my most used linux commands and their different use case descriptions using the tldr module.  

Someday when I wonder what the syntax was for a command, I have a place to refer, hopefully! 

### `scp` command
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
