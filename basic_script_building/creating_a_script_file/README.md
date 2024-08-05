### 创建 shell 脚本文件

要将 shell 命令放到文本文件中，首先要用文本编辑器创建一个文件，然后在其中输入命令。

在创建 shell 脚本文件时，必须在文件的第一行指定要使用的 shell，格式如下：

```bash
#!/bin/bash
```

在普通的 shell 脚本中，#用作注释行。shell 并不会处理 shell 脚本中的注释行。
然而，shell 脚本文件的第一行是个例外，#后面的!（惊叹号）会告诉 shell 用哪个 shell 来运行脚本。

在指明了 shell 之后，可以在文件的各行输入命令，每行末尾加一个换行符。
之前提到过，注释可用#添加，如下所示：

```bash
#!/bin/bash
# This script displays the date and who's logged on
date
who
```

这就是脚本的所有内容了。

运行 Shell 脚本有两种方法：

- 作为可执行程序
- 作为解释器参数

如果是作为可执行程序运行脚本，下一步是通过 chmod 命令赋予文件属主执行文件的权限，并执行脚本：

```
$ chmod +x 01-date-who
$ ./01-date-who
2024年 08月 05日 星期一 16:47:11 CST
hexu     :1           2024-07-25 12:04 (:1)
```

注意，一定要写成 ./01-date-who，而不是 01-date-who，运行其它二进制的程序也一样，直接写 01-date-who，
linux 系统会去 PATH 里寻找有没有叫 01-date-who 的，而只有 /bin, /sbin, /usr/bin，/usr/sbin 等在 PATH 里，
你的当前目录通常不在 PATH 里，所以写成 01-date-who 是会找不到命令的，要用 ./01-date-who 告诉系统说，就在当前目录找。

如果是作为解释器参数的方式，则只需直接运行解释器，其参数就是 shell 脚本的文件名，如：

```
$ bash 01-date-who
2024年 08月 05日 星期一 16:47:11 CST
hexu     :1           2024-07-25 12:04 (:1)
```

这种方式运行的脚本，不需要在第一行指定解释器信息，写了也没用。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 11.2 创建 shell 脚本文件
- 《Linux Shell脚本攻略 第3版》: 1.2 在终端中显示输出
