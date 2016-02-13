<!--
author:ivan 
date: 2016-02-12
title: 赚钱宝root后第二件事，安装迅雷远程-赚钱宝折腾 
tags: xware,迅雷远程,赚钱宝 
category: 赚钱宝折腾 
status: publish
summary: 赚钱宝root后，安装迅雷远程，实现远程下载，离线加速！把赚钱宝变成下载宝！离线下载加速后基本能下载满速。
-->
***
  **迅雷赚钱宝**root后真是一切都自由了！

  关于root，原来是序列号的后8位，后来迅雷官方修改规则了，特别是pro，完全进不去。没办法，只能在某宝上找了一个算号的算出来密码进去了。

##一、下载安装迅雷远程xware固件
安装wget,unzip：
```
/opt/bin/opkg install wget
```
安装好以后就可以用wget下载和安装固件了：
```
cd /app
wget http://dl.lazyzhu.com/file/Thunder/Xware/1.0.31/Xware_netgear_6300v2.tar.gz
tar xzvf Xware_netgear_6300v2.tar.gz
chmod +x ./*
./portal
```
正常这样就能看到如下信息：
```
getting xunlei service info...
Connecting to 127.0.0.1:9000 (127.0.0.1:9000)

THE ACTIVE CODE IS: ******

go to http://yuancheng.xunlei.com, bind your device with the active code.
finished.
```
这里的******就是激活码，按提示到[http://yuancheng.xunlei.com](http://yuancheng.xunlei.com)去绑定你的迅雷账号就可以了。
以后每次进到这个目录运行./portal就可以启动迅雷远程了。
##二、改进配置
首先，迅雷远程目录名太长，可以改一下名：
```
mv Xware* xware
```
然后，每次都要手动运行太麻烦了，要做成启动自动运行：

二代pro：
```
vi /etc/rc.local
加入一行：
/app/xware/portal 
```
一代：
```
vi /etc/init.d/rcS
加入一行：
/app/xware/portal
```
