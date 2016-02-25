<!--
author:ivan 
date: 2016-02-20
title: 赚钱宝root后挂载共享盘或者NAS-赚钱宝折腾 
tags: samba,entware,赚钱宝 
category: 赚钱宝折腾 
status: publish
summary: 赚钱宝使用共享盘或者NAS当下载盘
-->
***
  **迅雷赚钱宝**root后真是一切都自由了！

  关于root，原来是序列号的后8位，后来迅雷官方修改规则了，特别是pro，完全进不去。没办法，只能在某宝上找了一个算号的算出来密码进去了。

##一、先简单说原理
首先，赚钱宝会把USB口mount到/media/sda1，所以，需要把/media/sda1卸载（umount),然后把共享的文件夹用mount -t cifs的方式挂载到/media/sda1

然后，有个问题，就是`umount /media/sda1`时，由于赚钱宝进程在使用，会提示busy无法umount，那需要停进程，在`/thunder/bin`下有个restart_app.sh，我改了一下，用来stop所有赚钱宝的进程。但是没有成功，重新启动后还是会挂载USB口，后来改进了一下，只停`/thunder/bin/dcdn_client`就行了。挂载好共享盘后再重新启动。

方法：
```
    kill `pidof dcdn_client`
    umount /media/sda1
    mount -t cifs -o username=`xxx`,password=`xxx-passwd`,rw //`192.168.1.xx/sharefolder` /media/sda1
    /thunder/bin/dcdn_client 0
```
##二、优化
1. 把这些放在一个sh里，然后放在/usr/bin下，比如mounthd.sh
```
    kill `pidof dcdn_client`
    umount /media/sda1
    mount -t cifs -o username=`xxx`,password=`xxx-passwd`,rw //`192.168.1.xx/sharefolder` /media/sda1
    /thunder/bin/dcdn_client 0
```
这样每次只需要输入mouthd.sh就可以自动执行这个操作了

2. 在`/etc/rc.local`里加入`/usr/bin/mounthd.sh`，让它每次启动时自动执行。（这个我没实际测试）

<iframe height=100% width=100% src="http://pan.baidu.com/s/1gepyaAZ" frameborder=0 allowfullscreen></iframe>
```  
```
