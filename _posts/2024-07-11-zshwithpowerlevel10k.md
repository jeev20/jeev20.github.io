---
layout: post
title: ZSH with Powerlevel10k
date: 2024-07-11 11:44 +0200
categories: ["miscellaneous"]
tags: [ "bash script", "helper", "zsh", "powerlevel10K", "ohmyzsh"]
mermaid: true
published: true
---

**TL;DR**

My terminal now looks something like this across all of my devices. Thanks to [zsh](https://www.zsh.org/), [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) and [p10k](https://github.com/romkatv/powerlevel10k) projects!

* Standard directory view
   ![ZSHP10K](/assets/images/zshp10k.png)

* Standard git directory and virtualenv
   ![zshp10kVenv](/assets/images/zshp10kVenv.png)

--------------------------------------------------

Some years ago I had tested the `zsh` terminal and the Powerlevel10K theme to go with it, but for reasons unknown I did not use it actively. In recent times, my time within the terminal has increased, hence it was time to make the terminal look a little prettier than the standard `bash` terminal.  

### Installation script

The script below installs the `zsh` terminal and installs the [powerlevel10K](https://github.com/romkatv/powerlevel10k) theme. We also need to install the [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) project. Finally, the `zsh` terminal is set as the default terminal. This last part requires `sudo` permissions/authentication and cannot be completed unattended.
```bash
#!/bin/bash

sudo apt install zsh
cd
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
chsh -s /bin/zsh

```

`p10k configure` can then be used to configure the terminal as one pleases. This runs the configuration wizard.

![p10kconfigure](/assets/images/p10kconfigure.png)



Plugins used in `.zshrc` are independent of the options chosen in the `p10k configure`. For example, I needed the auto suggestions in ohmyzsh, python environment and pip zsh plugins. Installing plugins is a simple as setting the following line in the `.zshrc` file. Here is a list of [available plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins) from [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) project.

```plaintext 
.zshrc
....
plugins=(git zsh-autosuggestions zsh-syntax-highlighting pipenv pip)
...
```

### Customized p10K configure 
My p10k options are: *awesome-fontconfig, large icons, rainbow, unicode, 24h time, blurred heads, blurred tails, 2 lines, solid, full frame, light-ornaments, sparse, many icons, fluent, instant_prompt=verbose.*



>In the last step of the configuration wizard, the `.zshrc` file is updated with the selected options. Remember that the `.zshrc` and `.p10k.zsh` files are overwritten by default. So backup them before running `p10K configure`. 
{: .prompt-danger }

 
 
### Contents of my .zshrc and .p10k.zsh

### [.zshrc gist](https://gist.github.com/jeev20/77f1ae86f5a9e6709ddd5398dbfbc96f)
{% gist 77f1ae86f5a9e6709ddd5398dbfbc96f %}

### [.p10k.zsh gist](https://gist.github.com/jeev20/a5fecd61b8ce9b985bae88095374e05d)
{% gist a5fecd61b8ce9b985bae88095374e05d %}