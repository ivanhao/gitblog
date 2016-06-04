<!--
author: ivan
head: http://pingodata.qiniudn.com/jockchou-avatar.jpg
date: 2016-04-01
title: 在WINDOWS服务器中执行自动拷贝数据库备份并恢复
tags: Oracle,bat
images: http://pingodata.qiniudn.com/cube2.jpg
category: Oracle
status: publish
summary: 在WINDOWS服务器中执行自动拷贝数据库备份并恢复
-->

##数据库自动恢复脚本##
* 主要用于记录：

```
@echo off

rem 取时间
set year=%date:~0,4%
set mon=%date:~5,2%
set day=%date:~8,2%

rem 路径变量
set loc=E:\ora-bak\
set rar="C:\Program Files (x86)\WinRAR\"
set z="\\10.100.100.2\admin\jiqun_orabak\"
echo loc:%loc%

rem 取头一天时间
echo Wscript.echo DatePart("YYYY",dateadd("d",-1,date)) ^& Right("0" ^& DatePart("m",dateadd("d",-1,date)),2) ^& Right("0" ^& DatePart("d",dateadd("d",-1,date)),2) >%loc%vbs.vbs
for /f %%a in ('cscript //nologo %loc%vbs.vbs') do del %loc%vbs.vbs&&set ld=%%a

echo Date is: %year%-%mon%-%day% > %loc%imp.log
echo LastDate is: %ld% >> %loc%imp.log

rem 删除头一天文件
echo %date% -- deleting last file... >> %loc%imp.log
del /Q %loc%nc55-%ld:~0,4%-%ld:~4,2%-%ld:~6,2%.dmp*

rem 复制文件
echo %date% -- coping z:\nc55-%year%-%mon%-%day%.dmp.gz ... >> %loc%imp.log
copy %z%nc55-%year%-%mon%-%day%.dmp.gz %loc%

rem 解压文件
echo %date% -- unraring... >> %loc%imp.log
%rar%winrar e %loc%nc55-%year%-%mon%-%day%.dmp.gz %loc%

rem 生成sql1
echo %date% -- create sql1 ... >>%loc%imp.log
echo. >%loc%1.sql
echo create user nc%date:~2,2%%mon%%day% identified by 1;>>%loc%1.sql
echo grant connect,dba to nc%date:~2,2%%mon%%day%;>>%loc%1.sql
echo 
grant read,write on directory dir_dp to nc%date:~2,2%%mon%%day%;>>%loc%1.sql
echo commit;>>%loc%1.sql
echo exit >>%loc%1.sql

rem 生成sql2
echo %date% -- create sql2 ... >>%loc%imp.log
echo. >%loc%2.sql
echo drop user nc%ld:~2,2%%ld:~4,2%%ld:~6,2% cascade;>>%loc%2.sql
echo exit >>%loc%2.sql

rem 停服务
echo %date% -- stop service >>%loc%imp.log
taskkill /f /im java.exe

rem 执行sql脚本
echo %date% -- running sqls >>%loc%imp.log
sqlplus sys/sys@orcl2 as sysdba @%loc%1.sql
sqlplus sys/sys@orcl2 as sysdba @%loc%2.sql

rem 启动服务
echo %date% -- start service >>%loc%imp.log
start cmd /c "D:\nchome1211\startup.bat"

rem 导入数据库备份
echo %date% -- impdp database >>%loc%imp.log
impdp nc%date:~2,2%%mon%%day%/1@orcl2 directory=dir_dp dumpfile=nc55-%year%-%mon%-%day%.dmp logfile=nc55-%year%-%mon%-%day%.log remap_schema=nc55:nc%date:~2,2%%mon%%day%

echo %date% -- done >>%loc%imp.log
exit
```


