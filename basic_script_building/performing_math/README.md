### 执行数学运算

编程语言的另一项至关重要的特性是数学运算能力。遗憾的是，shell 脚本在这方面多少有些不尽如人意。
在 shell 脚本中，执行数学运算有两种方式。

最初，Bourne shell 提供了一个专门用于处理数学表达式的命令：expr，
该命令可在命令行中执行数学运算，但是特别笨拙。

```
$ expr 1 + 5
6
```

尽管标准运算符在 expr 命令中工作得很好，但在脚本或命令行中使用时仍有问题出现。
许多 expr 命令运算符在 shell 中另有他意（比如 `*` ）。
当这些符号出现在 expr 命令中时，会产生一些诡异的结果：

```
$ expr 5 * 2
expr: 语法错误
$ 
```

要解决这个问题，就要在那些容易被 shell 错误解释的字符被传入 expr 命令之前，
使用 shell 的转义字符（反斜线）对其进行转义：

```
$ expr 5 \* 2
10
$
```

在 shell 脚本中使用 expr 命令也同样麻烦：

```bash
#!/bin/bash
# An example of using the expr command

var1=10
var2=20
var3=$(expr $var2 / $var1)
echo The result is $var3
```

要将一个数学算式的结果赋给变量，需要使用命令替换来获取 expr 命令的输出：

```
$ ./10-expr-command-math
The result is 2
$
```

为了兼容 Bourne shell，bash shell 保留了 expr 命令，但同时也提供了另一种更简单的方法来执行数学运算。
在 bash 中，要将数学运算结果赋给变量，可以使用 `$` 和方括号（ `$[ operation ]` ）：

```
$ var1=$[1 + 5]
$ echo $var1
6
$ var2=$[$var1 * 2]
$ echo $var2
12
$
```

用方括号来执行数学运算要比 expr 命令方便得多。这种技术也适用于 shell 脚本：

```bash
#!/bin/bash
# using brackets for math

var1=100
var2=50
var3=45
var4=$[$var1 * ($var2 - $var3)]
echo The final result is $var4
```

运行这个脚本会得到如下输出：

```
$ ./11-brackets-math
The final result is 500
$
```

在使用方括号执行数学运算时，无须担心 shell 会误解乘号或其他符号。
shell 清楚方括号内的星号不是通配符。

在 bash shell 脚本中执行数学运算有一个很大的局限。来看下面这个例子：

```bash
#!/bin/bash
# using brackets for math

var1=100
var2=45
var3=$[$var1 / $var2]
echo The final result is $var3
```

运行该脚本，看看会发生什么：

```
$ ./11-brackets-math-2
The final result is 2
$
```

bash shell 的数学运算符只支持整数运算。如果打算尝试现实世界中的数学运算，那么这是一个巨大的限制。

有几种解决方案能够克服 bash 只支持整数运算的限制。最常见的做法是使用内建的 bash 计算器 bc。

bash 计算器实际上是一种编程语言，允许在命令行中输入浮点数表达式，然后解释并计算该表达式，最后返回结果。
bash 计算器能够识别以下内容。
- 数字（整数和浮点数）
- 变量（简单变量和数组）
- 注释（以#或 C 语言中的/* */开始的行）
- 表达式
- 编程语句（比如 if-then 语句）
- 函数

你可以在 shell 提示符下通过 bc 命令访问 bash 计算器：

