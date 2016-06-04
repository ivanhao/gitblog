<!--
author:ivan 
date: 2016-03-05
title: 用LINUX下的testDisk找回损坏硬盘的文件 
tags: testDisk,数据恢复 
category: Linux 
status: publish
summary: 用LINUX下的testDisk找回损坏硬盘的文件 
-->

***
##现象
  WINDOWS7下的硬盘损坏，开机报警，拆下后在用易驱线在别的WINDOWS电脑中也无法识别，同事用WIN下的修复软件没有修复成功，最后用一个购买的软件从分区中把重要文件拷出。

##testDisk拷贝文件
  ####在debian下安装testDisk
  ```
  sudo apt-get install testDisk
  ```
  安装完成后先用`fdisk -l`看一下要修复的硬盘在/dev下的哪个位置，例如是/dev/sda
  
  然后：
  ```
  sudo testdisk /dev/sda
  ```
  #####1.选择硬盘
```
Select a media (use Arrow keys, then press Enter):
    Disk /dev/sda - 160 GB / 149 GiB - ATA HITACHI HTS54251
    Disk /dev/sdb - 3272 MB / 3121 MiB - SM324BC USB DISK
```

  #####2.选择testdisk修复的平台,windows分区选Intel的
```
    Diskse select the partition table type, press Enter when done.
    [Intel  ]  Intel/PC partition
    [EFI GPT]  EFI GPT partition map (Mac i386, some x86_64...)
    [Mac    ]  Apple partition map
    [None   ]  Non partitioned media
    [Sun    ]  Sun Solaris partition
    [XBox   ]  XBox partition
    [Return ]  Return to disk selection /dev/sda - 160 GB / 149 GiB - ATA HITACHI HTS54251
```
  #####3.使用testdisk分析,现在选择Analyse进行分析
    [ Analyse  ]  Analyse current partition structure and search for lost partitions
    [ Advanced ]  Filesystem Utils
    [ Geometry ]  Change disk geometry
    [ Options  ]  Modify options
    [ MBR Code ]  Write TestDisk MBR code to first sector
    [ Delete   ]  Delete all data in the partition table
    [ Quit     ]  Return to disk selection
  #####4.分析完后基本所有的分区都出来了,直接回车就好了,默认直接回车是快速扫描.
  ```
  *=Primary bootable  P=Primary  L=Logical  E=Extended  D=Deleted
    [Quick Search]  [ Backup ]
  ```
    然后因为没用vista,所以选择n。
  ```  
    Should TestDisk search for partition created under Vista ? [Y/N] (answer Yes if
    unsure)
    N
  ```
  #####5.进入后可以看到分区表了。
  ```
    Disk /dev/sda - 160 GB / 149 GiB - CHS 19457 255 63
         Partition               Start        End    Size in sectors
    * HPFS - NTFS              0   1  1  1567 254 63   25189857
    L FAT32 LBA             1568   2  1  5097 254 63   56709324 [NO NAME]
    L Linux Swap            5098   1  1  5221 254 63    1991997
    L Linux                 5222   1  1  7298 254 63   33366942
    L Linux                 7299   1  1 19456 254 63  195318207
    Structure: Ok.  Use Up/Down Arrow keys to select partition.
    Use Left/Right Arrow keys to CHANGE partition characteristics:
    *=Primary bootable  P=Primary  L=Logical  E=Extended  D=Deleted
    Keys A: add partition, L: load backup, T: change type, P: list files,
         Enter: to continue
    NTFS, 12 GB / 12 GiB
  ```

    可以按p进入一下，看看文件是不是你想要的,进入后可以按提示将文件拷贝出来.如用:标记要拷贝的文件，然后大写的C进行拷贝，拷贝会提示你选择目标路径。

    这样就可以把里面的文件拷贝出来的。

    如果显示的和你的分区不一样,那可能还需要使用Deeper search的功能.

    如果已经找直接按write直接进行写到分区表中修复.
    
    write后需要重新插拔硬盘后才能生效，否则马上挂载分区是不生效的。
