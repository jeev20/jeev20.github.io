---
layout: post
title: Ventoy bootable USB drive
date: 2024-06-14 23:15 +0200
categories: ["miscellaneous"]
tags: ["usb", "distro hopping", "writing images"]
mermaid: true
published: true
---

During the past 10 years, I probably have written OS images to pendrives over 300 times. This to either fresh install or reinstall OS on windows, linux, mac and on raspberrypi computers. However, in 2024 I came to know of a tool called [Ventoy](https://www.ventoy.net/en/index.html)! This could have saved me a lot of time and effort in the past. 

Ventoy is a open source tool to create bootable usb drives which supports images in ISO/WIM/IMG/VHD(x)/EFI formats. 

Unlike traditional way of creating an USB bootable drive for each OS image, a Ventoy USB drive can contain all different kind of OS images in one pendrive. It can even organize them as you wish. On boot, you are greeted with a simple GUI where you get the option to choose the image you want to boot into.

I went from using over 8 pendrives to just 1. The simplicity it has brought in my "distro-hopping" workflow is just bliss. I have organized the images files as shown below.


```
VentoyDrive  
│
└───Windows
│   │   Windows 10
│   │   Windows 11
│   
└───Linux
    │   Ubuntu 22.4
    │   Ubuntu 24.4
    │   Kubuntu.24.4
    │   PopOS 22.4
    │   LMDE 6
    │   LinuxMint 21.3
    │   Proxmox 8.2
    │   Gparted
    |   MxLinux

```

> Another great feature of ventoy is that in addition to the OS image files, you are free to use the Ventoy USB drive as a normal USB drive. With a large enough pendrive, ventoy can act as both a bootable usb drive and a regular usb storage device. Fantastic!
{: .prompt-tip}





