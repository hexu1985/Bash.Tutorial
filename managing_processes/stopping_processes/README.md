### 结束进程

在 Linux 中有多个命令可以向运行中的进程发出进程信号：kill 和 pkill。

**kill命令**

kill 命令可以通过 PID 向进程发送信号。
在默认情况下，kill 命令会向命令行中列出的所有 PID 发送 TERM 信号。

kill命令的语法

```
kill [-s <信息名称或编号>][程序]　或　kill [-l <信息编号>]
```

参数说明：

- -l <信息编号> 　若不加<信息编号>选项，则 -l 参数会列出全部的信息名称。
- -s <信息名称或编号> 　指定要送出的信息。
- [程序] 　[程序]可以是程序的PID或是PGID，也可以是工作编号。

使用 kill -l 命令列出所有可用信号。

最常用的信号是：

1 (HUP)：重新加载进程。
9 (KILL)：杀死一个进程。
15 (TERM)：正常停止一个进程。


常用的kill命令举例：

杀死进程
```shell
$ kill 12345
```

强制杀死进程
```shell
$ kill -KILL 123456
```

发送SIGHUP信号，可以使用一下信号
```shell
$ kill -HUP pid
```

彻底杀死进程
```shell
$ kill -9 123456
```

显示信号
```
$ kill -l
 1) SIGHUP	 2) SIGINT	 3) SIGQUIT	 4) SIGILL	 5) SIGTRAP
 6) SIGABRT	 7) SIGBUS	 8) SIGFPE	 9) SIGKILL	10) SIGUSR1
11) SIGSEGV	12) SIGUSR2	13) SIGPIPE	14) SIGALRM	15) SIGTERM
16) SIGSTKFLT	17) SIGCHLD	18) SIGCONT	19) SIGSTOP	20) SIGTSTP
21) SIGTTIN	22) SIGTTOU	23) SIGURG	24) SIGXCPU	25) SIGXFSZ
26) SIGVTALRM	27) SIGPROF	28) SIGWINCH	29) SIGIO	30) SIGPWR
31) SIGSYS	34) SIGRTMIN	35) SIGRTMIN+1	36) SIGRTMIN+2	37) SIGRTMIN+3
38) SIGRTMIN+4	39) SIGRTMIN+5	40) SIGRTMIN+6	41) SIGRTMIN+7	42) SIGRTMIN+8
43) SIGRTMIN+9	44) SIGRTMIN+10	45) SIGRTMIN+11	46) SIGRTMIN+12	47) SIGRTMIN+13
48) SIGRTMIN+14	49) SIGRTMIN+15	50) SIGRTMAX-14	51) SIGRTMAX-13	52) SIGRTMAX-12
53) SIGRTMAX-11	54) SIGRTMAX-10	55) SIGRTMAX-9	56) SIGRTMAX-8	57) SIGRTMAX-7
58) SIGRTMAX-6	59) SIGRTMAX-5	60) SIGRTMAX-4	61) SIGRTMAX-3	62) SIGRTMAX-2
63) SIGRTMAX-1	64) SIGRTMAX
```

---

**pkill命令**

pkill 命令可以使用程序名代替 PID 来终止进程，这就方便多了。
除此之外，pkill 命令也允许使用通配符，当系统出问题时，这是一个非常有用的工具：

```shell
$ pkill http*
$
```

该命令将“杀死”所有名称以 http 起始的进程，比如 Apahce Web Server 的 httpd 服务。

pkill命令的语法
```shell
$ pkill [选项]  name
```

pkill命令的一些常用的选项和参数:

- -l, --list：显示所有可用的信号列表。示例：pkill -l。
- -e, --exact：精确匹配进程名称，只终止完全匹配的进程。示例：pkill -e <进程名>。
- -f, --full：匹配进程名及其参数，可用于定位带有特定参数的进程。示例：pkill -f <进程参数>。
- -u, --euid：根据进程的有效用户ID（EUID）来定位和终止进程。示例：pkill -u <用户ID>。
- -g, --pgroup：根据进程组ID来定位和终止进程。示例：pkill -g <进程组ID>。
- -t, --terminal：根据终端ID来定位和终止进程。示例：pkill -t <终端ID>。
- -c, --count：显示匹配到的进程数量，而不执行终止操作。示例：pkill -c <进程名>。
- -x, --exact-match：仅匹配完全相同的进程名，不会匹配到子进程。示例：pkill -x <进程名>。
- -n, --newest：终止最新的一个匹配进程。示例：pkill -n <进程名>。


### 参考资料:
- 《Linux Command Line and Shell Scripting Bible》: Chapter 13: More bash Shell Commands
- [揭开pkill的秘密：在Linux中杀死进程的完整指南](https://zhuanlan.zhihu.com/p/652147031)
- [Linux kill命令](https://www.runoob.com/linux/linux-comm-kill.html)
- [Linux pkill 命令](https://www.runoob.com/linux/linux-comm-pkill.html)
