### break 命令

break 命令是退出循环的一种简单方法。你可以用 break 命令退出任意类型的循环，包括
for 循环、while 循环和 until 循环。

break 命令适用于多种情况。

**跳出单个循环**

shell 在执行 break 命令时会尝试跳出当前正在执行的循环：

来看一个跳出 for 循环的例子：

```bash
#!/bin/bash
# breaking out of a for loop

for var1 in 1 2 3 4 5 6 7 8 9 10
do
	if [ $var1 -eq 5 ]
	then
		break
	fi
	echo "Iteration number: $var1"
done
echo "The for loop is completed"
```

执行脚本，输出结果如下所示：

```bash
$ ./test17
Iteration number: 1
Iteration number: 2
Iteration number: 3
Iteration number: 4
The for loop is completed
```

for 循环通常会遍历列表中的所有值。但当满足 if-then 的条件时，
shell 会执行 break 命令，结束 for 循环。

该方法同样适用于 while 循环和 until 循环：

再来看一个跳出 while 循环的例子：

```bash
#!/bin/bash
# breaking out of a while loop
var1=1

while [ $var1 -lt 10 ]
do
	if [ $var1 -eq 5 ]
	then
		break
	fi
	echo "Iteration: $var1"
	var1=$[ $var1 + 1 ]
done
echo "The while loop is completed"
```

执行脚本，输出结果如下所示：

```bash
$ ./test18
Iteration: 1
Iteration: 2
Iteration: 3
Iteration: 4
The while loop is completed
```

如果 if-then 的条件成立，就执行 break 命令，结束 while 循环。


**跳出内层循环**

在处理多个循环时，break 命令会自动结束你所在的最内层循环：

来看一个例子：

```bash
#!/bin/bash
# breaking out of a inner loop

for ((a = 1; a < 4; a++))
do
	echo "Outer loop: $a"
	for ((b = 1; b < 100; b++))
	do
		if [ $b -eq 5 ]
		then
			break
		fi
		echo "   Inner loop: $b"
	done
done
```

执行脚本，输出结果如下所示：

```bash
$ ./test19
Outer loop: 1
   Inner loop: 1
   Inner loop: 2
   Inner loop: 3
   Inner loop: 4
Outer loop: 2
   Inner loop: 1
   Inner loop: 2
   Inner loop: 3
   Inner loop: 4
Outer loop: 3
   Inner loop: 1
   Inner loop: 2
   Inner loop: 3
   Inner loop: 4
```

内层循环里的 for 语句指明当变量 b 的值等于 100 时停止迭代。但其中的 if-then 语句指
明当变量 b 的值等于 5 时执行 break 命令。注意，即使 break 命令结束了内层循环，外层循环
依然会继续执行。


**跳出外层循环**

有时你位于内层循环，但需要结束外层循环。break 命令接受单个命令行参数：

```
break n
```

其中 n 指定了要跳出的循环层级。在默认情况下，n 为 1，表明跳出的是当前循环。
如果将 n 设为 2，那么 break 命令就会停止下一级的外层循环：

来看一个例子：

```bash
#!/bin/bash
# breaking out of a outer loop

for ((a = 1; a < 4; a++))
do
	echo "Outer loop: $a"
	for ((b = 1; b < 100; b++))
	do
		if [ $b -gt 4 ]
		then
			break 2
		fi
		echo "   Inner loop: $b"
	done
done
```

执行脚本，输出结果如下所示：

```bash
$ ./test20
Outer loop: 1
   Inner loop: 1
   Inner loop: 2
   Inner loop: 3
   Inner loop: 4
```

注意，当 shell 执行了 break 命令后，外部循环就结束了。


### 参考资料:
- 《Linux Command Line and Shell Scripting Bible》: Chapter 13: More Structured Commands
