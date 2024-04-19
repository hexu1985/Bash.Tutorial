### continue 命令

continue 命令可以提前中止某次循环，但不会结束整个循环。
你可以在循环内部设置 shell 不执行命令的条件。

来看一个在 for 循环中使用 continue 命令的简单例子：

```bash
#!/bin/bash
# using the continue command

for ((var1 = 1; var1 < 15; var1++))
do
	if [ $var1 -gt 5 ] && [ $var1 -lt 10 ]
	then
		continue
	fi
	echo "Iteration number: $var1"
done
```

执行脚本，输出结果如下所示：

```
$ ./test21
Iteration number: 1
Iteration number: 2
Iteration number: 3
Iteration number: 4
Iteration number: 5
Iteration number: 10
Iteration number: 11
Iteration number: 12
Iteration number: 13
Iteration number: 14
```

当 if-then 语句的条件成立时（值大于 5 且小于 10），shell 会执行 continue 命令，
跳过此次循环中剩余的命令，但整个循环还会继续。
当 if-then 的条件不成立时，一切会恢复如常。

也可以在 while 循环和 until 循环中使用 continue 命令，但要特别小心。
记住，当 shell 执行 continue 命令时，它会跳过剩余的命令。
如果将测试变量的增值操作放在了其中某个条件里，那么问题就出现了：

以下面的脚本为例：

```bash
#!/bin/bash
# improperly using the continue command in a while loop

var1=0

while echo "while iteration: $var1"
	[ $var1 -lt 15 ]
do
	if [ $var1 -gt 5 ] && [ $var1 -lt 10 ]
	then
		continue
	fi
	echo "   Inside iteration number: $var1"
	var1=$[ $var1 + 1 ]
done
```

你得确保将脚本的输出重定向至 more 命令，这样才能停止输出。

```
$ ./test2 | more
while iteration: 0
   Inside iteration number: 0
while iteration: 1
   Inside iteration number: 1
while iteration: 2
   Inside iteration number: 2
while iteration: 3
   Inside iteration number: 3
while iteration: 4
   Inside iteration number: 4
while iteration: 5
   Inside iteration number: 5
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
while iteration: 6
^C
```

在 if-then 的条件成立之前，一切看起来都很正常，然后 shell 会执行 continue 命令，
跳过 while 循环中余下的命令。 不幸的是，被跳过的正是对$var1 计数变量增值的部分，
而该变量又被用于 while 测试命令中。这意味着这个变量的值不会再变化了，从前面连续的输出中也可以看到。

和 break 命令一样，continue 命令也允许通过命令行参数指定要继续执行哪一级循环：

```
continue n
```

其中 n 定义了要继续的循环层级。下面是一个继续执行外层 for 循环的例子：

```bash
#!/bin/bash
# continuing on outer loop

for ((a = 1; a <= 5; a++))
do
	echo "Iteration $a:"
	for ((b = 1; b < 3; b++))
	do
		if [ $a -gt 2 ] && [ $a -lt 4 ]
		then
			continue 2
		fi
		var3=$[ $a * $b ]
		echo "   The result of $a * $b is $var3"
	done
done
```

执行脚本，输出结果如下所示：

```bash
Iteration 1:
   The result of 1 * 1 is 1
   The result of 1 * 2 is 2
Iteration 2:
   The result of 2 * 1 is 2
   The result of 2 * 2 is 4
Iteration 3:
Iteration 4:
   The result of 4 * 1 is 4
   The result of 4 * 2 is 8
Iteration 5:
   The result of 5 * 1 is 5
   The result of 5 * 2 is 10
```

其中的 if-then 语句

```bash
if [ $a -gt 2 ] && [ $a -lt 4 ]
then
    continue 2
fi
```

会使用 continue 命令停止处理循环内的命令，但会继续处理外层循环。注意值为 3 那次迭代并
没有处理任何内部循环语句，因为尽管 continue 命令停止了处理，但外层循环依然会继续。


### 参考资料:
- 《Linux Command Line and Shell Scripting Bible》: Chapter 13: More Structured Commands

