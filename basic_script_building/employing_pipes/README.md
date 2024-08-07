### 管道

有时候，你需要将一个命令的输出作为另一个命令的输入。这可以通过重定向来实现，
只是略显笨拙：

```
$ apt --installed list > apt.list
$ sort < apt.list
accountsservice/bionic-updates,bionic-security,now 0.6.45-1ubuntu1.3 amd64 [已安装，自动]
acl/bionic,now 2.2.52-3build1 amd64 [已安装，自动]
acpid/bionic,now 1:2.0.28-1ubuntu1 amd64 [已安装，自动]
acpi-support/bionic,now 0.142 amd64 [已安装，自动]
adduser/bionic,bionic,now 3.116ubuntu1 all [已安装，自动]
adium-theme-ubuntu/bionic,bionic,now 0.3.4-0ubuntu4 all [已安装，自动]
adwaita-icon-theme/bionic,bionic,now 3.28.0-1ubuntu1 all [已安装，自动]
aisleriot/bionic,now 1:3.22.5-1 amd64 [已安装，自动]
alsa-base/bionic,bionic,now 1.0.25+dfsg-0ubuntu5 all [已安装，自动]
alsa-utils/bionic,now 1.1.3-1ubuntu1 amd64 [已安装，自动]
amd64-microcode/bionic-updates,bionic-security,now 3.20191021.1+really3.20181128.1~ubuntu0.18.04.1 amd64 [已安装，自动]
anacron/bionic,now 2.3-24 amd64 [已安装，自动]
ant/bionic-updates,bionic-updates,bionic-security,bionic-security,now 1.10.5-3~18.04 all [已安装]
ant-optional/bionic-updates,bionic-updates,bionic-security,bionic-security,now 1.10.5-3~18.04 all [已安装]
apache2-bin/bionic-updates,bionic-security,now 2.4.29-1ubuntu4.27 amd64 [已安装]
apache2/bionic-updates,bionic-security,now 2.4.29-1ubuntu4.27 amd64 [已安装]
apache2-data/bionic-updates,bionic-updates,bionic-security,bionic-security,now 2.4.29-1ubuntu4.27 all [已安装]
apache2-utils/bionic-updates,bionic-security,now 2.4.29-1ubuntu4.27 amd64 [已安装]
...
```

apt list 命令会显示仓库中所有可用的软件包，如果再加入 `--installed` 选项，
就可以限制仅输出那些已安装在系统中的软件包，但这个列表并不遵循某种特定的顺序。
如果想查找某个或某些特定的软件包，在 apt 命令的输出中就不太好找到了。

通过标准输出重定向，apt 命令的输出被重定向至文件 apt.list。
命令完成后，apt.list 保存着系统中所有已安装的软件包列表。
接下来，输入重定向将 apt.list 文件的内容传给 sort 命令，由后者按字母顺序对软件包名称进行排序。

这种方法的确管用，但仍然是一种比较烦琐的信息生成方式。无须将命令输出重定向至文件，
可以将其直接传给另一个命令。这个过程称为管道连接（piping）。

