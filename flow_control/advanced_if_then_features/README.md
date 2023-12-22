### if-then 的高级特性

bash shell 还提供了 3 个可在 if-then 语句中使用的高级特性。
- 在子 shell 中执行命令的单括号。
- 用于数学表达式的双括号。
- 用于高级字符串处理功能的双方括号。

**使用单括号**

单括号允许在 if 语句中使用子 shell。单括号形式的 test 命令格式如下：

```
(command)
```

在 bash shell 执行 command 之前，会先创建一个子 shell，然后在其中执行命令。
如果命令成功结束，则退出状态码会被设为 0，then 部分的命令就会被执行。
如果命令的退出状态码不为 0，则不执行 then 部分的命令。

来看一个使用子 shell 进行测试的例子：

```bash
$ cat SingleParentheses.sh
#!/bin/bash
# Testing a single parentheses condition
#
echo $BASH_SUBSHELL
#
if (echo $BASH_SUBSHELL)
then
    echo "The subshell command operated successfully."
#
else
    echo "The subshell command was NOT successful."
#
fi
$
$ ./SingleParentheses.sh
01
The subshell command operated successfully.
$ 
```

对脚本略作修改，来看一个在子 shell 中执行失败的例子：

```bash
$ cat SingleParentheses2.sh
#!/bin/bash
# Testing a single parentheses condition
#
#echo $BASH_SUBSHELL
#
if (cat /etc/PASSWORD)
then
    echo "The subshell command operated successfully."
#
else
    echo "The subshell command was NOT successful."
#
fi
$
$ ./SingleParentheses.sh
cat: /etc/PASSWORD: No such file or directory
The subshell command was NOT successful.
$ 
```

**使用双括号**

双括号命令允许在比较过程中使用高级数学表达式。双括号命令的格式如下：

```
(( expression ))
```

expression 可以是任意的数学赋值或比较表达式。除了 test 命令使用的标准数学运算符，
下表列出了双括号中可用的其他运算符。

| 符号  | 描述       |
| ----- | ---------- |
| val++ | 后增       |
| val-- | 后减       |
| ++val | 先增       |
| --val | 先减       |
| !     | 逻辑求反   |
| ~     | 位求反     |
| **    | 幂运算     |
| <<    | 左位移     |
| >>    | 右位移     |
| &     | 位布尔 AND |
| `|`   | 位布尔 OR  |
| &&    | 逻辑 AND   |
| `||`  | 逻辑 OR    |

双括号命令既可以在 if 语句中使用，也可以在脚本中的普通命令里用来赋值：

```bash
$ cat DoubleParentheses.sh
#!/bin/bash
# Testing a double parentheses command
#
val1=10
#
if (( $val1 ** 2 > 90 ))
then
    (( val2 = $val1 ** 2 ))
    echo "The square of $val1 is $val2,"
    echo "which is greater than 90."
#
fi
$
$ ./DoubleParentheses.sh
The square of 10 is 100,
which is greater than 90.
$
```

注意，双括号中表达式的大于号不用转义。


**使用双方括号**

双方括号命令提供了针对字符串比较的高级特性。双方括号的格式如下：

```
[[ expression ]]
```

expression 可以使用 test 命令中的标准字符串比较。
除此之外，它还提供了 test 命令所不具备的另一个特性——模式匹配。

在进行模式匹配时，可以定义通配符或正则表达式来匹配字符串：

我们先给出一个通配符匹配字符串的例子：

```bash
$ cat DoubleBrackets.sh
#!/bin/bash
# Using double brackets for pattern matching
#
#
if [[ $BASH_VERSION == 5.* ]]
then
    echo "You are using the Bash Shell version 5 series."
fi
$
$ ./DoubleBrackets.sh
You are using the Bash Shell version 5 series.
$
```

注意，这里使用了==运算符，顺便回顾一下通配符
- 问号（?）代表任意单个字符；
- 星号（*）代表零个或多个字符。

然后我们再给出一个正则表达式来匹配字符串的例子：

```bash
#!/bin/bash

# test-integer2: evaluate the value of an integer.

INT=-5

if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
	if [ "$INT" -eq 0 ]; then
		echo "INT is zero."
	else      
		if [ "$INT" -lt 0 ]; then
			echo "INT is negative."
		else
			echo "INT is positive."
		fi
		if [ $((INT % 2)) -eq 0 ]; then
			echo "INT is even."
		else
			echo "INT is odd."
		fi
	fi
else
	echo "INT is not an integer." >&2
	exit 1
fi
```

注意，这里使用了=~运算符：

```
string1 =~ regex
```

如果string1与扩展的正则表达式regex匹配，则返回true。


### 参考资料:
- 《The Linux Command Line》: 27. Flow Control: Branching with if - Control Operators: Another Way to Branch
- 《Linux Command Line and Shell Scripting Bible》: Chapter 12: Using Structured Commands - Considering Compound Testing

