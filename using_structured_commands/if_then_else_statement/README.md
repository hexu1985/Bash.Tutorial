### if-then-else 语句

在 if-then 语句中，不管命令是否成功执行，你都只有一种选择。
如果命令返回一个非 0 退出状态码，则 bash shell 会继续执行脚本中的下一条命令。
在这种情况下，如果能够执行另一组命令就好了。这正是 if-then-else 语句的作用。

if-then-else 语句在语句中提供了另外一组命令：

```
if command
then
    commands
else
    commands
fi
```

当 if 语句中的命令返回退出状态码 0 时，then 部分中的命令会被执行，这跟普通的 if-then语句一样。
当 if 语句中的命令返回非 0 退出状态码时，bash shell 会执行 else 部分中的命令。
现在你可以复制并修改测试脚本，加入 else 部分：

```bash
#!/bin/bash
# testing the else section
testuser=NoSuchUser

if grep $testuser /etc/passwd
then
	echo "The bash files for user $testuser are:"
	ls -a /home/$testuser/*.sh
	echo
else
	echo "The user $testuser does not exist on this system."
	echo
fi
echo "We are outside the if statement"
```

运行修改后的脚本时，会产生如下输出：

```
$ ./04-else-section 
The user NoSuchUser does not exist on this system.

We are outside the if statement
```

shell提供了两个非常简单的内置命令，它们不做任何事情，除了以一个0或1退出状态来终止执行。
`true`命令总是表示执行成功，而`false`命令总是表示执行失败。

例如：

```
$ true
$ echo $?
0
$ false
$ echo $?
1
```

我们可以用这两个命令来查看if语句是如何工作的。if语句真正做的事情是评估命令的成功或失败。

```
$ if true; then echo "It's true."; fi
It's true.
$ if false; then echo "It's true."; fi
$
```

当在if后面的命令执行成功时，命令echo ”It’s true.”会被执行，而当在if后面的命令执行失败时，
该命令则不执行。如果在if后面有一系列的命令，那么则根据最后一个命令的执行结果进行评估。

```
$ if false; true; then echo "It's true."; fi
It's true.
$ if true; false; then echo "It's true."; fi
$
```

### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 12.2 if-then-else 语句

