### test命令

到目前为止，我们在 if 语句行中看到的都是普通的 shell 命令。
你可能想知道 if-then 语句能否测试命令退出状态码之外的条件。

答案是不能。但是，在 bash shell中有个好用的工具可以帮你使用 if-then 语句测试其他条件。

test 命令可以在 if-then 语句中测试不同的条件。如果 test 命令中列出的条件成立，那么
test 命令就会退出并返回退出状态码 0。这样 if-then 语句的工作方式就和其他编程语言中的 if-then 语句差不多了。
如果条件不成立，那么 test 命令就会退出并返回非 0 的退出状态码，这使得 if-then 语句不会再被执行。

test 命令的格式非常简单：

```bash
test condition
```

condition 是 test 命令要测试的一系列参数和值。当用在 if-then 语句中时，test 命令看起来如下所示：

```bash
if test condition
then
    commands
fi
```

如果不写 test 命令的 condition 部分，则它会以非 0 的退出状态码退出并执行 else 代码块语句：

```bash
$ cat test6.sh
#!/bin/bash
# testing the test command
#
if test
then
    echo "No expression returns a True"
else
    echo "No expression returns a False"
fi
$
$ ./test6.sh
No expression returns a False
$
```

如果加入了条件，则 test 命令会测试该条件。
例如，可以使用 test 命令确定变量中是否为空。这只需要一个简单的条件表达式：

```bash
$ cat test6.sh
#!/bin/bash
# testing if a variable has content
#
my_variable="Full"
#
if test $my_variable
then
echo "The my_variable variable has content and returns a True."
    echo "The my_variable variable content is: $my_variable"
else
    echo "The my_variable variable doesn't have content,"
    echo "and returns a False."
fi
$
$ ./test6.sh
The my_variable variable has content and returns a True.
The my_variable variable content is: Full
$
```

bash shell 提供了另一种条件测试方式，无须在 if-then 语句中写明 test 命令：

```bash
if [ condition ]
then
    commands
fi
```

方括号定义了测试条件。注意，第一个方括号之后和第二个方括号之前必须留有空格，否则就会报错。

test 命令和测试条件可以判断 3 类条件。
- 数值比较
- 字符串比较
- 文件比较

使用 test 命令最常见的情形是对两个数值进行比较。
下表列出了测试两个值时可用的条件参数。

| 比 较     | 描 述                     |
| --------- | ------------------------- |
| n1 -eq n2 | 检查 n1 是否等于 n2       |
| n1 -ge n2 | 检查 n1 是否大于或等于 n2 |
| n1 -gt n2 | 检查 n1 是否大于 n2       |
| n1 -le n2 | 检查 n1 是否小于或等于 n2 |
| n1 -lt n2 | 检查 n1 是否小于 n2       |
| n1 -ne n2 | 检查 n1 是否不等于 n2     |

条件测试还允许比较字符串值。
下表列出了可用的字符串比较功能。

| 比 较        | 描 述                      |
| ------------ | -------------------------- |
| str1 = str2  | 检查 str1 是否和 str2 相同 |
| str1 != str2 | 检查 str1 是否和 str2 不同 |
| str1 < str2  | 检查 str1 是否小于 str2    |
| str1 > str2  | 检查 str1 是否大于 str2    |
| -n str1      | 检查 str1 的长度是否不为 0 |
| -z str1      | 检查 str1 的长度是否为 0   |

因为shell会把`>`解释成输出重定向，把`<`解释成输入重定向。 所以，`<`和`>`必须进行转义：`\<`和`\>`。

最后一类比较测试很有可能是 shell 编程中最为强大且用得最多的比较形式。
它允许测试Linux 文件系统中文件和目录的状态。
下表列出了这类比较。

| 比 较           | 描 述                                    |
| --------------- | ---------------------------------------- |
| -d file         | 检查 file 是否存在且为目录               |
| -e file         | 检查 file 是否存在                       |
| -f file         | 检查 file 是否存在且为文件               |
| -r file         | 检查 file 是否存在且可读                 |
| -s file         | 检查 file 是否存在且非空                 |
| -w file         | 检查 file 是否存在且可写                 |
| -x file         | 检查 file 是否存在且可执行               |
| -O file         | 检查 file 是否存在且属当前用户所有       |
| -G file         | 检查 file 是否存在且默认组与当前用户相同 |
| file1 -nt file2 | 检查 file1 是否比 file2 新               |
| file1 -ot file2 | 检查 file1 是否比 file2 旧               |

我们也可以将表达式组合起来，来创建更复杂的计算。表达式是使用逻辑运算符组合起来的。
与test命令配套的逻辑运算符有三个，它们是AND、OR和NOT。

| 运算符 | 描 述 |
| ------ | ----- |
| -a     | AND   |
| -o     | OR    |
| !      | NOT   |

### 参考资料:
- 《Linux Command Line and Shell Scripting Bible》: Chapter 12: Using Structured Commands
- 《UNIX Shells by Example》: 14.5.6 File Testing, EXAMPLE 14.25
