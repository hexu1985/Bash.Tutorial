### 什么是环境变量

bash shell 使用环境变量来存储 shell 会话和工作环境的相关信息（这也是被称作环境变量的原因）。
环境变量允许在内存中存储数据，以便 shell 中运行的程序或脚本能够轻松访问到这些数据。
这也是存储持久数据的一种简便方法。

bash shell 中有两种环境变量。
- 全局变量
- 局部变量

全局环境变量对于 shell 会话和所有生成的子 shell 都是可见的。
局部环境变量则只对创建它的 shell 可见。
如果程序创建的子 shell 需要获取父 shell 信息，那么全局环境变量就能派上用场了。

Linux 系统在你启动 bash 会话时就设置好了一些全局环境变量。
系统环境变量基本上会使用全大写字母，以区别于用户自定义的环境变量。

可以使用 env 命令或 printenv 命令来查看全局变量：

```
$ printenv
[...]
USER=hexu
[...]
PWD=/home/hexu
HOME=/home/hexu
[...]
TERM=xterm-256color
SHELL=/bin/bash
[...]
HISTSIZE=1000
[...]
$
```

Linux 系统为 bash shell 设置的全局环境变量数目众多，其中有很多是在登录过程中设置的，另外，你的登录方式也会影响所设置的环境变量。

要显示个别环境变量的值，可以使用 printenv 命令，但不要使用 env 命令：

```
$ printenv HOME
/home/hexu
$
$ env HOME
env: "HOME": 没有那个文件或目录
$
```

也可以使用 echo 命令显示变量的值。在引用某个环境变量时，必须在该变量名前加上美元符号（`$`）：

```
$ echo $HOME
/home/hexu
$
```

使用 echo 命令时，在变量名前加上$可不仅仅是能够显示变量当前的值，它还能让变量作为其他命令的参数：

```
$ ls $HOME
Desktop Music NetworkManager.conf Templates
Doc.tar Music.tar OldDocuments test_file
Documents my_file Pictures test_one
Downloads my_scrapt Public test_two
hlink_test_one my_script really_ridiculously_long_file_name Videos
log_file my_scrypt slink_test_file
$
```

如前所述，全局环境变量可用于进程的子 shell：

```
$ bash
$ ps -f
UID        PID  PPID  C STIME TTY          TIME CMD
hexu     10889  3433  0 7月26 pts/4   00:00:10 bash
hexu     15940 10889  2 14:46 pts/4    00:00:00 bash
hexu     15984 15940  0 14:46 pts/4    00:00:00 ps -f
$
$ echo $HOME
/home/hexu
$ exit
$
```

在这个例子中，用 bash 命令生成一个子 shell 后，显示了 HOME 环境变量的当前值。
这个值和父 shell 中的值一模一样，都是/home/hexu。

局部环境变量只能在定义它的进程中可见。尽管是局部的，但是局部环境变量的重要性丝毫不输全局环境变量。
事实上，Linux 系统默认也定义了标准的局部环境变量。
不过，你也可以定义自己的局部变量，如你所料，这些变量被称为用户自定义局部变量。

```
$ set
BASH=/bin/bash
BASHOPTS=checkwinsize:cmdhist:complete_fullquote:expand_aliases:extglob:extquote:force_fignore:histappend:interactive_comments:progcomp:promptvars:sourcepath
BASH_ALIASES=()
BASH_ARGC=()
BASH_ARGV=()
BASH_CMDS=()
BASH_COMPLETION_VERSINFO=([0]="2" [1]="8")
BASH_LINENO=()
BASH_REMATCH=()
BASH_SOURCE=()
...
```

可以看到，所有通过 env 命令或 printenv 命令能看到的全局环境变量都出现在了 set 命令的输出中。
除此之外，还包括局部环境变量、用户自定义变量以及局部 shell 函数。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 6.1 什么是环境变量
