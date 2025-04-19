---
layout: post
title: Reviving an old apple mac 💻 🖥️
date: 2025-04-19 11:42 +0200
categories: ["macbookpro"]
tags: ["opencorelegacy"]
mermaid: true
published: true
---

This easter break, I learnt about a brilliant open source project called the [Open Core Legacy Patcher](https://dortania.github.io/OpenCore-Legacy-Patcher/INSTALLER.html#downloading-the-installer) (OCLP), which aims to run newer versions of mac os on old apple hardware. It does this by providing patches and creating compatibility between old hardware and new apple operating system. 

I tried upgrading my old 2013 Macbok Pro and a early 2008 imac using OCLP. I was surprised to see how easy it was to upgrade to the newest version of operating system. However, since the 2008 imac I own has only 4 GB of memory and old AMD GPU, it did have issues running the newest os (sluggish, buggy graphics). Therefore, I skipped upgrading it to the newest version and rolled back to an older OS version called ElCaptain. 

#### Macbook Pro 2013 
The highest supported OS for the 2013 Macbook Pro is BigSur. I wanted to try my luck and run Sequoia 15.14.1 on it. I followed these steps,
* Since I had no important data, I skipped creating any backups, in hindsight I should have atleast created a USB installer for BigSur. This way I would have something to fall back on.
* I installed [Open Core Legacy Patcher](https://dortania.github.io/OpenCore-Legacy-Patcher/INSTALLER.html#downloading-the-installer) to my Applications folder
* I used a NVME drive as my target USB 
* Created a USB Installer on it by choosing USB Drive as target and agreed to the reboot prompt
* On restart, I held on the **option** button and choose to boot from the USB drive
* Once the installation started everything went as expected. There were many restarts but required no input from me.
* Finally, the last part of the installation asked for user and wifi details
* After login to the desktop, I opened **Open Core Legacy Patcher** again 
* Ran the post-installation scripts (this ensures the correct drivers installed and optimizations are made)
* After the reboot, I built the patcher on the internal SSD of the Macbook

## My expierence with OCLP
I do believe, OCLP will revive many old apple computers, which is the way it should be. Old computers still work great and such projects are great for both the tinkers and people who do not want to spend a lot of money to buy a newer computer.

My plan is to keep a backup of the max supported Apple OS (BigSur) in a pendrive, just incase some bugs occur in the future versions of OCLP. 

As of now Sequoia works very smoothly on this 2013 macbook pro. One thing to note is that, on startup the PC takes a while say around 2-4 minutes before it starts getting quick and responsive. 

I am planning to use Macbook Pro as my blogging and recording pc. This blog post was written on it using VSCode and devcontainer extension. Overall the installation works smooth and hassel free.


## Resources
Here are some of the video resources which helped me setup Open Core Legacy Patcher 

   * Installing Sequoia from Anson Alexander
   {% include embed/youtube.html id='v=in5-3EjKFqA' %}

   * OCLP basics video from Anson Alexander
   {% include embed/youtube.html id='v=D8djeFJ1czU' %}

