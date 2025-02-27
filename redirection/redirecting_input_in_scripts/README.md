### 在脚本中重定向输入

可以使用与重定向 STDOUT 和 STDERR 相同的方法，将 STDIN 从键盘重定向到其他位置。
在 Linux 系统中，exec 命令允许将 STDIN 重定向为文件：

```bash
exec 0< testfile
```

该命令会告诉 shell，它应该从文件 testfile 中而不是键盘上获取输入。
只要脚本需要输入，这个重定向就会起作用。来看一个用法示例：

```bash
#!/bin/bash
# redirecting file input

exec 0< testfile
count=1

while read line
do
	echo "Line #$count: $line"
	count=$[ $count + 1 ]
done
```

执行脚本，输出结果如下所示：

```bash
$ ./04-redirecting-file-input
Line #1: This is the first line.
Line #2: This is the second line.
Line #3: This is the third line.
```

将 STDIN 重定向为文件后，当 read 命令试图从 STDIN 读入数据时，就会到文件中而不是键盘上检索数据。

这是一种在脚本中从待处理的文件读取数据的绝妙技术。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 15.3 在脚本中重定向输入

