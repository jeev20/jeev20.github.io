---
layout: post
title: Nerd miner setup
date: 2024-06-12 14:06 +0200
categories: ["blockchain"]
tags: ["mining", "bitcoin", "nerd miner"]
mermaid: true
published: true
---

About two months ago, I found out about an open-source project called [NerdMiner](https://github.com/BitMaker-hub/NerdMiner_v2?tab=readme-ov-file) and the curiosity led me to try the project out myself. 

NerdMiner is a solo-miner software setup on very low specification hardware, such as ESP32 micro controllers. In this case it mines for bitcoin by pooling together large number of such boards. 

The cool part about this setup is that it sips power in comparison to the state-of-the-art bitcoin miners. The ESP32's I have probably use 160 mA per board, which is negligible in the grand scheme of things. 

That said, the chances of finding a block on a hardware this weak is next to 0! Therefore, some call it a bitcoin lottery. 

The hardware setup is quite simple as shown below. A cluster of 4 ESP32 Wroom boards connected to a powered USB hub. 

The software is quite easy to flash onto the ESP32. The [post](https://bitcointalk.org/index.php?topic=5466940.0) and [website](https://flasher.bitronics.store/) goes over the flashing process. 


```mermaid

graph TD

    subgraph ESP32_Cluster
    direction TB
        Esp1[<img src='https://no.mouser.com/images/espressifsystems/lrg/ESP32-DevKitC-32E_SPL.jpg' width='40' height='150'/>] 

        Esp2[<img src='https://no.mouser.com/images/espressifsystems/lrg/ESP32-DevKitC-32E_SPL.jpg' width='40' height='150'/>]


        Esp3[<img src='https://no.mouser.com/images/espressifsystems/lrg/ESP32-DevKitC-32E_SPL.jpg' width='40' height='150'/>] 

        Esp4[<img src='https://no.mouser.com/images/espressifsystems/lrg/ESP32-DevKitC-32E_SPL.jpg' width='40' height='150'/>] 


    end 



    Powered_USB_Hub

 
ESP32_Cluster-->Powered_USB_Hub


```

Quite happy with how it runs. 

![OutputVSCodeExtension](/assets/images/ESP32Cluster.png)
