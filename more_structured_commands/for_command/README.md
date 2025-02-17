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
在这些命令中，`$var` 变量包含着此次迭代对应的列表中的当前值。

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
$ ./01-basic-for-command
The next state is Alabama
The next state is Alaska
The next state is Arizona
The next state is Arkansas
The next state is California
The next state is Colorado
```

每次遍历值列表时，for 命令会将列表中的下一个值赋给 `$test` 变量。`$test` 变量可以像
for 命令语句中的其他脚本变量一样使用。

注意：在最后一次迭代结束后，`$test` 变量的值在 shell 脚本的剩余部分依然有效。
它会一直保持最后一次迭代时的值（除非做了修改）。

```bash
#!/bin/bash
# testing for variable after the looping
for test in Alabama Alaska Arizona Arkansas California Colorado
do
	echo The next state is $test
done
echo "The last state we visited was $test"
test=Connecticut
echo "Wait, now we're visiting $test"
```

执行脚本，输出结果如下所示：

```bash
$ ./02-testing-for-variable-after-the-looping
The next state is Alabama
The next state is Alaska
The next state is Arizona
The next state is Arkansas
The next state is California
The next state is Colorado
The last state we visited was Colorado
Wait, now we're visiting Connecticut
```

`$test` 变量保持着它的值，也允许我们对其做出修改，在 for 循环之外跟其他变量一样使用。


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
$ ./07-using-a-variable-to-hold-the-list
Have you ever visited Alabama?
Have you ever visited Alaska?
Have you ever visited Arizona?
Have you ever visited Arkansas?
Have you ever visited Colorado?
Have you ever visited Connecticut?
```

`$list` 变量包含了用于迭代的值列表。

**从命令中读取值列表**

生成值列表的另一种途径是使用命令的输出。你可以用命令替换来执行任何能产生输出的命令，
然后在 for 命令中使用该命令的输出：

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
$ cat states.txt
Alabama
Alaska
Arizona
Arkansas
Colorado
Connecticut
Delaware
Florida
Georgia
New Mexico
New York
New Hampshire
North Carolina
$ ./08-reading-values-from-a-file-command-substitution
Visit beautiful Alabama
Visit beautiful Alaska
Visit beautiful Arizona
Visit beautiful Arkansas
Visit beautiful Colorado
Visit beautiful Connecticut
Visit beautiful Delaware
Visit beautiful Florida
Visit beautiful Georgia
Visit beautiful New
Visit beautiful Mexico
Visit beautiful New
Visit beautiful York
Visit beautiful New
Visit beautiful Hampshire
Visit beautiful North
Visit beautiful Carolina
```

这个例子在命令替换中使用 cat 命令来输出文件 states.txt 的内容。
注意，states.txt 文件中每个值各占一行，而不是以空格分隔。
前面我们知道for 命令使用空格来划分列表中的每个值。
如果你列出了一个名字中有空格的州，则 for 命令仍然会用空格来分隔值。

造成这个问题的原因是特殊的环境变量 IFS（internal field separator，内部字段分隔符）。
IFS 环境变量定义了 bash shell 用作字段分隔符的一系列字符。
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

将该语句加入脚本，告诉 bash shell 忽略数据中的空格和制表符。对前一个脚本使用这种方法

```bash
#!/bin/bash
# reading values from a file

file="states.txt"

IFS=$'\n'
for state in $(cat $file)
do
	echo "Visit beautiful $state"
done
```

执行脚本，输出结果如下所示：

```bash
$ ./09-reading-values-from-a-file-changing-ifs
Visit beautiful Alabama
Visit beautiful Alaska
Visit beautiful Arizona
Visit beautiful Arkansas
Visit beautiful Colorado
Visit beautiful Connecticut
Visit beautiful Delaware
Visit beautiful Florida
Visit beautiful Georgia
Visit beautiful New Mexico
Visit beautiful New York
Visit beautiful New Hampshire
Visit beautiful North Carolina
```

如果要指定多个 IFS 字符，则只需在赋值语句中将这些字符写在一起即可：

```bash
IFS=$'\n:;"'
```

该语句会将换行符、冒号、分号和双引号作为字段分隔符。


**使用通配符读取目录**

还可以用 for 命令来自动遍历目录中的文件。为此，必须在文件名或路径名中使用通配符，
这会强制 shell 使用 **文件名通配符匹配** （file globbing）。文件名通配符匹配是生成与指定
通配符匹配的文件名或路径名的过程。

在处理目录中的文件时，如果不知道所有的文件名，上述特性是非常好用的：

```bash
#!/bin/bash
# iterate through all the files in a directory

for file in /tmp/*
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
$ ./11-iterate-through-all-the-files-in-a-directory
/tmp/aaa.txt is a file
/tmp/a.txt is a file
/tmp/b.txt is a file
/tmp/build_by_cmake.sh is a file
/tmp/cfw-parser.log is a file
/tmp/config-err-rc0lRr is a file
/tmp/create_test_field.sh is a file
/tmp/{F2C055CA-F026-4A34-903D-8810BDB16CA8} is a directory
/tmp/msp_manager_base.cpp is a file
/tmp/output.txt is a file
/tmp/phicyber.cpp is a file
/tmp/print_dump_field.sh is a file
/tmp/scoped_dircOvhmP is a directory
/tmp/snap-private-tmp is a directory
/tmp/ssh-RKkM3mak0Bqr is a directory
/tmp/swap_two_word.sh is a file
/tmp/systemd-private-4a9e2324d192417c8b4b2954b1538fb6-colord.service-YmEOZh is a directory
/tmp/systemd-private-4a9e2324d192417c8b4b2954b1538fb6-ModemManager.service-M7Jrog is a directory
/tmp/systemd-private-4a9e2324d192417c8b4b2954b1538fb6-switcheroo-control.service-cpRACf is a directory
/tmp/systemd-private-4a9e2324d192417c8b4b2954b1538fb6-systemd-logind.service-00O5Bg is a directory
/tmp/systemd-private-4a9e2324d192417c8b4b2954b1538fb6-systemd-resolved.service-l5uC3h is a directory
/tmp/systemd-private-4a9e2324d192417c8b4b2954b1538fb6-systemd-timesyncd.service-DahmMg is a directory
/tmp/systemd-private-4a9e2324d192417c8b4b2954b1538fb6-upower.service-5A353i is a directory
/tmp/test.txt is a file
/tmp/Topic_Index_define.c is a file
/tmp/tracker-extract-files.1000 is a directory
/tmp/tracker-extract-files.126 is a directory
/tmp/update_Cdr_Cfg_CDR.sh is a file
/tmp/vscode-typescript1000 is a directory
/tmp/vwr_log_conf.json is a file
```

for 命令会遍历 `/tmp/*` 匹配的结果。脚本用 test 命令测试了每个匹配条目（使用方括号方法），
测试其是目录（通过`-d`）还是文件（通过`-f`）

### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 13.1 for命令
