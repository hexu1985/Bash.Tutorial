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

```bash
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
```

运行这个脚本时，会产生如下输出：

```
$ ./SingleParentheses.sh
0
1
The subshell command operated successfully.
$
```

当脚本第一次（在 if 语句之前）执行 `echo $BASH_SUBSHELL` 命令时，是在当前 shell 中完成的。
该命令会输出 0，表明没有使用子 shell。在 if 语句内，脚本在子 shell 中执行 `echo $BASH_SUBSHELL` 命令，
该命令会输出 1，表明使用了子 shell。子 shell 操作成功结束，接下来是执行 then 部分的命令。

对脚本略作修改，来看一个在子 shell 中执行失败的例子：

```bash
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
```

运行这个脚本时，会产生如下输出：

```
$ ./SingleParentheses2.sh
cat: /etc/PASSWORD: 没有那个文件或目录
The subshell command was NOT successful.
$
```

因为子 shell 中的命令指定了错误的文件名，所以退出状态码被设为非 0。接下来则执行 else 部分的命令。


**使用双括号**

双括号命令允许在比较过程中使用高级数学表达式。test 命令在进行比较的时候只能使用简单的算术操作。
双括号命令提供了更多的数学符号，这些符号对有过其他编程语言经验的程序员而言并不陌生。
双括号命令的格式如下：

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
```

运行这个脚本时，会产生如下输出：

```
$ ./29-using-double-paranthesis
The square of 10 is 100,
which is greater than 90.
$
```

注意，双括号中表达式的大于号不用转义。这是双括号命令又一个优越性的体现。


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
#!/bin/bash
# Using double brackets for pattern matching
#
#
echo "BASH_VERSION: $BASH_VERSION"
if [[ $BASH_VERSION == 4.* ]]
then
    echo "You are using the Bash Shell version 4 series."
fi
```

运行这个脚本时，会产生如下输出：

```
$ ./DoubleBrackets.sh
BASH_VERSION: 4.4.20(1)-release
You are using the Bash Shell version 4 series.
$
```

注意，这里使用了 `==` 运算符，顺便回顾一下通配符
- 问号（`?`）代表任意单个字符；
- 星号（`*`）代表零个或多个字符。

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

运行这个脚本时，会产生如下输出：

```
$ ./test-integer2
INT is negative.
INT is odd.
$
```

通过应用正则表达式，我们可以将INT的值限制为只能是以可选的减号起始，
后跟一个或多个数字的字符串，同时也消除了INT为空值的可能。

注意，这里使用了 `=~` 运算符：

```
string1 =~ regex
```

如果string1与扩展的正则表达式regex匹配，则返回true。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 12.6 if-then 的高级特性
- 《Linux命令行大全 第2版》: 27.4 更现代的test

