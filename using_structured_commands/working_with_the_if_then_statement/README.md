### 使用 if-then 语句

最基本的结构化命令是 if-then 语句。if-then 语句的格式如下：

```bash
if command
then
    commands
fi
```

bash shell 的 if 语句会运行 if 之后的命令。如果该命令的退出状态码为 0（命令成功运行），
那么位于 then 部分的命令就会被执行。如果该命令的退出状态码是其他值，
则 then 部分的命令不会被执行，bash shell 会接着处理脚本中的下一条命令。
fi 语句用来表示if-then 语句到此结束。

下面用一个简单的例子来解释一下这个概念：

```bash
#!/bin/bash
# testing the if statement
if pwd
then
	echo "It worked"
fi
```

该脚本在 if 行中使用了 pwd 命令。如果命令成功结束，那么 echo 语句就会显示字符串。
当你在命令行中运行该脚本时，会得到如下结果：

```
$ ./01-testing-if
/home/christine/scripts
It worked
$
```

shell 执行了 if 行中的 pwd 命令。由于退出状态码是 0，因此它也执行了 then 部分的 echo 语句。

来看另一个例子：

```bash
#!/bin/bash
# testing a bad command
if IamNotaCommand
then
	echo "It worked"
fi
echo "We are outside the if statement"
```

运行这个脚本时，会产生如下输出：

```
$ ./02-if-testing-a-bad-command
./02-if-testing-a-bad-command: line 3: IamNotaCommand: command not found
We are outside the if statement
```

在这个例子中，我们在 if 语句中故意使用了一个不存在的命令 IamNotaCommand。
由于这是个错误的命令，因此会产生一个非 0 的退出状态码，bash shell 因此跳过了 then 部分的 echo命令。
还要注意，if 语句中的那个错误命令所产生的错误消息依然会显示在脚本的输出中。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 12.1 使用 if-then 语句

