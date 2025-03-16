---
layout: post
title: Using all GPUs when running Ollama and OpenWebUI in docker 
date: 2025-02-17 15:01 +0100
categories: ["llm"]
tags: ["ollama", "openwebui"]
mermaid: true
published: true
---


> Case: Run both Ollama and OpenWebUI in a single docker container and use all available GPUs in the host machine
{: .prompt-warning }

> TL;DR: 
>```bash
# Installing nvidia-container-toolkit
> curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
> sudo apt-get update
> sudo apt-get install -y nvidia-container-toolkit
> 
# Installing ollama and open-webui in docker
> sudo docker run -d -p 3000:8080 --gpus=all -v ollama:/root/.ollama -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:ollama
> sudo docker run --rm --volume /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --run-once open-webui
> 
> # Pulling some models from Ollama repository
> sudo docker exec open-webui ollama pull phi4
```
{: .prompt-tip}


I have been using Ollama as a standalone installation in my homelab which ran as a systemd service. I used OpenWebUI as the user interface to the local Ollama installation. However, a recent version of Ollama failed to auto spawn on my LMDE 6 operating system after a restart. 

Naturally, I had to look for an alternative with minimal maintenance need. Thankfully, OpenWebUI offers an image which bundles both Ollama and the OpenWebUI and uses the Nvidia-Container-Toolkit to utilize all installed GPUs. 

This means that I only have to maintain one container for both Ollama and OpenWebUI installation. Further, to automate this update process, I use watchtower to install the latest updates of the image from the OpenWebUI team. 

## Docker run can fail
I observed that running only `sudo docker run -d -p 3000:8080 --gpus=all -v ollama:/root/.ollama -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:ollama` did not work as it required [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) to be installed first. 

So I ran 
```bash
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
```

Followed by
```bash
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
```

And then ran the open-webui docker command
```bash 
sudo docker run -d -p 3000:8080 --gpus=all -v ollama:/root/.ollama -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:ollama
sudo docker run --rm --volume /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --run-once open-webui
```

Docker started the container and also setup the watchtower auto-update for the `open-webui` container. 

I can now use the `docker exec` command to use Ollama cli within the container. I downloaded some models by using
```bash
sudo docker exec open-webui ollama pull phi4
sudo docker exec open-webui ollama pull qwq
```

Since I reused the docker volume I previously used for open-webui, all my historical prompts were still available after this upgrade. Sweet! 


## Resources
* [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)
* [openwebui](https://github.com/open-webui/open-webui)
* [watchtower](https://github.com/containrrr/watchtower)