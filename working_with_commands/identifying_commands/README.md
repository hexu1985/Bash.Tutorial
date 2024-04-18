### 识别命令

Linux提供了几个命令来识别命令类型。

- type——显示命令的类型
- which——显示可执行程序的位置
- whereis——定位二进制文件、源代码文件和手册文件的位置

**type命令**

type命令是一个shell内置命令，可根据指定的命令名显示shell将要执行的命令类型。
格式如下。

```
type command
```

这里的command是想要查看的命令名。一些实例如下所示。

```bash
$ type type
type is a shell builtin
$ type ls
ls is aliased to 'ls --color=auto'
$ type cp
cp is /bin/cp
```

这里将看到3种不同命令的查看结果。需要注意的是，ls命令（来自Ubuntu系统）
实际上是带有--color=auto选项的ls命令的别名。现在我们知道了ls命令的输出为什
么会有颜色了。


**which命令**

有时候，系统中可能会安装了一个可执行程序的多个版本。这种现象虽然在桌面
系统中不常见，但是在大型服务器中却是很常见的。使用which命令可以确定一
个给定可执行文件的准确位置。

```bash
$ which ls
/bin/ls
```

which命令只适用于可执行程序，而不适用于内置命令和命令别名（真正可执行
程序的替代物）。试图在shell内置命令（例如，cd）中使用which命令时，要么
没有响应，要么得到一条错误信息。


**whereis命令**

不只可以查找命令，其他文件类型都可以（man中说只能查命令、源文件和man文件，实际测试可以查大多数文件）。
在$PATH路径基础上增加了一些系统目录的查找，查找范围比which稍大，查找速度快。
可以通过 -b 选项，限定只搜索二进制文件。

```bash
$ whereis ls
ls: /bin/ls /usr/share/man/man1/ls.1.gz
```

### 参考资料:
- 《The Linux Command Line: A Complete Introduction》: Chapter 5: Working with Commands
