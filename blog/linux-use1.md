<!--
author:ivan 
date: 2016-06-04
title: linux的常用命令1
tags: linux
category: linux
status: publish
summary: linux的常用命令1
-->
***

##1.netstat查看端口是否占用

```
netstat -nao|grep 9999
```

##2.lsof查看占用端口的进程

```
lsof -i:9999
```
