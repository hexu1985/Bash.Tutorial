### 标准输入重定向

STDIN 文件描述符代表 shell 的标准输入。对终端界面来说，标准输入就是键盘。
shell 会从 STDIN 文件描述符对应的键盘获得输入并进行处理。

在使用输入重定向符（`<`）时，Linux 会用重定向指定的文件替换标准输入文件描述符。
于是，命令就会从文件中读取数据，就好像这些数据是从键盘键入的。

许多 bash 命令能从 STDIN 接收输入，尤其是在命令行中没有指定文件的情况下。
下面例子使用 cat 命令来处理来自 STDIN 的输入：

```bash
$ cat
this is a test
this is a test
this is a second test.
this is a second test.
```

当在命令行中只输入 cat 命令时，它会从 STDIN 接收输入。输入一行，cat 命令就显示一行。

但也可以通过输入重定向符强制 cat 命令接收来自 STDIN 之外的文件输入：

```bash
$ cat < testfile
This is the first line.
This is the second line.
This is the third line.
```

cat 命令现在从 testfile 文件中获取输入。你可以使用这种技术将数据导入任何能从 STDIN 接收数据的 shell 命令中。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 15.1.1 标准文件描述符

