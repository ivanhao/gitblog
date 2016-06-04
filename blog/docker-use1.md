<!--
author:ivan 
date: 2016-06-04
title: docker的基本使用1
tags: docker
category: docker
status: publish
summary: docker的基本使用1
-->
***


1. 容器配置-交互模式

```
sudo docker run -it 镜像名 /bin/bash
```
在交互模式里面可以改一下root的密码，方便后续运行时可以登陆进容器。

2. 提交所做的更改

配置完后exit退出交互模式，然后通过如下方式查看刚刚配置的容器ID

```
sudo docker ps -l
```
找到第一列的CONTAINER ID，然后提交：
```
sudo docker commit 容器ID 镜像名
```

3. 容器运行


```
sudo docker run -d -p 主机端口号1:容器内端口号1 -p 主机端口号2:容器内端口号2 镜像名 /usr/sbin/sshd -D
```

例如：容器里有nginx和mysql，端口分别是80和3306，需要映射到主机的8080和13306，当然既然运行了sshd，也需要把22端口映射出来，方便后续使用：
```
sudo docker run -d -p 8080:80 -p 13306:3306 -p 2022:22 镜像名 /usr/sbin/sshd -D
```
运行后会生成一个新的ID的容器，用`sudo docker ps`可以查看到。

这个时候，nginx和mysql应该并没有启动，可以ssh进去启动：

```
ssh root@localhost -p 2022
```

未完待续....
