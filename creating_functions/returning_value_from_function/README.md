### 函数返回值

bash shell 把函数视为一个小型脚本，运行结束时会返回一个退出状态码。
有 3 种方法能为函数生成退出状态码。

**默认的退出状态码**

在默认情况下，函数的退出状态码是函数中最后一个命令返回的退出状态码。
函数执行结束后，可以使用标准变量$?来确定函数的退出状态码：

```bash
#!/bin/bash
# testing the exit status of a function

func1() {
	echo "trying to display a non-existent file"
	ls -l badfile
}

echo "testing the function: "
func1
echo "The exit status is: $?"
```

执行脚本，输出结果如下所示：

```bash
$ ./script04-testing-the-exit-status-of-a-function
testing the function:
trying to display a non-existent file
ls: 无法访问 'badfile': 没有那个文件或目录
The exit status is: 2
```

该函数的退出状态码是 2，因为函数中的最后一个命令执行失败了。
但你无法知道该函数中的其他命令是否执行成功。来看下面的例子：

```bash
#!/bin/bash
# testing the exit status of a function

func1() {
	ls -l badfile
	echo "trying to display a non-existent file"
}

echo "testing the function: "
func1
echo "The exit status is: $?"
```

执行脚本，输出结果如下所示：

```bash
$ ./script05-testing-the-exit-status-of-a-function-no-way-to-know
testing the function:
ls: 无法访问 'badfile': 没有那个文件或目录
trying to display a non-existent file
The exit status is: 0
```

这次，由于函数最后一个命令 echo 执行成功，因此该函数的退出状态码为 0，
不过其中的其他命令执行失败。使用函数的默认退出状态码是一种危险的做法。


**使用 return 命令**

bash shell 会使用 return 命令以特定的退出状态码退出函数。
return 命令允许指定一个整数值作为函数的退出状态码，从而提供了一种简单的编程设定方式：

```bash
#!/bin/bash
# using the return command in a function

function db1 {
	read -p "Enter a value: " value
	echo "doubling the value"
	return $[ $value * 2 ]
}

db1
echo "The new value is $?"
```

执行脚本，输出结果如下所示：

```bash
$ ./script06-using-the-return-command-in-a-function
Enter a value: 4
doubling the value
The new value is 8
```

dbl 函数会将 `$value` 变量中用户输入的整数值翻倍，然后用 return 命令返回结果。
脚本用 `$? ` 变量显示出该结果。

当用这种方法从函数中返回值时，一定要小心。为了避免出问题，牢记以下两个技巧。
- 函数执行一结束就立刻读取返回值。
- 退出状态码必须介于 0~255。

如果在用 `$?` 变量提取函数返回值之前执行了其他命令，那么函数的返回值会丢失。
因为，`$?` 变量保存的是最后执行的那个命令的退出状态码。

第二个技巧界定了返回值的取值范围。由于退出状态码必须小于 256，
因此函数结果也必须为一个小于 256 的整数值。大于 255 的任何数值都会产生错误的值：

```bash
$ ./script06-using-the-return-command-in-a-function
Enter a value: 200
doubling the value
The new value is 144
```

如果需要返回较大的整数值或字符串，就不能使用 return 方法。


**使用用函数输出**

正如可以将命令的输出保存到 shell 变量中一样，也可以将函数的输出保存到 shell 变量中：

```bash
result=$(dbl)
```

这个命令会将 dbl 函数的输出赋给 `$result` 变量。来看一个例子：

```bash
#!/bin/bash
# using the echo to return a value

function db1 {
	read -p "Enter a value: " value
	echo $[ $value * 2 ]
}

result=$(db1)
echo "The new value is $result"
```

执行脚本，输出结果如下所示：

```bash
$ ./script07-using-the-echo-to-return-a-value
Enter a value: 200
The new value is 400
$
$ ./script07-using-the-echo-to-return-a-value
Enter a value: 1000
The new value is 2000
```

新函数会用 echo 语句来显示计算结果。
该脚本会获取 dbl 函数的输出，而不是查看退出状态码。

这个例子演示了一个不易察觉的技巧。注意，dbl 函数实际上输出了两条消息。
read 命令输出了一条简短的消息来向用户询问输入值。
bash shell 脚本非常聪明，并不将其作为 STDOUT 输出的一部分，而是直接将其忽略。
如果用 echo 语句生成这条消息来询问用户，那么它会与输出值一起被读入 shell 变量。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 17.2 函数返回值

