---
layout: post
title: Bash Script for Ubuntu Distribution
date: 2024-05-19 10:08 +0200
categories: ["Bash"]
tags: ["install script"]
mermaid: true
published: true
---

I use the following script to quickly setup a new installation of a debian distribution with my commonly used packages and libraries. 

This allows for quick headless deployment of all essential programs and decreases the overhead when hopping distributions! 

```bash
#!/bin/bash

# Update upgrade and remove stale files
sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y

# Install apt packages used often
sudo apt-get remove docker docker-engine docker.io
sudo apt install python-is-python3 -y \
neofetch -y \
htop -y \
bpytop -y \
npm -y \
ripgrep -y \
tree -y \
docker.io -y \
curl -y

# Install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install UV for python package management
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install node packages
sudo npm install -g tldr -y

# Install cargo packages broot
cargo install broot --force
```