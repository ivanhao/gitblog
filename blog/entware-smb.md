<!--
author:ivan 
date: 2016-02-12
title: 赚钱宝root后第一件事，entware,samba-赚钱宝折腾 
tags: samba,entware,赚钱宝 
category: 赚钱宝折腾 
status: publish
summary: 赚钱宝root后，自由了，然后呢？
-->
***
  **迅雷赚钱宝**root后真是一切都自由了！

  关于root，原来是序列号的后8位，后来迅雷官方修改规则了，特别是pro，完全进不去。没办法，只能在某宝上找了一个算号的算出来密码进去了。

ROOT后首先是要创建一个自己的root权限用户，并配置entWare环境。

##一、创建一个自己的root权限用户
首先用root登陆到赚钱宝，然后输入如下命令来创建一个新用户：
```
adduser myuser
```
这里的"myuser"就是我们想要添加账户的用户名，你可以选择任何想要的名字。但是仅限字母、数字和下划线。

运行adduser命令后，系统会提示你输入你想要的密码 "New Password:"，然后再提示你输入同样的密码"Retype password:"。

至此，新的用户 "myuser" 已经添加成功。

然后，需要给myuser附加跟root一样的权限,用vi来编辑/etc/passwd，具体vi的用法需要自己学习：
```
vi /etc/passwd
```
会看到类似如下：
```
root:x:0:0:root:/root:/bin/ash
...
myuser:x:1001:1001:Linux User,,,:/home/myuser:/bin/sh
```
可以把第一个1001改成0：
```
myuser:x:0:1001:Linux User,,,:/home/myuser:/bin/sh
```
或者直接改成跟第一行一样的权限，比如：
```
myuser:x:0:0:root:/root:/bin/ash
```
然后输入:wq保存。然后exit退出root用户，再用新建的用户登陆就可以了。
***

##二、安装配置entware环境
###什么是entware
介绍entware前要先说一下什么是optware：
> *optware 是DD-WRT系统中的一个类似第三方软件的运行环境，为什么叫做optware是因为这个环境是装在/opt目录下的，值得注意的是，这个opt也有自己的/bin、/etc、/lib等目录，基本和一个完整的linux环境类似。
optware的软件都是已经编译好了的，通过ipkg软件进行下载安装，只要知道软件名就能通过ipkg install 软件名，进行安装。*

Entware是OptWare的一个替代品，属于OpenWrt的一部分。其本来的作用是在路由器提供一个Linux的运行环境。并且Entware有大量编译好的软件可以通过网络下载和安装。

###安装entware
首先，要创建/opt目录，赚钱宝默认没有这个目录，```df -h```看了一下，/app目录下是有不少内容空间的，可以使用这里来创建软链接目录：
```
mkdir /app/opt
ln -s /app/opt /opt
```

进入opt目录下安装entware环境脚本
```
cd /opt
wget http://qnapware.zyxmon.org/binaries-armv7/installer/entware_install_arm.sh
chmod 777 ./entware_install_arm.sh
sh ./entware_install_arm.sh
```
需要一段时间下载安装.

如果没有报错，就安装成功了。如果有错误，就运行```rm -rf ./*```命令后从头做起。

###entware常见使用方法
```
/opt/bin/opkg update > *|更新
/opt/bin/opkg install samba36-server > *|安装samba
/opt/bin/opkg list-installed > *|查看安装列表里是否有samba36-server
/opt/bin/opkg list > *|查看所有可安装的包
```
***
##SAMBA的安装配置
安装：
```
/opt/bin/opkg install samba36-server
```
df -h |看看你的U盘TF卡的挂载路径,Mounted on那一列
|/media/XXXXXX分别有四种情况mmcblk0、mmcblk1
|sda、sda1，记住目录名称，后面要用
```
vi /opt/etc/samba/smb.conf
```
新建一个smb.conf配置文件,把以下内容粘贴进去
按A键进入编辑模式,把以下内容复制用鼠标右键粘贴进去,
按ESC退出编辑模式,按:输入wq 保存退出.
```
  [global]
  netbios name = |NAME|
  display charset = |CHARSET|
  interfaces = |INTERFACES|
  server string = |DESCRIPTION|
  unix charset = |CHARSET|
  workgroup = |WORKGROUP|
  display charset = UTF-8
  unix charset = UTF-8
  dos charset = cp936
  browseable = yes
  deadtime = 30
  domain master = yes
  encrypt passwords = true
  enable core files = no
  guest account = nobody
  guest ok = yes
  local master = yes
  load printers = no
  map to guest = Bad User
  max protocol = SMB2
  min receivefile size = 16384
  null passwords = yes
  obey pam restrictions = yes
  os level = 20
  passdb backend = smbpasswd
  preferred master = yes
  printable = no
  security = user
  smb encrypt = disabled
  smb passwd file = /opt/etc/samba/smbpasswd
  socket options = TCP_NODELAY IPTOS_LOWDELAY
  syslog = 2
  use sendfile = yes
  writeable = yes
  [*****自行填写共享文件夹的名称*****]
  path = *****自行填写*****
  valid users = root
  read only = no
  guest ok = yes
  create mask = 0750
  directory mask = 0750
```
  注:
```
  display charset = UTF-8 |这三个是配置文字编码,解决乱码的问题,
  unix charset = UTF-8 |根据访问终端自行修改吧
  dos charset = cp936
  path = *****自行填写***** |共享目录路径/media/******<填写上你U盘的目录>
```
  ===============================配置用户名密码,驱动服务器 ===========================
```  
  smbpasswd -a root |然后重复输入两次密码
  /opt/sbin/samba/smbpasswd -a root |如果上面那个不能运行,试试这个命令
  /opt/etc/init.d/samba start |启动服务器
  现在你就可以在windows的运行里输入 \\IP地址 访问入你赚钱宝的U盘了
```  
  ============================最后,设置开机自动运行samba服务器========================
  第一代赚钱宝：
```
  vi /etc/init.d/rcS
```
  第二代赚钱宝，也就是pro：
```
  vi /etc/rc.local
```
  按下A键在文件最后添加
  sleep 30
  /opt/etc/init.d/rc.unslung start
  按下ESC键,按:输入wq保存退出,那么以后你的赚钱宝重启了也不用手动从新开一次smb服务器
