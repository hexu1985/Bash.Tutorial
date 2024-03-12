### for 命令

bash shell 提供了 for 命令，以允许创建遍历一系列值的循环。每次迭代都使用其中一个值
来执行已定义好的一组命令。for 命令的基本格式如下：

```bash
for var in list
do
    commands
done
```

你需要提供用于迭代的一系列值作为 list 参数。指定这些值的方法不止一种。

在每次迭代中，变量 var 会包含列表中的当前值。
第一次迭代使用列表中的第一个值，第二次迭代使用列表中的第二个值，以此类推，直到用完列表中的所有值。

do 语句和 done 语句之间的 commands 可以是一个或多个标准的 bash shell 命令。
在这些命令中，$var 变量包含着此次迭代对应的列表中的当前值。

有几种方式可以指定列表中的值：
- 读取列表中的值
- 从变量中读取值列表
- 从命令中读取值列表
- 使用通配符读取目录

下面分别举例介绍：

**读取列表中的值**

for 命令最基本的用法是遍历其自身所定义的一系列值：

```bash
#!/bin/bash
# basic for command
for test in Alabama Alaska Arizona Arkansas California Colorado
do
    echo The next state is $test
done
```

执行脚本，输出结果如下所示：

```bash
$ ./test1
The next state is Alabama
The next state is Alaska
The next state is Arizona
The next state is Arkansas
The next state is California
The next state is Colorado
```

每次遍历值列表时，for 命令会将列表中的下一个值赋给$test 变量。$test 变量可以像
for 命令语句中的其他脚本变量一样使用。

注意：在最后一次迭代结束后，$test 变量的值在 shell 脚本的剩余部分依然有效。
它会一直保持最后一次迭代时的值（除非做了修改）。

另外：for 命令使用空格来划分列表中的每个值。如果某个值含有空格，则必须将其放入双引号内。


**从变量中读取值列表**

在 shell 脚本中经常遇到的情况是，你将一系列值集中保存在了一个变量中，然后需要遍历
该变量中的整个值列表。可以通过 for 命令完成这个任务：

```bash
#!/bin/bash
# using a variable to hold the list
list="Alabama Alaska Arizona Arkansas Colorado"
list=$list" Connecticut"
for state in $list
do
    echo "Have you ever visited $state?"
done
```

执行脚本，输出结果如下所示：

```bash
$ ./test4
Have you ever visited Alabama?
Have you ever visited Alaska?
Have you ever visited Arizona?
Have you ever visited Arkansas?
Have you ever visited Colorado?
Have you ever visited Connecticut?
```

$list 变量包含了用于迭代的值列表。

**从命令中读取值列表**

生成值列表的另一种途径是使用命令的输出。你可以用命令替换来执行任何能产生输出的命令，
然后在 for 命令中使用该命令的输出：

下面这个例子在命令替换中使用 seq 命令来生成1-10的数字数组：

```bash
#!/bin/bash

for i in $(seq 1 10)
do
	echo "The next number is: $i"
done
```

执行脚本，输出结果如下所示：

```bash
$ ./for-loop-use-seq.sh
The next number is: 1
The next number is: 2
The next number is: 3
The next number is: 4
The next number is: 5
The next number is: 6
The next number is: 7
The next number is: 8
The next number is: 9
The next number is: 10
```

下面这个例子在命令替换中使用 cat 命令来输出文件 states.txt 的内容。

states.txt如下：

```
Alabama
Alaska
Arizona
Arkansas
Colorado
Connecticut
Delaware
Florida
Georgia
```

bash脚本如下：

```bash
#!/bin/bash
# reading values from a file
file="states.txt"
for state in $(cat $file)
do
    echo "Visit beautiful $state"
done
```

执行脚本，输出结果如下所示：

```bash
$ ./test5
Visit beautiful Alabama
Visit beautiful Alaska
Visit beautiful Arizona
Visit beautiful Arkansas
Visit beautiful Colorado
Visit beautiful Connecticut
Visit beautiful Delaware
Visit beautiful Florida
Visit beautiful Georgia
```

注意，states.txt 文件中每个值各占一行，而不是以空格分隔。
前面我们知道for 命令使用空格来划分列表中的每个值。
如果你列出了一个名字中有空格的州，则 for 命令仍然会用空格来分隔值。

这种情况的修复方式可以通过更改字段分隔符来实现。

IFS（internal field separator，内部字段分隔符）环境变量定义了 bash shell 用作字段分隔符的一系列字符。
在默认情况下，bash shell 会将下列字符视为字段分隔符。
- 空格
- 制表符
- 换行符
如果 bash shell 在数据中看到了这些字符中的任意一个，那么它就会认为这是列表中的一个新字段的开始。

解决这个问题的办法是在 shell脚本中临时更改 IFS 环境变量的值来限制被 bash shell 视为字段分隔符的字符。
如果想修改 IFS 的值，使其只能识别换行符，可以这么做：

```bash
IFS=$'\n'
```

如果要指定多个 IFS 字符，则只需在赋值语句中将这些字符写在一起即可：

```bash
IFS=$'\n:;"'
```

该语句会将换行符、冒号、分号和双引号作为字段分隔符。


**使用通配符读取目录**

还可以用 for 命令来自动遍历目录中的文件。为此，必须在文件名或路径名中使用通配符，
这会强制 shell 使用文件名通配符匹配（file globbing）。文件名通配符匹配是生成与指定
通配符匹配的文件名或路径名的过程。

在处理目录中的文件时，如果不知道所有的文件名，上述特性是非常好用的：

下面这个例子中，for 命令会遍历/home/rich/test/*匹配的结果：

```bash
#!/bin/bash
# iterate through all the files in a directory
for file in /home/rich/test/*
do
    if [ -d "$file" ]
    then
        echo "$file is a directory"
    elif [ -f "$file" ]
    then
        echo "$file is a file"
    fi
done
```

执行脚本，输出结果如下所示：

```bash
$ ./test6
/home/rich/test/dir1 is a directory
/home/rich/test/myprog.c is a file
/home/rich/test/myprog is a file
/home/rich/test/myscript is a file
/home/rich/test/newdir is a directory
/home/rich/test/newfile is a file
/home/rich/test/newfile2 is a file
/home/rich/test/testdir is a directory
/home/rich/test/testing is a file
/home/rich/test/testprog is a file
/home/rich/test/testprog.c is a file
```

### 参考资料:
- 《Linux Command Line and Shell Scripting Bible》: Chapter 13: More Structured Commands