和命令替换所用的反引号（`` ` ``）一样，管道操作符在 shell 编程之外也很少用到。
该符号由两个竖线构成，一个在上，一个在下。然而，其印刷体往往看起来更像是单个竖线（`|`）。
管道被置于命令之间，将一个命令的输出传入另一个命令中：

```
command1 | command2
```

可别以为由管道串联起的两个命令会依次执行。实际上，Linux 系统会同时运行这两个命令，
在系统内部将二者连接起来。当第一个命令产生输出时，它会被立即传给第二个命令。
数据传输不会用到任何中间文件或缓冲区。

现在，你可以利用管道轻松地将 apt 命令的输出传入 sort 命令来获取结果：

```
$ apt --installed list | sort
accountsservice/bionic-updates,bionic-security,now 0.6.45-1ubuntu1.3 amd64 [已安装，自动]
acl/bionic,now 2.2.52-3build1 amd64 [已安装，自动]
acpid/bionic,now 1:2.0.28-1ubuntu1 amd64 [已安装，自动]
acpi-support/bionic,now 0.142 amd64 [已安装，自动]
adduser/bionic,bionic,now 3.116ubuntu1 all [已安装，自动]
adium-theme-ubuntu/bionic,bionic,now 0.3.4-0ubuntu4 all [已安装，自动]
adwaita-icon-theme/bionic,bionic,now 3.28.0-1ubuntu1 all [已安装，自动]
aisleriot/bionic,now 1:3.22.5-1 amd64 [已安装，自动]
alsa-base/bionic,bionic,now 1.0.25+dfsg-0ubuntu5 all [已安装，自动]
alsa-utils/bionic,now 1.1.3-1ubuntu1 amd64 [已安装，自动]
amd64-microcode/bionic-updates,bionic-security,now 3.20191021.1+really3.20181128.1~ubuntu0.18.04.1 amd64 [已安装，自动]
anacron/bionic,now 2.3-24 amd64 [已安装，自动]
ant/bionic-updates,bionic-updates,bionic-security,bionic-security,now 1.10.5-3~18.04 all [已安装]
ant-optional/bionic-updates,bionic-updates,bionic-security,bionic-security,now 1.10.5-3~18.04 all [已安装]
apache2-bin/bionic-updates,bionic-security,now 2.4.29-1ubuntu4.27 amd64 [已安装]
apache2/bionic-updates,bionic-security,now 2.4.29-1ubuntu4.27 amd64 [已安装]
apache2-data/bionic-updates,bionic-updates,bionic-security,bionic-security,now 2.4.29-1ubuntu4.27 all [已安装]
apache2-utils/bionic-updates,bionic-security,now 2.4.29-1ubuntu4.27 amd64 [已安装]
...
```

除非你眼神（特别）好，否则可能根本来不及看清楚命令输出。
由于管道操作是实时化的，因此只要 apt 命令产生数据，sort 命令就会立即对其进行排序。
等到 apt 命令输出完数据，sort 命令就已经将排好序的数据显示在屏幕上了。

管道可以串联的命令数量没有限制。可以持续地将命令输出通过管道传给其他命令来细化操作。

在这个例子中，由于 sort 命令的输出一闪而过，因此可以用文本分页命令（比如 less 或 more）强行将输出按屏显示：

```
$ apt --installed list -qa | sort | more
accountsservice/bionic-updates,bionic-security,now 0.6.45-1ubuntu1.3 amd64 [已安装，自动]
acl/bionic,now 2.2.52-3build1 amd64 [已安装，自动]
acpid/bionic,now 1:2.0.28-1ubuntu1 amd64 [已安装，自动]
acpi-support/bionic,now 0.142 amd64 [已安装，自动]
adduser/bionic,bionic,now 3.116ubuntu1 all [已安装，自动]
adium-theme-ubuntu/bionic,bionic,now 0.3.4-0ubuntu4 all [已安装，自动]
adwaita-icon-theme/bionic,bionic,now 3.28.0-1ubuntu1 all [已安装，自动]
aisleriot/bionic,now 1:3.22.5-1 amd64 [已安装，自动]
alsa-base/bionic,bionic,now 1.0.25+dfsg-0ubuntu5 all [已安装，自动]
alsa-utils/bionic,now 1.1.3-1ubuntu1 amd64 [已安装，自动]
amd64-microcode/bionic-updates,bionic-security,now 3.20191021.1+really3.20181128.1~ubuntu0.18.04.1 amd64 [已安装，自动]
anacron/bionic,now 2.3-24 amd64 [已安装，自动]
ant/bionic-updates,bionic-updates,bionic-security,bionic-security,now 1.10.5-3~18.04 all [已安装]
ant-optional/bionic-updates,bionic-updates,bionic-security,bionic-security,now 1.10.5-3~18.04 all [已安装]
apache2-bin/bionic-updates,bionic-security,now 2.4.29-1ubuntu4.27 amd64 [已安装]
apache2/bionic-updates,bionic-security,now 2.4.29-1ubuntu4.27 amd64 [已安装]
apache2-data/bionic-updates,bionic-updates,bionic-security,bionic-security,now 2.4.29-1ubuntu4.27 all [已安装]
apache2-utils/bionic-updates,bionic-security,now 2.4.29-1ubuntu4.27 amd64 [已安装]
apg/bionic,now 2.2.3.dfsg.1-5 amd64 [已安装，自动]
apparmor/bionic-updates,bionic-security,now 2.12-4ubuntu5.3 amd64 [已安装，自动]
app-install-data-partner/bionic,bionic,now 16.04 all [已安装，自动]
apport/bionic-updates,bionic-updates,bionic-security,bionic-security,now 2.20.9-0ubuntu7.29 all [已安装，自动]
apport-gtk/bionic-updates,bionic-updates,bionic-security,bionic-security,now 2.20.9-0ubuntu7.29 all [已安装，自动]
apport-symptoms/bionic,bionic,now 0.20 all [已安装，自动]
appstream/bionic-updates,now 0.12.0-3ubuntu1 amd64 [已安装，自动]
apt-config-icons/bionic-updates,bionic-updates,now 0.12.0-3ubuntu1 all [已安装，自动]
aptdaemon/bionic-updates,bionic-updates,bionic-security,bionic-security,now 1.1.1+bzr982-0ubuntu19.5 all [已安装，自动]
aptdaemon-data/bionic-updates,bionic-updates,bionic-security,bionic-security,now 1.1.1+bzr982-0ubuntu19.5 all [已安装，自动]
apt/now 1.6.14 amd64 [已安装，可升级至：1.6.17]
apt-transport-https/now 1.6.14 all [已安装，可升级至：1.6.17]
apturl/bionic-updates,now 0.5.2ubuntu14.2 amd64 [已安装，自动]
apturl-common/bionic-updates,now 0.5.2ubuntu14.2 amd64 [已安装，自动]
apt-utils/now 1.6.14 amd64 [已安装，可升级至：1.6.17]
--更多--
```

这行命令序列会执行 apt 命令，将其输出通过管道传给 sort 命令，
然后再将 sort 的输出通过管道传给 more 命令来显示，在显示完一屏信息后暂停。
这样你就可以在继续显示前停下来阅读屏幕上的信息。

如果想更别致一些，那么也可以结合重定向和管道来将输出保存到文件中：

```
$ apt --installed list | sort > apt.list
$ more apt.list
accountsservice/bionic-updates,bionic-security,now 0.6.45-1ubuntu1.3 amd64 [已安装，自动]
acl/bionic,now 2.2.52-3build1 amd64 [已安装，自动]
acpid/bionic,now 1:2.0.28-1ubuntu1 amd64 [已安装，自动]
acpi-support/bionic,now 0.142 amd64 [已安装，自动]
adduser/bionic,bionic,now 3.116ubuntu1 all [已安装，自动]
adium-theme-ubuntu/bionic,bionic,now 0.3.4-0ubuntu4 all [已安装，自动]
adwaita-icon-theme/bionic,bionic,now 3.28.0-1ubuntu1 all [已安装，自动]
aisleriot/bionic,now 1:3.22.5-1 amd64 [已安装，自动]
alsa-base/bionic,bionic,now 1.0.25+dfsg-0ubuntu5 all [已安装，自动]
alsa-utils/bionic,now 1.1.3-1ubuntu1 amd64 [已安装，自动]
amd64-microcode/bionic-updates,bionic-security,now 3.20191021.1+really3.20181128.1~ubuntu0.18.04.1 amd64 [已安装，自动]
anacron/bionic,now 2.3-24 amd64 [已安装，自动]
ant/bionic-updates,bionic-updates,bionic-security,bionic-security,now 1.10.5-3~18.04 all [已安装]
ant-optional/bionic-updates,bionic-updates,bionic-security,bionic-security,now 1.10.5-3~18.04 all [已安装]
apache2-bin/bionic-updates,bionic-security,now 2.4.29-1ubuntu4.27 amd64 [已安装]
apache2/bionic-updates,bionic-security,now 2.4.29-1ubuntu4.27 amd64 [已安装]
apache2-data/bionic-updates,bionic-updates,bionic-security,bionic-security,now 2.4.29-1ubuntu4.27 all [已安装]
apache2-utils/bionic-updates,bionic-security,now 2.4.29-1ubuntu4.27 amd64 [已安装]
apg/bionic,now 2.2.3.dfsg.1-5 amd64 [已安装，自动]
apparmor/bionic-updates,bionic-security,now 2.12-4ubuntu5.3 amd64 [已安装，自动]
app-install-data-partner/bionic,bionic,now 16.04 all [已安装，自动]
apport/bionic-updates,bionic-updates,bionic-security,bionic-security,now 2.20.9-0ubuntu7.29 all [已安装，自动]
apport-gtk/bionic-updates,bionic-updates,bionic-security,bionic-security,now 2.20.9-0ubuntu7.29 all [已安装，自动]
apport-symptoms/bionic,bionic,now 0.20 all [已安装，自动]
appstream/bionic-updates,now 0.12.0-3ubuntu1 amd64 [已安装，自动]
apt-config-icons/bionic-updates,bionic-updates,now 0.12.0-3ubuntu1 all [已安装，自动]
aptdaemon/bionic-updates,bionic-updates,bionic-security,bionic-security,now 1.1.1+bzr982-0ubuntu19.5 all [已安装，自动]
aptdaemon-data/bionic-updates,bionic-updates,bionic-security,bionic-security,now 1.1.1+bzr982-0ubuntu19.5 all [已安装，自动]
apt/now 1.6.14 amd64 [已安装，可升级至：1.6.17]
apt-transport-https/now 1.6.14 all [已安装，可升级至：1.6.17]
apturl/bionic-updates,now 0.5.2ubuntu14.2 amd64 [已安装，自动]
apturl-common/bionic-updates,now 0.5.2ubuntu14.2 amd64 [已安装，自动]
apt-utils/now 1.6.14 amd64 [已安装，可升级至：1.6.17]
--更多--
```

不出所料，apt.list 文件中的数据现在已经排好序了。

管道最常见的用法之一是将命令产生的大量输出传送给 more 命令。对 ls 命令来说，这种用法尤为常见

```
总用量 3611596
drwxrwxr-x  94 hexu hexu        12288 8月   7 11:04 .
drwxr-xr-x   3 root root         4096 8月   6 14:27 ..
drwxrwxr-x   3 hexu hexu         4096 4月   8 16:00 a
-rw-rw-r--   1 hexu hexu            0 8月   6 11:24 a.c
drwxrwxr-x  32 hexu hexu         4096 5月  27 18:14 anaconda3
drwxr-xr-x  15 hexu hexu         4096 8月   7 10:33 apollo
drwxrwxr-x   3 hexu hexu         4096 7月   3 18:55 app
-rw-------   1 hexu hexu        26736 8月   7 11:04 .bash_history
-rw-r--r--   1 hexu hexu          220 4月  15  2022 .bash_logout
-rw-r--r--   1 hexu hexu         5220 7月   3 18:57 .bashrc
drwxrwxr-x   4 hexu hexu         4096 1月  24  2024 .bluefish
drwx------  42 hexu hexu         4096 7月  29 15:16 .cache
drwxr-xr-x   2 hexu hexu         4096 12月 22  2023 .cgdb
drwxrwxr-x   3 hexu hexu         4096 8月   8  2023 .cmake
drwxr-xr-x  11 hexu hexu         4096 12月 26  2022 Computer Graphics Using OpenGL (3rd Edition) Source Code
drwxrwxr-x   2 hexu hexu         4096 12月 12  2023 .conda
-rw-rw-r--   1 hexu hexu          279 6月  11 10:38 .condarc
drwx------  45 hexu hexu         4096 8月   7 14:20 .config
drwxrwxr-x   2 hexu hexu         4096 9月  15  2023 corefile
drwxrwxr-x   2 hexu hexu         4096 9月   6  2023 corfile
drwxrwxr-x   5 hexu hexu         4096 8月  18  2023 data
drwx------   3 root root         4096 8月   4  2022 .dbus
drwx------   4 hexu hexu         4096 10月 28  2022 .ddd
drwxr-xr-x  10 root root         4096 2月  15  2023 .debug
drwx------   3 hexu docker       4096 2月   2  2023 .docker
drwxrwxr-x   2 hexu hexu         4096 3月  28  2023 docker_test
drwxrwxr-x   3 hexu hexu         4096 7月  25 11:18 .dotnet
-rw-r--r--   1 hexu hexu         8980 4月  15  2022 examples.desktop
drwx------   3 hexu hexu         4096 7月  26 15:40 .gconf
drwxr-xr-x  24 hexu hexu         4096 5月  16  2023 .gimp-2.8
drwxr-xr-x 157 hexu hexu        12288 8月   2 18:22 git
-rw-r--r--   1 hexu hexu          221 1月  12  2024 .gitconfig
--更多--
```

ls -l 命令会产生目录中所有文件的长列表。对包含大量文件的目录来说，这个列表会相当长。
将输出通过管道传给 more 命令，可以强制分屏显示 ls 的输出列表。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 11.6 管道