```
$ bc
bc 1.07.1
Copyright 1991-1994, 1997, 1998, 2000, 2004, 2006, 2008, 2012-2017 Free Software Foundation, Inc.
This is free software with ABSOLUTELY NO WARRANTY.
For details type `warranty'.
12 * 5.4
64.8
3.156 * (3 + 5)
25.248
quit
$
```

这个例子先是输入了表达式 12 * 5.4。bash 计算器返回了计算结果。
随后每个输入计算器的表达式都会被求值并显示出结果。要退出 bash 计算器，必须输入 quit。
浮点数运算是由内建变量 scale 控制的。你必须将该变量的值设置为希望在计算结果中保留的小数位数，
否则将无法得到期望的结果：

```
$ bc -q
3.44 / 5
0
scale=4
3.44 / 5
.6880
quit
$
```

除了普通数字，bash 计算器还支持变量：

```
$ bc -q
var1=10
var1 * 4
40
var2 = var1 / 5
print var2
2
quit
$
```

变量值一旦被定义，就可以在整个 bash 计算器会话中使用了。print 语句可以打印变量和数字。

bash 计算器是如何在 shell 脚本中处理浮点数运算？没错，可以用命令替换来运行 bc 命令，将输出赋给变量。
基本格式如下：

```
variable=$(echo "options; expression" | bc)
```

第一部分的 options 允许你设置变量。如果需要多个变量，可以用分号来分隔它们。
expression 定义了要通过 bc 执行的数学表达式。下面是在脚本中执行此操作的示例：

```bash
#!/bin/bash
# using bc for floating point calculations

var1=$(echo "scale=4; 3.44 / 5" | bc)
echo The answer is $var1
```

这个例子将 scale 变量设置为 4 位小数，在 expression 部分指定了特定的运算。
运行这个脚本会产生如下输出：

```
$ ./12-bc-math
The answer is .6880
$
```

表达式中不仅可以使用数字，还可以用 shell 脚本中定义好的变量：

```bash
#!/bin/bash
# using variables in bc command

var1=100
var2=45
var3=$(echo "scale=4; $var1 / $var2" | bc)
echo The answer for this is $var3
```

该脚本定义了两个变量，这两个变量都可以用在 expression 部分中，发送给 bc 命令。
别忘了 `$` 表示引用变量的值而不是变量自身。该脚本的输出如下：

```
$ ./13-using-variable-in-bc
The answer for this is 2.2222
$
```

当然，一旦变量被赋值，该变量就可以用于其他运算中：

```bash
#!/bin/bash
# bc math, using a variable several times

var1=20
var2=3.14159
var3=$(echo "scale=4; $var1 * $var1" | bc)
var4=$(echo "scale=4; $var3 * $var2" | bc)
echo The final result is $var4
```

这种方法适用于较短的运算，但有时你需要涉及更多的数字。
如果要进行大量运算，那么在一个命令行中列出多个表达式容易让人犯晕。

有一种方法可以解决这个问题。bc 命令能接受输入重定向，允许将一个文件重定向到 bc命令来处理。
但这同样会让人头疼，因为还需要将表达式存放到文件中。

最好的办法是使用内联输入重定向，它允许直接在命令行中重定向数据。
在 shell 脚本中，可以将输出赋给一个变量：

```
variable=$(bc << EOF
options
statements
expressions
EOF
)
```

字符串 EOF 标识了内联重定向数据的起止。别忘了，仍然需要用命令替换符将 bc 命令的输出赋给变量。

现在，可以将 bash 计算器涉及的各个部分放入脚本文件的不同行中。以下示例演示了如何在脚本中使用这项技术：

```bash
#!/bin/bash
# bc math, inline redirection

var1=10.46
var2=43.67
var3=33.2
var4=71

var5=$(bc << EOF
scale = 4
a1 = ($var1 * $var2)
b1 = ($var3 * $var4)
a1 + b1
EOF
)

echo The final answer for this mess is $var5
```

运行这个脚本时，会产生如下输出：

```
$ ./15-bc-math-inline-redirection
The final answer for this mess is 2813.9882
```

将选项和表达式放在脚本的不同行中可以让处理过程变得更清晰并提高易读性。
EOF 字符串标识了重定向给 bc 命令的数据的起止。当然，必须用命令替换符标识出用来给变量赋值的命令。

还要注意到，在这个例子中，可以在 bash 计算器中为变量赋值。
有一点很重要：在 bash 计算器中创建的变量仅在计算器中有效，不能在 shell 脚本中使用。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 11.7 执行数学运算

