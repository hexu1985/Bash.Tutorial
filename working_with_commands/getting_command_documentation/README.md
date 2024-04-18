### 获得命令文档

我们可以通过几个命令查看每一类命令的可用文档。
- man——显示程序的手册页
- whatis——显示命令的简要描述

**man命令**

大多数供命令行使用的可执行文件，提供一个称之为manual或者是man page的正
式文档。该文档可以用一种称为man的特殊分页程序来查看，用法如下。

```
man program
```

这里的program是需要查看的命令名称。

手册文档在格式上会有所不同，但是通常都包括标题、命令句法的摘要、命令用
途的描述、命令选项列表以及每个命令选项的描述。但是，手册文档通常不包括
实例，更多的是作为一个参考使用，而不是教程。例如，尝试查看 ls 命令的手
册文档。

```bash
$ man ls
```

在大多数Linux系统中，man命令调用less命令来显示手册文档。所以，当显示手
册文档时，你熟悉的所有less命令都能奏效。

man命令显示的“手册文档”被分成多个部分（section），它不仅包括用户命令，
也包括系统管理命令、程序接口、文件格式等。

- 1：可执行程序或 shell 命令 - commands
- 2：系统调用 (内核提供的功能) - system calls
- 3：库调用 (程序库中的函数) - library calls
- 4：特殊文件 (通常在/dev 中找到) - special files
- 5：文件格式和规范 - file formats and convertions
- 6：游戏 - games for linux
- 7：杂项 (包括宏包和惯例 例如 man(7)、groff(7)；tcp,udp，ASCII）- macro packages and conventions
- 8：系统管理命令 (通常仅适用于root用户) - system management commands

有时候我们需要查看手册文档的具体部分，以查找我们需要的信息。当我们所查
找的一个文件格式同时也是一个命令名的时候，这一点就尤为重要了。如果没有
指明部分编号（section number），通常我们会获得第一次匹配的实例（它可能
会出现在第一部分）。为了指明具体在哪个部分，我们可以这样使用man命令。

```
man section search_term
```

例如：

```bash
$ man 5 passwd
```

该命令将会显示文件/etc/passwd的文件格式描述手册。


**whatis命令**

whatis程序显示匹配具体关键字的手册页的名字和一行描述。

```bash
$ whatis ls
ls (1) - list directory contents
```

### 参考资料:
- 《The Linux Command Line: A Complete Introduction》: Chapter 5: Working with Commands
