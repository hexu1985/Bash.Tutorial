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

能出现在 then 部分的命令可不止一条。你可以像脚本中其他地方一样在这里列出多条命令。
bash shell 会将这些命令视为一个代码块，如果 if 语句行命令的退出状态值为 0，
那么代码块中所有的命令都会被执行；否则，会跳过整个代码块：

```bash
#!/bin/bash
# testing multiple commands in the then section
testuser=hexu

if grep $testuser /etc/passwd
then
	echo "This is my first command"
	echo "This is my second command"
	echo "I can even put in other commands besides echo:"
	ls -lhs /home/$testuser/*.sh
fi
echo "We are outside the if statement"
```

if 语句行使用 grep 命令在/etc/passwd 文件中查找系统中是否存在某个特定用户。
如果存在，则脚本会显示一些文本信息并列出该用户$HOME 目录的 bash 脚本文件：

```
$ ./03-multiple-commands-in-then-section
hexu:x:1000:1000:hexu,,,:/home/hexu:/bin/bash
This is my first command
This is my second command
I can even put in other commands besides echo:
0 -rw-rw-r-- 1 hexu hexu 0 8月   6 10:15 /home/hexu/test.sh
We are outside the if statement
```

但是，如果将 testuser 变量设置成一个系统中不存在的用户，则不执行 then 代码块中的任何命令：

```
testuser=NoSuchUser
```

运行修改后的脚本时，会产生如下输出：

```
$ ./03-multiple-commands-in-then-section
We are outside the if statement
```

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
- 《Linux命令行与shell脚本编程大全（第4版）》: 12.1 使用 if-then 语句，12.2 if-then-else 语句
- 《Linux命令行大全 第2版》: 27.2 退出状态

