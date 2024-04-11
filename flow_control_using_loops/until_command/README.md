### until 命令

while命令退出状态不为0时终止循环，而until命令则刚好相反。除此之外，
until命令与while命令很相似。until循环会在接收到为0的退出状态时终止。

until 命令的格式如下：

```bash
until test commands
do
 other commands
done
```

与 while 命令类似，你可以在 until 命令语句中放入多个 test command。最后一个命令
的退出状态码决定了 bash shell 是否执行已定义的 other commands。


来看一个 until 命令的例子：

```bash
#!/bin/bash
# using the until command

var1=100

until [ $var1 -eq 0 ]
do
	echo $var1
    var1=$[ $var1 - 25 ]
done
```

执行脚本，输出结果如下所示：

```bash
$ ./test12
100
75
50
25
$
```

本例通过测试 var1 变量来决定 until 循环何时停止。只要该变量的值等于 0，until 命
令就会停止循环。同 while 命令一样，在 until 命令中使用多个测试命令时也要注意：

再看一个 until 命令的例子：

```bash
#!/bin/bash
# using until command
var1=100

until echo $var1
	[ $var1 -eq 0 ]
do
	echo Inside the loop: $var1
	var1=$[ $var1 - 25 ]
done
```

执行脚本，输出结果如下所示：

```bash
$ ./test13
100
Inside the loop: 100
75
Inside the loop: 75
50
Inside the loop: 50
25
Inside the loop: 25
0
$
```

shell 会执行指定的多个测试命令，仅当最后一个命令成立时才停止。

### 参考资料:
- 《The Linux Command Line》: 29. Flow Control: Looping with while/until
- 《Linux Command Line and Shell Scripting Bible》: Chapter 13: More Structured Commands
