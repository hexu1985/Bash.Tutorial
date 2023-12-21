### 返回码

命令（包括我们编写的脚本和shell函数）在执行完毕后，会向操作系统发送一个值，称之为返回码（“退出状态”）。
这个值是一个0～255的整数，用来指示命令执行成功还是失败。按照惯例，数值0表示执行成功，其他的数值表示执行失败。
shell将变量$?设置为上一次运行命令返回的代码。在下面的例子中可以看到。

```bash
$ ls -d /usr/bin
/usr/bin
$ echo $?
0
$ ls -d /bin/usr
ls: cannot access /bin/usr: No such file or directory
$ echo $?
2
```

**exit命令**

exit命令用于终止脚本并返回命令行。你可能希望脚本在某些情况发生时退出。
传给exit命令的参数是一个从0~255的整数。如前所述，如果程序以0为参数退出，
则表明程序执行成功，参数非0则表示程序执行失败。传给exit命令的参数被保存在shell的变量$?中。

下面举一个简单的例子：

```bash
# Name: bigfiles
# Purpose: Use the find command to find any files in the root 
# partition that have not been modified within the past n (any 
# number within 30 days) days and are larger than 20 blocks 
# (512-byte blocks)

if  [ $# -ne 2 ]
then 
	echo  "Usage: $0 mdays size " 1>&2
	exit 1
fi
if  [ $1 -lt 0 -o $1 -gt 30 ]
then

	echo "mdays is out of range"
	exit 2
fi
if [ $2 -le 20 ]
then
	echo "size is out of range"
	exit 3
fi
find / -xdev -mtime $1 -size +$2 -print
```

当你在命令行中运行该脚本却不带任何参数时，会得到如下结果：

```bash
$ ./bigfiles
Usage: bigfiles mdays size
$ echo $?
1
```

当你在命令行中运行该脚本的参数非法时，会得到如下结果：

```bash
$ ./bigfiles 400 80
mdays is out of range
$ echo $?
2
$ ./bigfiles 25 2
size is out of range
$ echo $?
3
```

直到你在给出正常的参数运行该脚本时，会得到正常的输出，并返回find（因为脚本最后一个命令）的返回码：

```bash
$ ./bigfiles 2 25
(find的输出)
```


**true和false**

shell提供了两个非常简单的内置命令，它们不做任何事情，除了以一个0或1退出状态来终止执行。
“true”命令总是表示执行成功，而“false”命令总是表示执行失败。

例如：

```bash
$ true
$ echo $?
0
$ false
$ echo $?
1
```

我们可以用这两个命令来查看if语句是如何工作的。if语句真正做的事情是评估命令的成功或失败。

```bash
$ if true; then echo "It's true."; fi
It's true.
$ if false; then echo "It's true."; fi
$
```

当在if后面的命令执行成功时，命令echo ”It’s true.”会被执行，而当在if后面的命令执行失败时，
该命令则不执行。如果在if后面有一系列的命令，那么则根据最后一个命令的执行结果进行评估。

```bash
$ if false; true; then echo "It's true."; fi
It's true.
$ if true; false; then echo "It's true."; fi
$
```

### 参考资料:
- 《The Linux Command Line》: 27 Flow Control: Branching with if
- 《UNIX Shells by Example》: Chapter 12: The exit Command and the ? Variable

