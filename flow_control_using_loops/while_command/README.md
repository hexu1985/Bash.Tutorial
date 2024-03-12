### while 命令

while 命令允许定义一个要测试的命令，只要该命令返回的退出状态码为 0，
就循环执行一组命令。它会在每次迭代开始时测试 test 命令，
如果 test 命令返回非 0 退出状态码，while 命令就会停止执行循环。

while 命令的格式如下：

```bash
while test command
do
    other commands
done
```

while 命令中定义的 test command 与 if-then 语句中的格式一模一样。
你可以使用任何 bash shell 命令，或者用 test command 进行条件测试，比如测试变量值。

例如，若要按顺序显示1～5这5个数字，就可以构建这样的bash脚本。

```bash
#!/bin/bash

# while-count: display a series of numbers

count=1

while [[ "$count" -le 5 ]]; do
	echo "$count"
	count=$((count + 1))
done
echo "Finished."
```

脚本的执行结果如下所示：

```
$ ./while-count 
1
2
3
4
5
Finished.
```
