<!--
author:ivan 
date: 2016-04-01
title: docker的基本使用
tags: docker
category: docker
status: publish
summary: docker的基本使用
-->
***

以UBUNTU 14.04 为例：

1. 安装

```
sudo apt-get update  
sudo apt-get install docker.io 
```
2. 查看服务状态

```
sudo service docker.io status
sudo docker ps
```
3. 容器管理

刚安装完还没有镜像，需要拉一个镜像

```
docker pull [镜像名]
```

拉取镜像完成后可以查看一下：

```
docker images
```

未完待续....
