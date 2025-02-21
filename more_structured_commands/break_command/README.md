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
$ ./23-breaking-out-of-a-for-loop
Iteration number: 1
Iteration number: 2
Iteration number: 3
Iteration number: 4
The for loop is completed
```

for 循环通常会遍历列表中的所有值。但当满足 if-then 的条件时，
shell 会执行 break 命令，结束 for 循环。

该方法同样适用于 while 循环和 until 循环：


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
$ ./24-breaking-out-of-a-while-loop
Iteration: 1
Iteration: 2
Iteration: 3
Iteration: 4
The while loop is completed
```

如果 if-then 的条件成立，就执行 break 命令，结束 while 循环。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 13.7.1 break命令
