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
- 整数测试
- 字符串测试
- 文件测试

**整数测试**

使用 test 命令最常见的情形是对两个数值进行比较。
下表列出了测试两个值时可用的条件参数。

| 表达式                | 成为true的条件           |
| --------------------- | ------------------------ |
| integer1 -eq integer2 | integer1和integer2相等   |
| integer1 -ne integer2 | integer1和integer2不相等 |
| integer1 -le integer2 | integer1小于等于integer2 |
| integer1 -lt integer2 | integer1小于integer2     |
| integer1 -ge integer2 | integer1大于等于integer2 |
| integer1 -gt integer2 | integer1大于integer2     |

下面是一个演示这些表达式的脚本。

```bash
#!/bin/bash

# test-integer: evaluate the value of an integer.

INT=-5

if [ -z "$INT" ]; then
	echo "INT is empty." >&2
	exit 1
fi

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
```

**字符串测试**

条件测试还允许比较字符串值。
下表列出了可用的字符串比较功能。

| 表达式             | 成为true的条件                            |
| ------------------ | ----------------------------------------- |
| string             | string 不为空                             |
| -n string          | string1 的长度不为 0                      |
| -z string          | string 的长度为 0                         |
| string1 = string2  | string1 等于 string2 （=两侧必须有空格）  |
| string1 == string2 | string1 等于 string2 （==两侧必须有空格） |
| string1 != string2 | string1 不等于 string2（!=两侧必须有空格）| 
| string1 > string2  | 在排序时，string1在string2之后            | 
| string1 < string2  | 在排序时，string1在string2之前            | 

警告：string1<string2 在排序时，string1在string2之前
在使用test命令时，">"和"<"运算符必须用引号括起来（或者是使用反斜杠进行转义）。如果不这
样做，就会被shell解释为重定向操作符，从而造成潜在的破坏性结果。同时注意，尽管bash文档中已经声
明，排序遵从当前语系的排列规则，但并非如此。在bash 4.0版本以前（包括4.0版本），使用的是
ASCII（POSIX）排序方式。

下面是一个合并字符串表达式的脚本。

```bash
#!/bin/bash

# test-string: evaluate the value of a string

ANSWER=maybe

if [ -z "$ANSWER" ]; then
	echo "There is no answer." >&2
	exit 1
fi

if [ "$ANSWER" = "yes" ]; then
	echo "The answer is YES."
elif [ "$ANSWER" = "no" ]; then
	echo "The answer is NO."
elif [ "$ANSWER" = "maybe" ]; then
	echo "The answer is MAYBE."
else
	echo "The answer is UNKNOWN."
fi
```

**文件测试**

最后一类比较测试很有可能是 shell 编程中最为强大且用得最多的比较形式。
它允许测试Linux 文件系统中文件和目录的状态。
下表列出了这类比较。

| 表达式          | 成为true的条件                                                                        |
| --------------- | ------------------------------------------------------------------------------------- |
| file1 -ef file2 | file1和file2拥有相同的信息节点编号（这两个文件通过硬链接指向同一个文件）              |
| file1 -nt file2 | file1比file2新                                                                        |
| file1 -ot file2 | file1比file2旧                                                                        |
| -b file         | file存在并且是一个块（设备）文件                                                      |
| -c file         | file存在并且是一个字符（设备）文件                                                    |
| -d file         | file存在并且是一个目录                                                                |
| -e file         | file存在                                                                              |
| -f file         | file存在并且是一个普通文件                                                            |
| -g file         | file存在并且设置了组ID                                                                |
| -G file         | file存在并且属于有效组ID                                                              |
| -k file         | file存在并且有“粘滞位（sticky bit）”属性                                              |
| -L file         | file存在并且是一个符号链接                                                            |
| -O file         | file存在并且属于有效用户ID                                                            |
| -p file         | file存在并且是一个命名管道                                                            |
| -r file         | file存在并且可读（有效用户有可读权限）                                                |
| -s file         | file存在并且其长度大于0                                                               |
| -S file         | file存在并且是一个网络套接字                                                          |
| -t fd           | fd是一个定向到终端/从终端定向的文件描述符，可以用来确定标准输入/输出/错误是否被重定向 |
| -u file         | file存在并且设置了setuid位                                                            |
| -w file         | file存在并且可写（有效用户拥有可写权限）                                              |
| -x file         | fiile存在并且可执行（有效用户拥有执行/搜索权限）                                      |

下面的脚本可用来演示某些文件表达式。

```bash
#!/bin/bash

# test-file: Evaluate the status of a file

FILE=~/.bashrc

if [ -e "$FILE" ]; then
	if [ -f "$FILE" ]; then
		echo "$FILE is a regular file."
	fi
	if [ -d "$FILE" ]; then
		echo "$FILE is a directory."
	fi      
	if [ -r "$FILE" ]; then  
		echo "$FILE is readable."
	fi  
	if [ -w "$FILE" ]; then  
		echo "$FILE is writable."   
	fi     
	if [ -x "$FILE" ]; then
		echo "$FILE is executable/searchable."  
	fi
else 
	echo "$FILE does not exist"   
	exit 1
fi

exit
```

**逻辑测试**

我们也可以将表达式组合起来，来创建更复杂的计算。表达式是使用逻辑运算符组合起来的。
与test命令配套的逻辑运算符有三个，它们是AND、OR和NOT。

| 测试运算符     | 测试内容 |
| -------------- | -------- |
| expr1 -a expr2 | 逻辑与   |
| expr1 -o expr2 | 逻辑或   |
| !expr          | 逻辑非   |

下面是一个AND运算的例子。这个脚本用来检测一个整数是否属于某个范围内的值。

```bash
#!/bin/bash

# test-integer3: determine if an integer is within a
# specified range of values.

MIN_VAL=1
MAX_VAL=100

INT=50

if [ $INT -ge $MIN_VAL -a $INT -le $MAX_VAL ]; then
    echo "$INT is within $MIN_VAL to $MAX_VAL."
else
    echo "$INT is out of range."
fi
```

### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 12.4 test 命令
- 《UNIX Shell范例精解 第4版》: 14.5.6 文件测试
- 《Linux命令行大全 第2版》: 27.3 使用test
