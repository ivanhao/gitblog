<!--
author:ivan 
date: 2016-02-13
title: Github pages域名解析 
tags: gitblog,github pages
category: gitblog 
status: publish
summary: 将github pages解析到自己的域名，通过dnspod和cname方式。 
-->
***
##在github pages里添加CNAME文件
在仓库根目录下添加一个CNAME文件，没有后缀名，里面内容为你的域名(如:test.com),不需要添加http/www等前缀。

ping username.github.io记录下IP地址
[](http://hiphotos.baidu.com/exp/pic/item/7ac880510fb30f241819b485ca95d143ac4b0371.jpg)

##添加 DNS  Service记录

去DNSPod注册个账号，添加域名，设置两个A记录。分别是@和w w w，ip地址填上个步骤获取的IP地址。
[](http://hiphotos.baidu.com/exp/pic/item/1899a23eb13533faa39ec8a8aad3fd1f40345bc8.jpg)

##设置域名的DNS

在相应域名的Csutom DNS里，设置DNS service,添加两条记录f1g1ns1.dnspod.net和f1g1ns2.dnspod.net
[](http://hiphotos.baidu.com/exp/pic/item/adee30dda3cc7cd966ce6f5f3b01213fb90e9112.jpg)

4、漫长的等待

要全球解析生效，得等上一会了，也可以先ping一下自己的设置对不对。

> *转自：http://jingyan.baidu.com/article/3c343ff70fb6e60d3779632f.html*

