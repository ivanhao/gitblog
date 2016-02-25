<!--
author:ivan 
date: 2016-02-13
title: Github pages域名解析 
tags: gitblog,github pages
category: GitBlog 
status: publish
summary: 将github pages解析到自己的域名，通过dnspod和cname方式。 
-->
***
##在github pages里添加CNAME文件
在仓库根目录下添加一个CNAME文件，没有后缀名，里面内容为你的域名(如:test.com),不需要添加http/www等前缀。

ping username.github.io记录下IP地址

![image](http://d.pcs.baidu.com/thumbnail/50204d991772e3fd19551dbf0e1c5937?fid=3422951042-250528-502309307625019&time=1455375600&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-7bMtPfibUB04T8PeB6pznbmCEis%3d&expires=8h&chkbd=0&chkv=0&dp-logid=1019963233171724117&dp-callid=0&size=c10000_u10000&quality=90)

##添加 DNS  Service记录

去DNSPod注册个账号，添加域名，设置两个A记录。分别是@和w w w，ip地址填上个步骤获取的IP地址。
![image](http://d.pcs.baidu.com/thumbnail/e16679a956345e216b98605b5008d9e8?fid=3422951042-250528-491989612283380&time=1455375600&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-JWlMPuKCAZma47%2ful%2bcfAse5b4k%3d&expires=8h&chkbd=0&chkv=0&dp-logid=1019963233171724117&dp-callid=0&size=c10000_u10000&quality=90)

##设置域名的DNS

在相应域名的Csutom DNS里，设置DNS service,添加两条记录f1g1ns1.dnspod.net和f1g1ns2.dnspod.net
![image](http://d.pcs.baidu.com/thumbnail/4178c65ecbaa85264e95bd64618a6b55?fid=3422951042-250528-87362311522840&time=1455375600&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-zW2A2vl2xfQpBA9hEicvDxt45%2fU%3d&expires=8h&chkbd=0&chkv=0&dp-logid=1019963233171724117&dp-callid=0&size=c10000_u10000&quality=90)

4、漫长的等待

要全球解析生效， 得等上一会了，也可以先ping一下自己的设置对不对。

> *转自：http://jingyan.baidu.com/article/3c343ff70fb6e60d3779632f.html*

