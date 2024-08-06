### 嵌套 if 语句

有时需要在脚本中检查多种条件。对此，可以使用嵌套的 if-then 语句。
要检查/etc/passwd 文件中是否存在某个用户名以及该用户的主目录是否尚在，
可以使用嵌套的 if-then 语句。嵌套部分位于主 if-then-else 语句的 else 代码块中：

```bash
#!/bin/bash
# Testing nested ifs
testuser=NoSuchUser

if grep $testuser /etc/passwd
then
	echo "The user $testuser exists on this system."
else
	echo "The user $testuser does not exist on this system."

	if ls -d /home/$testuser/
	then
		echo "However, $testuser has a directory."
	fi
fi
```

运行这个脚本时，会产生如下输出：

```
$ ls -d /home/NoSuchUser/
/home/NoSuchUser/
$ ./05-nesting-ifs
The user NoSuchUser does not exist on this system.
/home/NoSuchUser/
However, NoSuchUser has a directory.
We are outside the if statement
$
```

这个脚本准确无误地发现，虽然用户账户已经从/etc/passwd 文件中删除，但该用户的目录仍然存在。
在脚本中使用这种嵌套 if-then 语句的问题在于代码不易阅读，逻辑流程很难厘清。

你可以使用 else 部分的另一种名为 elif 的形式，这样就不用再写多个 if-then 语句了。
elif 使用另一个 if-then 语句延续 else 部分：

```
if command1
then
    commands
elif command2
then
    more commands
fi
```

elif 语句行提供了另一个要测试的命令，这类似于原始的 if 语句行。
如果 elif 之后的命令的退出状态码是 0，则 bash 会执行第二个 then 语句部分的命令。
这种嵌套形式使得代码更清晰，逻辑更易懂：

```bash
#!/bin/bash
# Testing nested ifs - use elif
testuser=NoSuchUser

if grep $testuser /etc/passwd
then
	echo "The user $testuser exists on this system."
elif ls -d /home/$testuser
then
	echo "The user $testuser does not exist on this system."
	echo "However, $testuser has a directory."
fi
echo "We are outside the if statement"
```

运行这个脚本时，会产生如下输出：

```
$ ./06-nesting-ifs-use-elif 
/home/NoSuchUser
The user NoSuchUser does not exist on this system.
However, NoSuchUser has a directory.
We are outside the if statement
$
```

这个脚本还有一个问题：如果指定账户及其主目录都已经不存在了，那么脚本不会发出任何提醒。
你可以解决这个问题，甚至可以更进一步，让脚本检查拥有主目录的不存在用户和没有主目录的不存在用户。
这可以通过在嵌套 elif 中加入一个 else 语句来实现：

```bash
#!/bin/bash
# Testing nested ifs - use elif & else
testuser=NoSuchUser

if grep $testuser /etc/passwd
then
	echo "The user $testuser exists on this system."
elif ls -d /home/$testuser
then
	echo "The user $testuser does not exist on this system."
	echo "However, $testuser has a directory."
else
	echo "The user $testuser does not exist on this system."
	echo "And, $testuser does not have a directory."
fi
echo "We are outside the if statement"
```

运行这个脚本时，会产生如下输出：

```
$ ./examples/07-nesting-ifs-use-elif-else
/home/NoSuchUser
The user NoSuchUser does not exist on this system.
However, NoSuchUser has a directory.
We are outside the if statement
$
$ sudo rmdir /home/NoSuchUser
$ 
$ ./examples/07-nesting-ifs-use-elif-else
ls: 无法访问'/home/NoSuchUser': 没有那个文件或目录
The user NoSuchUser does not exist on this system.
And, NoSuchUser does not have a directory.
We are outside the if statement
```

在/home/NoSuchUser 目录被删除之前，这个测试脚本执行的是 elif 语句，返回 0 值的退出状态。
因此，elif 的 then 代码块中的语句得以执行。删除了/home/NoSuchUser 目录之后，elif语句返回的是非 0 值的退出状态。
这使得 elif 块中的 else 代码块得以执行。

可以继续将多个 elif 语句串起来，形成一个更大的 if-then-elif 嵌套组合：

```
if command1
then
    command set 1
elif command2
then
    command set 2
elif command3
then
    command set 3
elif command4
then
    command set 4
fi
```

每个代码块会根据命令是否会返回退出状态码 0 来执行。
记住，bash shell 会依次执行 if 语句，只有第一个返回退出状态码 0 的语句中的 then 部分会被执行。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 12.3 嵌套 if 语句

