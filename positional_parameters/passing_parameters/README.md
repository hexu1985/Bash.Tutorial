### 传递参数

向 shell 脚本传递数据的最基本方法是使用命令行参数。
命令行参数允许运行脚本时在命令行中添加数据：

```bash
$ ./addem 10 30
```

本例向脚本 addem 传递了两个命令行参数（10 和 30）。脚本会通过特殊的变量来处理命令行参数。

**读取参数**

bash shell 会将所有的命令行参数都指派给称作位置参数（positional parameter）的特殊变量。
这也包括 shell 脚本名称。位置变量①的名称都是标准数字：
`$0` 对应脚本名，`$1` 对应第一个命令行参数，`$2` 对应第二个命令行参数，以此类推，直到`$9`。

下面是在 shell 脚本中使用单个命令行参数的简单例子：

```bash
#!/bin/bash
# using one command line parameter

factorial=1
for ((number = 1; number <= $1; number++))
do
	factorial=$[ $factorial * $number ]
done
echo The factorial of $1 is $factorial
```

执行脚本，输出结果如下所示：

```bash
$ ./01-command-line-parameters 5
The factorial of 5 is 120
```

在 shell 脚本中，可以像使用其他变量一样使用$1 变量。shell 脚本会自动将命令行参数的值
分配给位置变量，无须做任何特殊处理。

如果需要输入更多的命令行参数，则参数之间必须用空格分开。shell 会将其分配给对应的位置变量：

```bash
#!/bin/bash
# testing two command line parameters
#
total=$[ $1 * $2 ]
echo The first parameter is $1.
echo The second parameter is $2.
echo The total value is $total.
```

执行脚本，输出结果如下所示：

```bash
$ ./02-testing-two-command-line-parameters 2 5
The first parameter is 2.
The second parameter is 5.
The total value is 10.
```

在上面的例子中，用到的命令行参数都是数值。你也可以在命令行中用文本字符串作为参数：

```bash
#!/bin/bash
# testing string parameters
#
echo Hello $1, glad to meet you.
exit
```

执行脚本，输出结果如下所示：

```bash
$ ./03-testing-string-parameters world
Hello world, glad to meet you.
```

shell 将作为命令行参数的字符串值传给了脚本。但如果碰到含有空格的字符串，
则会出现问题：

```bash
$ ./03-testing-string-parameters big world
Hello big, glad to meet you.
```

记住，参数之间是以空格分隔的，所以 shell 会将字符串包含的空格视为两个参数的分隔符。
要想在参数值中加入空格，必须使用引号（单引号或双引号均可）。

```bash
$ ./03-testing-string-parameters 'big world'
Hello big world, glad to meet you.
$ ./03-testing-string-parameters "big world"
Hello big world, glad to meet you.
```

如果脚本需要的命令行参数不止 9 个，则仍可以继续加入更多的参数，但是需要稍微修改一下位置变量名。
在第 9 个位置变量之后，必须在变量名两侧加上花括号，比如${10}。来看一个例子：

```bash
#!/bin/bash
# handling lots of parameters
#
total=$[ ${10} * ${11} ]
echo The tenth parameter is ${10}
echo The eleventh parameter is ${11}
echo The total is $total
```

执行脚本，输出结果如下所示：

```bash
$ ./04-handling-lots-of-parameters 1 2 3 4 5 6 7 8 9 10 11 12
The tenth parameter is 10
The eleventh parameter is 11
The total is 110
```

这样你就可以根据需要向脚本中添加任意多的命令行参数了。

**读取脚本名**

可以使用位置变量 `$0` 获取在命令行中运行的 shell 脚本名。
这在编写包含多种功能或生成日志消息的工具时非常方便。

```bash
#!/bin/bash
# Handling the $0 command-line parameter
#
echo This script name is $0.
exit
```

执行脚本，输出结果如下所示：

```bash
$ bash 05-testing-0-parameter
This script name is 05-testing-0-parameter.
```

但这里有一个潜在的问题。如果使用另一个命令来运行 shell 脚本，则命令名会和脚本名混在一起，
出现在位置变量 `$0` 中：

```bash
$ ./05-testing-0-parameter
This script name is ./05-testing-0-parameter.
```

这还不是唯一的问题。如果运行脚本时使用的是绝对路径，那么位置变量 `$0` 就会包含整个路径：

```bash
$ $HOME/git/Bash.Tutorial/handling_user_input/passing_parameters/examples/05-testing-0-parameter
This script name is /home/hexu/git/Bash.Tutorial/handling_user_input/passing_parameters/examples/05-testing-0-parameter.
```

如果你编写的脚本中只打算使用脚本名，那就得做点儿额外工作，剥离脚本的运行路径。
好在有个方便的小命令可以帮到我们。basename 命令可以返回不包含路径的脚本名：

```bash
#!/bin/bash
# Using basename with the $0 command-line parameter
#
name=$(basename $0)
#
echo This script name is $name.
exit
```

执行脚本，输出结果如下所示：

```bash
$ ./06-using-basename-with-zero-parameter 
This script name is 06-using-basename-with-zero-parameter.
```

**参数测试**

在 shell 脚本中使用命令行参数时要当心。如果运行脚本时没有指定所需的参数，则可能会出问题：

```bash
$ ./01-command-line-parameters
./01-command-line-parameters: 行 5: ((: number <= : 语法错误：需要操作数（错误记号是 "<= "）
The factorial of is 1
```

当脚本认为位置变量中应该有数据，而实际上根本没有的时候，脚本很可能会产生错误消息。
这种编写脚本的方法并不可取。在使用位置变量之前一定要检查是否为空：

```bash
#!/bin/bash
# testing parameters before use

if [ -n "$1" ]
then
	echo Hello $1, glad to meet you.
else
	echo "Sorry, you did not identify yourself."
fi
```

上面这个例子使用了-n 测试来检查命令行参数$1 中是否为空。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 14.1 传递参数

