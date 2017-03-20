<!--
author:ivan
date: 2017-03-07
title: 两个树莓派(或香蕉派)之间的音频直播测试
tags: 树莓派,香蕉派
category: 树莓派
status: publish
summary: 两个设备（树莓派或香蕉派）。一个设备做录音端，一个设备做播放端，通过网络的方式建立连接。 
-->
***

##一、场景介绍及准备工作
###1. 场景
> - 一共两个设备（树莓派或香蕉派）。一个设备做录音端，一个设备做播放端，通过网络的方式建立连接。
- 网络连接采用netcat的方式在录音端建立监听(arecord -D 'xxx(录音设备名)' |nc -l 8888)，在播放端连接上监听后播放（nc  xxx.xxx.xxx(ip地址) xxxx(端口) | aplay)。
- 为了简化手工输入命令，用python来实现在一个设备来控制另外一个设备自动录音、播放。

###2. 准备工作
- 两个设备（树莓派或香蕉派，我手上有一个树莓派一个香蕉派，香蕉派自带mic）、设备安装好系统（本场景中以debian为例）、网络环境（设备可以上网、两个设备可以互相访问）、3.5插头喇叭----这部分工作在本文不做介绍
- 安装好声卡驱动、alsa工具、python-pip环境
***
##二、步骤说明
###1、安装alsa-utils
在终端中输入：
```
sudo apt-get install alsa-utils
```
安装完成后输入`aplay -l`来查看当前的声卡设备，输入`arecord -l`来查看当前的录音设备。
- 声卡播放设备
树莓派上如果显示不出播放设备，应该是没有把声音模块加入内核，需要输入：
```
 sudo modprobe snd-bcm2835 #把声音模块加入内核
```
- 录音设备
树莓派不自带mic的需要插入外置录音设备，香蕉派自带mic就能直接看到录音设备了

###2. 测试单设备和录音和播放
- 单录音(例：`arecord -l `中看到的是`plughw:1,0`  其他参数自行查用法)
```
arecord -D plughw:1,0 -t wav -f cd -r 8000 ./test.wav
```
在当前目录录音生成test.wav
- 单播放
```
aplay ./test.wav
```
- 边录边播
```
arecord -D plughw:1,0 -t wav -f cd -r 8000 | aplay
```
得到期望的结果为录音和播放正常。

###3.测试一个设备录音，另一个设备播放
输入`nc -h`看一下系统中是否已安装netcat，如果未安装，通过`sudo apt-get install netcat`进行安装。
> 这里两台设备的ip分别为：
- A设备：192.168.1.101
- B设备：192.168.1.102

- ####第一种方式（延迟高）：
>- 在A设备录音：
```
arecord -D plughw:1,0 -t wav -f cd -r 8000 | nc -l 8888
```
>- 在B设备播放：
```
nc 192.168.1.102 8888 | aplay
```
得到期望的结果为在B设备能听到A设备的录音。但是实际测试延迟很高，本地环境有近5秒的延迟

- ####第二种方式（延迟低）：
>- 在B设备设置播放监听：
```
nc -l -p 8888 | aplay
```
>- 在A设备推送录音：
```
arecord -D plughw:1,0 -t wav -f cd -r 8000 | nc 192.168.199.102 8888
```
得到期望的结果为在B设备能听到A设备的录音。实际测试延迟为0.5秒


###4. 自动化控制
只在一个设备里控制另一个设备进行录音或者播放。
这里用python的paramiko库来实现这个测试。
- ####a. 首先安装pip：
```
sudo apt-get install build-essential libssl-dev libffi-dev python-dev
sudo easy_install pip
```
- ####b. 通过pip安装paramiko:
```
sudo pip install paramiko
```
- ####c. 写python控制程序：

 - #####c1. 实现A设备控制B设备录音，并在A设备中播放 (采用延迟低的方式) :

```
#!/bin/python
# -*- coding: utf-8 -*-
import paramiko
import os
import threading

#B端的IP
ip='192.168.1.102'
port = 22
username = '用户名'
password = '密码'

def aplay(i):
        os.system('nc -l -p 5555|aplay')
#A端建立监听
t1=threading.Thread(target=aplay,args=('',))
t1.setDaemon(True)  #让线程在后台方式运行
t1.start()

#操作B端推送录音
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(ip, port,username, password)
cmd='arecord -D plughw:1,0 -t wav -f cd -r 8000 | nc 192.168.199.101 5555'
stdin, stdout, stderr = ssh.exec_command(cmd)

ssh.close()
```

- #####c2. 实现A设备控制 B设备录音，并在A设备中播放，同时A设备录音在B设备中播放。(双向录播)

 *c2.1先要在B端放置一个py以方便调用，位置如`~/aplay-d.py`，并加上可执行权限。内容如下：*

```
#!/bin/python
# -*- coding: utf-8 -*-
import paramiko
import os
import threading

def aplay(i):
        os.system('nc -l -p 6666|aplay')
#建立监听
t1=threading.Thread(target=aplay,args=('',))
t1.setDaemon(True)  #让线程在后台方式运行
t1.start()
```
   *c2.2 A端的代码： *

```
#!/bin/python
# -*- coding: utf-8 -*-
import paramiko
import os
import threading

#B端的IP
ip='192.168.1.102'
port = 22
username = '用户名'
password = '密码'

def aplay(i):
        os.system('nc -l -p 5555|aplay')
def arecord(i):
        os.system('arecord -D plughw:1,0 -f cd -t wav | nc 192.168.1.102 6666')
#A端建立监听
t1=threading.Thread(target=aplay,args=('',))
t1.setDaemon(True)  #让线程在后台方式运行
t1.start()


#操作B端建立监听，并推送录音给A端
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(ip, port,username, password)
cmd1='python ~/aplay-d.py'  #在B端建立监听
cmd2='arecord -D plughw:1,0 -t wav -f cd -r 8000 | nc 192.168.199.101 5555'  #将录音推送给A端
stdin, stdout, stderr = ssh.exec_command(cmd1)
stdin, stdout, stderr = ssh.exec_command(cmd2)


#A端推送录音给B端
t2=threading.Thread(target=arecord,args=('',))
t2.setDaemon(True)  #让线程在后台方式运行
t2.start()

ssh.close()
```

> `arecord -f cd -D "plughw:1" -d 10 | ssh yanisyu@192.168.1.102 aplay -f cd` 理论上这种方式也可行
