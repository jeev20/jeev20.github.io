---
layout: post
title: Essentials installer for debian distribution
date: 2024-05-19 10:08 +0200
categories: ["miscellaneous"]
tags: ["bash script"]
mermaid: true
published: true
---

I use the following script to quickly setup a new installation of a debian distribution with my commonly used packages and libraries. 

This allows for quick headless deployment of all essential programs and decreases the overhead when hopping distributions! 

```bash
#!/bin/bash

# Update and upgrade packages finally remove stale files
sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y

# Install apt packages most used
sudo apt-get remove docker docker-engine docker.io
sudo apt install python-is-python3 -y \
neofetch -y \
htop -y \
bpytop -y \
npm -y \
tree -y \
docker.io -y \
curl -y \
ssh -y \
openssh-server -y

# Install rustup to install cargo and python package management
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install UV for python package management
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install node packages
sudo npm install -g tldr -y

# Install cargo packages
cargo install broot --force
broot -y
```