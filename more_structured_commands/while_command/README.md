### while 命令

while 命令允许定义一个要测试的命令，只要该命令返回的退出状态码为 0，
就循环执行一组命令。它会在每次迭代开始时测试 test 命令，
如果 test 命令返回非 0 退出状态码，while 命令就会停止执行循环。

while 命令的格式如下：

```bash
while test command
do
    other commands
done
```

while 命令中定义的 test command 与 if-then 语句中的格式一模一样。
你可以使用任何 bash shell 命令，或者用 test command 进行条件测试，比如测试变量值。

while 命令的关键在于所指定的 test command 的退出状态码必须随着循环中执行的命令而改变。
如果退出状态码不发生变化，那 while 循环就成了死循环。

test command 最常见的用法是使用方括号来检查循环命令中用到的 shell 变量值：

```bash
#!/bin/bash
# while command test

var1=10
while [ $var1 -gt 0 ]
do
	echo $var1
	var1=$[ $var1 - 1 ]
done
```

执行脚本，输出结果如下所示：

```bash
$ ./15-while-command-test
10
9
8
7
6
5
4
3
2
1
```

while也可处理标准输入，这让使用while循环处理文件成为可能。

接下来的示例显示用于显示文件的内容。

我们先看看原始文件内容：

```bash
$ cat distros.txt
SUSE	10.2	12/07/2006
Fedora	10	11/25/2008
SUSE	11.0	06/19/2008
Ubuntu	8.04	04/24/2008
Fedora	8	11/08/2007
SUSE	10.3	10/04/2007
Ubuntu	6.10	10/26/2006
Fedora	7	05/31/2007
Ubuntu	7.10	10/18/2007
Ubuntu	7.04	04/19/2007
SUSE	10.1	05/11/2006
Fedora	6	10/24/2006
Fedora	9	05/13/2008
Ubuntu	6.06	06/01/2006
Ubuntu	8.10	10/30/2008
Fedora	5	03/20/2006
```

然后是while脚本：

```bash
#!/bin/bash

# while-read: read lines from a file

while read distro version release; do
	printf "Distro: %s\tVersion: %s\tReleased: %s\n" \
		"$distro" \
		"$version" \
		"$release"
done < distros.txt
```

运行脚本可得到如下输出：

```bash
$ bash while-read
Distro: SUSE	Version: 10.2	Released: 12/07/2006
Distro: Fedora	Version: 10	Released: 11/25/2008
Distro: SUSE	Version: 11.0	Released: 06/19/2008
Distro: Ubuntu	Version: 8.04	Released: 04/24/2008
Distro: Fedora	Version: 8	Released: 11/08/2007
Distro: SUSE	Version: 10.3	Released: 10/04/2007
Distro: Ubuntu	Version: 6.10	Released: 10/26/2006
Distro: Fedora	Version: 7	Released: 05/31/2007
Distro: Ubuntu	Version: 7.10	Released: 10/18/2007
Distro: Ubuntu	Version: 7.04	Released: 04/19/2007
Distro: SUSE	Version: 10.1	Released: 05/11/2006
Distro: Fedora	Version: 6	Released: 10/24/2006
Distro: Fedora	Version: 9	Released: 05/13/2008
Distro: Ubuntu	Version: 6.06	Released: 06/01/2006
Distro: Ubuntu	Version: 8.10	Released: 10/30/2008
Distro: Fedora	Version: 5	Released: 03/20/2006
```

为将一份文件重定向到循环中，我们可在done语句之后添加重定向操作符。
循环使用read命令读取重定向文件中的字段。在到达文件末端之前，退出状态为0。
在读取过文件中的每一行之后，read命令退出，此时退出状态变为非0，循环终止。


将标准输入重定向到循环中也是可以做到的。

还是同样的数据文件，我们这次采用管道+while脚本：

```bash
#!/bin/bash

# while-read2: read lines from a file

sort -k 1,1 -k 2n distros.txt | while read distro version release; do
	printf "Distro: %s\tVersion: %s\tReleased: %s\n" \
		"$distro" \
		"$version" \
		"$release"
done
```

运行脚本可得到如下输出：

```bash
$ bash while-read2
Distro: Fedora	Version: 5	Released: 03/20/2006
Distro: Fedora	Version: 6	Released: 10/24/2006
Distro: Fedora	Version: 7	Released: 05/31/2007
Distro: Fedora	Version: 8	Released: 11/08/2007
Distro: Fedora	Version: 9	Released: 05/13/2008
Distro: Fedora	Version: 10	Released: 11/25/2008
Distro: SUSE	Version: 10.1	Released: 05/11/2006
Distro: SUSE	Version: 10.2	Released: 12/07/2006
Distro: SUSE	Version: 10.3	Released: 10/04/2007
Distro: SUSE	Version: 11.0	Released: 06/19/2008
Distro: Ubuntu	Version: 6.06	Released: 06/01/2006
Distro: Ubuntu	Version: 6.10	Released: 10/26/2006
Distro: Ubuntu	Version: 7.04	Released: 04/19/2007
Distro: Ubuntu	Version: 7.10	Released: 10/18/2007
Distro: Ubuntu	Version: 8.04	Released: 04/24/2008
Distro: Ubuntu	Version: 8.10	Released: 10/30/2008
```

此脚本获取sort命令的输出并显示文本流。但需要留意的是，因为管道是在
子shell中进行循环操作。当循环终止时，循环内部新建的变量或者是对变量
的赋值效果都会丢失。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 13.3 while 命令 
- 《Linux命令行大全 第2版》: 29.1 循环
