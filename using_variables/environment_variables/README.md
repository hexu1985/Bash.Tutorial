### 环境变量

shell 维护着一组用于记录特定的系统信息的环境变量，比如系统名称、已登录系统的用户名、
用户的系统 ID（也称为 UID）、用户的默认主目录以及 shell 查找程序的搜索路径。
你可以用 set 命令显示一份完整的当前环境变量列表：

```shell
$ set
BASH=/bin/bash
BASHOPTS=checkwinsize:cmdhist:complete_fullquote:expand_aliases:extglob:extquote:force_fignore:histappend:interactive_comments:progcomp:promptvars:sourcepath
...
HISTFILE=/home/hexu/.bash_history
HISTFILESIZE=2000
HISTSIZE=1000
HOME=/home/hexu
HOSTNAME=hexu-Lenovo-Legion-Y7000P2020H
HOSTTYPE=x86_64
IFS=$' \t\n'
...
```

在脚本中，可以在环境变量名之前加上$来引用这些环境变量，用法如下：

```shell
#!/bin/bash

# display user information from the system.

echo "User info for userid: $USER"
echo UID: $UID
echo HOME: $HOME
```

环境变量$USER、$UID 和$HOME 用来显示已登录用户的相关信息。脚本输出如下：

```shell
$ chmod u+x test2
$ ./test2
User info for userid: hexu
UID: 1000
HOME: /home/hexu
```


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 11.4.1 环境变量

