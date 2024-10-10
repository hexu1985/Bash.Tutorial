### 使用source命令加载变量

存储数据（尤其是配置选项）的有用方法是将这些变量定义逐条记录到文本文件中。
这很容易编辑，也便于 shell 脚本读取。经常用户甚至可能不知道文件的使用方式。
例如，基于 Red Hat 的 Linux 发行版中，有一个通用的 `/etc/sysconfig/network` 文件，
其中包含基本的 network 配置，它被很多系统脚本读取。
然后是一组特定于程序的文件，例如 `/etc/sysconfig/ntpd`，其中包含网络时间协议（NTP协议）守护进程的特定选项。
考虑 `/etc/init.d/ntpd` 开头，它在系统引导时运行。它会 source 这两个文件，然后使用它们中的变量值：

```
# Source function library.
. /etc/init.d/functions

# Source networking configuration.
. /etc/sysconfig/network

if [ -f /etc/sysconfig/ntpd ];then
    . /etc/sysconfig/ntpd
fi
```

配置文件本身类似于以下示例。这些文件很容易被系统管理员或者软件编辑，并且在系统引导期间需要这些文件时，其中的变量包含了所有相关选项。

```
root@redhat# cat /etc/sysconfig/network
NETWORKING_IPV6=no
HOSTNAME=redhat.example.com
NETWORKING=yes
GATEWAY=192.168.32.1
root@redhat# cat /etc/sysconfig/ntpd
# Drop root to id ‘ntp:ntp’ by default.
OPTIONS=”-u ntp:ntp -p /var/run/ntpd.pid”

# Set to ‘yes’ to sync hw clock after successful ntpdate
SYNC_HWCLOCK=no

# Additional options for ntpdate
NTPDATE_OPTIONS=””
root@redhat#
```

然后，`/etc/init.d/ntpd` 脚本使用 `$OPTIONS` 调用 ntpd 二进制文件，
该变量在此处的值为 `-u ntp:ntp -p /var/run/ntpd.pid`。
系统管理员可以编辑文本文件`/etc/init.d/ntpd`，而不必编辑 init 脚本本身。
这对系统管理员来说更容易，并且由于 init 脚本本身不用修改，
所以在发行版将 init 脚本作为系统升级的一部分一起升级时，相关的配置不会丢失。


### 参考资料:
- 《Shell脚本编程诀窍 适用于Linux、Bash等》: 7.5 使用source命令加载变量

