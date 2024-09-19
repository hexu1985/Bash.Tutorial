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
#!/bin/bash
# Testing the test command

if test
then
	echo "No expression returns a True"
else
	echo "No expression returns a False"
fi
```

运行这个脚本时，会产生如下输出：

```bash
$ ./08-test-command
No expression returns a False
$
```

如果加入了条件，则 test 命令会测试该条件。
例如，可以使用 test 命令确定变量中是否为空。这只需要一个简单的条件表达式：

```bash
#!/bin/bash
# Testing the test command
my_variable="Full"

if test $my_variable
then
	echo "The $my_variable expression returns a True"
else
	echo "The $my_variable expression returns a False"
fi
```

运行这个脚本时，会产生如下输出：

```bash
$ ./09-test-command
The Full expression returns a True
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


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 12.4 test 命令
