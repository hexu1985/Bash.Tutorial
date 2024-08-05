### 显示消息

大多数 shell 命令会产生自己的输出，这些输出会显示在脚本所运行的控制台显示器上。
很多时候，你可能想添加自己的文本消息来告诉用户脚本正在做什么。可以通过 echo 命令来实现这一点。
如果在 echo 命令后面加上字符串，那么 echo 命令就会显示出这个字符串：

```
$ echo This is a test
This is a test
$
```

注意，在默认情况下，无须使用引号将要显示的字符串划定出来。
然而，如果在字符串中使用引号，则有时会比较麻烦：

```
$ echo Let's see if this'll work
Lets see if thisll work
$
```

echo 命令可用单引号或双引号来划定字符串。
如果你在字符串中要用到某种引号，可以使用另一种引号来划定字符串：

```
$ echo "This is a test to see if you're paying attention"
This is a test to see if you're paying attention
$ echo 'Rich says "scripting is easy".'
Rich says "scripting is easy".
$
```

可以将 echo 命令添加到 shell 脚本中任何需要显示额外信息的地方：

```bash
#!/bin/bash
# This script displays the date and who's logged on

echo The time and date are:
date

echo "Let's see who's logged into the system:"
who
```

运行这个脚本时，会产生如下输出：

```
$ ./02-use-echo
The time and date are:
2024年 08月 05日 星期一 18:11:20 CST
Let's see who's logged into the system:
hexu     :1           2024-07-25 12:04 (:1)
```

如果想把字符串和命令输出显示在同一行中，可以使用 echo 命令的-n 选项。
只要将第一个 echo 改成下面这样就可以了：

```
echo -n "The time and date are: "
```

你需要在字符串的两侧使用引号，以确保要显示的字符串尾部有一个空格。
命令输出会在紧接着字符串结束的地方出现。现在的输出会是下面这个样子：

```
$ ./03-echo-without-newline
The time and date are: 2024年 08月 05日 星期一 18:11:22 CST
Let's see who's logged into the system:
hexu     :1           2024-07-25 12:04 (:1)
```

### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 11.3 显示消息
