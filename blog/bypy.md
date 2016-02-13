<!--
author:ivan 
date: 2016-02-13
title: 赚钱宝root后第三件事，安装python的百度云客户端-赚钱宝折腾 
tags: 百度云,bypy,赚钱宝 
category: 赚钱宝折腾 
status: publish
summary: 赚钱宝root后，安装python版的百度云客户端，实现百度云网盘的上传下载。
-->
***
  **迅雷赚钱宝**root后真是一切都自由了！

  关于root，原来是序列号的后8位，后来迅雷官方修改规则了，特别是pro，完全进不去。没办法，只能在某宝上找了一个算号的算出来密码进去了。

##在entware下安装依赖包
安装python2.7和python-requests和git（git用来下载源码包）：
```
/opt/bin/opkg install python python-requests git 
```
安装好以后就可以下载和安装bypy了：
```
cd /app
git clone https://github.com/houtianze/bypy.git
```
这样就下好bypy了，然后进去看一下使用：
```
cd /app/bypy
```
##操作
第一次运行时需要授权，只需跑任何一个命令（比如 `bypy.py info`）然后跟着说明（登陆等）来授权即可。授权只需一次，一旦成功，以后不会再出现授权提示.

更详细的了解某一个命令：
```
bypy.py help <command>
```
显示在云盘（程序的）根目录下文件列表：
```
bypy.py list
```
把当前目录同步到云盘：
```
bypy.py syncup
```
or
```
bypy.py upload
```
把云盘内容同步到本地来：
```
bypy.py syncdown
```
or
```
bypy.py downdir /
```
比较本地当前目录和云盘（程序的）根目录（个人认为非常有用）：
```
bypy.py compare
```
更多命令和详细解释请见运行bypy.py的输出。

##调试

运行时添加`-v`参数，会显示进度详情。
运行时添加`-d`，会显示一些调试信息。
运行时添加`-ddd`，还会会显示HTTP通讯信息（警告：非常多）

```
 
```
