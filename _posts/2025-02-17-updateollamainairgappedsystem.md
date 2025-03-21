---
layout: post
title: Updating Ollama in an airgapped linux server
date: 2025-02-17 15:01 +0100
categories: ["llm"]
tags: ["ollama", "airgapped"]
mermaid: true
published: true
---



> Case: Updating Ollama installation in a local server without internet access 
{: .prompt-warning }


> TL;DR: 
> ```bash
> sudo rm -rf /usr/lib/ollama 
> curl -L https://ollama.com/download/ollama-linux-amd64.tgz -o ollama-linux-amd64.tgz
> sudo tar -C /usr -xzf ollama-linux-amd64.tgz 
> ollama serve
> ollama -v
```
{: .prompt-tip}


At work this week I had to update an Ollama instance in a airgapped linux server. The machine only had local ssh access. Thankfully ollama docs explained this scenario well. 

## Step 1 - Remove previous install
`sudo rm -rf /usr/lib/ollama` --> removes the previous Ollama installation. This can also remove the downloaded models unless you do the following.

Previously, to make our downloaded models independent of the Ollama version, I set an environment variable `OLLAMA_MODELS` such that Ollama can get static models from a shared drive. This made sure that when we do have to update Ollama, we do not need to purge already downloaded models. 
By default the downloaded models are saved at 
```
macOS: ~/.ollama/models
Linux: /usr/share/ollama/.ollama/models
Windows: C:\Users\%username%\.ollama\models
```

The following command would set OLLAMA_MODELS to the users home folder `/home/$user/OllamaModels`
```bash 
export OLLAMA_MODELS="/home/$user/OllamaModels"
```

Another way to set `OLLAMA_MODELS` path is to edit the `/etc/systemd/system/ollama.service` file as show in this [walkthrough](https://github.com/ollama/ollama/blob/main/docs/linux.md)
## Step 2 - Download the specific version 

`curl -L https://ollama.com/download/ollama-linux-amd64.tgz -o ollama-linux-amd64.tgz`command downloads the latest version of Ollama to the current folder.
One can also download the same via the github releases page: [Ollama Releases](https://github.com/ollama/ollama/releases)


## Step 3 - Extract contents and copy 
`sudo tar -C /usr -xzf ollama-linux-amd64.tgz` command extracts the contents and copies it to `/usr` folder. 

## Step 4 - Check the installation
`ollama serve` starts the ollama service if it is not already running
`ollama -v` outputs the version of the new version. For example : `ollama version is 0.5.7`
`ollama list` will then output all of your previously downloaded models.



## References

* [Ollama linux installing manually](https://github.com/ollama/ollama/blob/main/docs/linux.md)
* [Ollama general FAQ](https://github.com/ollama/ollama/blob/main/docs/faq.md)

