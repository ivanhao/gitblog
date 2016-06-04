<!--
author: ivan
head: http://pingodata.qiniudn.com/jockchou-avatar.jpg
date: 2016-04-15
title: 在WINDOWS服务器中BAT批处理延迟处理
tags: bat
images: http://pingodata.qiniudn.com/cube2.jpg
category: bat
status: publish
summary: 在WINDOWS服务器中BAT批处理延迟处理
-->

##WINDOWS BAT 延迟处理##
* 主要用于记录：

延迟3秒：

1)ping的方式：
```
ping -n 3 127.0.0.1>null
```

2)wscript：
```
echo Wscript.sleep 5000 > sleep.vbs

Wscript sleep.vbs
```



