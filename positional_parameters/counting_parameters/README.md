### 参数统计

Shell提供了特殊变量 `$#`，其中包含了命令行中的参数个数。
你可以在脚本中的任何地方使用这个特殊变量，就跟普通变量一样：

```bash
#!/bin/bash
# getting number of parameters

echo There were $# parameters supplied.
```

执行脚本，输出结果如下所示：

```bash
$ ./09-getting-number-of-parameters
There were 0 parameters supplied.
$
$ ./09-getting-number-of-parameters Hello
There were 1 parameters supplied.
$
$ ./09-getting-number-of-parameters Hello World
There were 2 parameters supplied.
$
$ ./09-getting-number-of-parameters "Hello World"
There were 1 parameters supplied.
$
```

现在可以在使用之前测试命令行参数的数量了：

```bash
#!/bin/bash
# testing parameters

if [ $# -ne 2 ]
then
	echo
	echo Usage: $(basename $0) a b
	echo
else
	total=$[ $1 + $2 ]
	echo
	echo The total is $total
	echo
fi
```

执行脚本，输出结果如下所示：

```bash
$ ./10-testing-parameters 
Usage: 10-testing-parameters parameter1 parameter2
$
$ ./10-testing-parameters 17
Usage: 10-testing-parameters parameter1 parameter2
$
$ ./10-testing-parameters 17 25
17 + 25 is 42
$
```

if-then 语句用 `-ne` 测试检查命令行参数数量。如果数量不对，则会显示一条错误消息，告知脚本的正确用法。

这个变量还提供了一种简便方法来获取命令行中最后一个参数，完全不需要知道实际上到底用了多少个参数。
不过要实现这一点，得费点儿事。

如果仔细考虑过，你可能会觉得既然$#变量含有命令行参数的总数，那么变量`${$#}`应该就代表了最后一个位置变量。
试试看会发生什么：

```bash
#!/bin/bash
# Testing grabbing the last parameter
#
echo The number of parameters is $#
echo The last parameter is ${$#}
exit
```

执行脚本，输出结果如下所示：

```bash
$ ./11-testing-grabbing-last-parameter-bad-test-dollar-in-brace one two three four
The number of parameters is 4
The last parameter is 210683
```

显然，这种方法不管用。这说明不能在花括号内使用 `$`，必须将 `$` 换成 `!`。很奇怪，但的确有效：

```bash
#!/bin/bash
# Testing grabbing the last parameter
#
echo The number of parameters is $#
echo The last parameter is ${!#}
exit
```

执行脚本，输出结果如下所示：

```bash
$ ./12-testing-grabbing-last-parameter-exclamation-in-brace one two three four
The number of parameters is 4
The last parameter is four
$
$ ./12-testing-grabbing-last-parameter-exclamation-in-brace
The number of parameters is 0
The last parameter is ./12-testing-grabbing-last-parameter-exclamation-in-brace
$
```

重要的是要注意，当命令行中没有任何参数时，`$#` 的值即为 0，但 `${!#}` 会返回命令行中的脚本名。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 14.2.1 参数统计

