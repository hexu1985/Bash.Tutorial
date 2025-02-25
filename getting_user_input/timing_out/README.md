### 输入超时

使用 read 命令时要当心。脚本可能会一直苦等着用户输入。
如果不管是否有数据输入，脚本都必须继续执行，你可以用 `-t` 选项来指定一个计时器。
`-t` 选项会指定 read 命令等待输入的秒数。如果计时器超时，则 read 命令会返回非 0 退出状态码：

```bash
#!/bin/bash
# Using the read command with a timer
#
if read -t 5 -p "Enter your name: " name
then
    echo "Hello $name, welcome to my script."
else
    echo
    echo "Sorry, no longer waiting for name."
fi
exit
```

执行脚本，输出结果如下所示：

```bash
$ ./27-timing-the-data-entry
Enter your name: He Xu
Hello He Xu, welcome to my script.
$
$ ./27-timing-the-data-entry
Enter your name:
Sorry, no longer waiting for name.
```

我们可以据此（如果计时器超时，则 read 命令会返回非 0 退出状态码）
使用标准的结构化语句（比如 if-then 语句或 while 循环）来轻松地梳理所发生的具体情况。
在本例中，计时器超时，if 语句不成立，shell 执行的是 else 部分的命令。

你也可以不对输入过程计时，而是让 read 命令统计输入的字符数。
当字符数达到预设值时，就自动退出，将已输入的数据赋给变量：

```bash
#!/bin/bash
# Using the read command for one character
#
read -n 1 -p "Do you want to continue [Y/N]? " answer
#
case $answer in
    Y | y) echo
        echo "Okay. Continue on...";;
    N | n) echo
        echo "Okay. Goodbye"
        exit;;
esac
echo "This is the end of the script."
exit
```

执行脚本，输出结果如下所示：

```bash
$ ./28-getting-just-one-character-of-input
Do you want to continue [Y/N]? y
Okay. Continue on...
This is the end of the script.
$
$ ./28-getting-just-one-character-of-input
Do you want to continue [Y/N]? n
Okay. Goodbye
```

本例中使用了-n 选项和数值 1，告诉 read 命令在接收到单个字符后退出。
只要按下单个字符进行应答，read 命令就会接受输入并将其传给变量，无须按 Enter 键。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 14.6.2 超时

