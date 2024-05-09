### 处理循环的输出

在 shell 脚本中，可以对循环的输出使用管道或进行重定向。这可以通过在 done 命令之后
添加一个处理命令来实现：

例如：

```shell
for file in /home/rich/*
do
    if [ -d "$file" ]
    then
        echo "$file is a directory"
    elif
        echo "$file is a file"
    fi
done > output.txt
```

shell 会将 for 命令的结果重定向至文件 output.txt，而不再显示在屏幕上。

考虑下面这个将 for 命令的输出重定向至文件的例子：

```shell
#!/bin/bash

# redirecting the for output to a file

file=test.txt
echo "Writing to $file ..."

for ((a = 1; a < 10; a++))
do
	echo "The number is $a"
done > $file
echo "The command is finished."
```

执行脚本，输出结果如下所示：

```shell
$ ./test23
Writing to test.txt ...
The command is finished.
$ cat test.txt
The number is 1
The number is 2
The number is 3
The number is 4
The number is 5
The number is 6
The number is 7
The number is 8
The number is 9
```

shell 创建了文件 test.txt 并将 for 命令的输出重定向至该文件。
for 命令结束之后，shell 一如往常地显示了 echo 语句。

这种方法同样适用于将循环的结果传输到另一个命令：

```shell
#!/bin/bash

# piping a loop to another command

for state in "North Dakota" Connecticut Illinois Alabama Tennessee
do
	echo "$state is the next place to go"
done | sort
echo "This completes our travels"
```

执行脚本，输出结果如下所示：

```shell
$ ./test24
Alabama is the next place to go
Connecticut is the next place to go
Illinois is the next place to go
North Dakota is the next place to go
Tennessee is the next place to go
This completes our travels
```

for 命令的输出通过管道传给了 sort 命令，由后者对输出结果进行排序。运行该脚本，
可以看出结果已经按 state 的值排好序了。


### 参考资料:
- 《Linux Command Line and Shell Scripting Bible》: Chapter 13: More Structured Commands


