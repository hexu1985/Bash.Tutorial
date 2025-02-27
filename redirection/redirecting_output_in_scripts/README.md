### 在脚本中重定向输出

只需简单地重定向相应的文件描述符，就可以在脚本中用文件描述符 STDOUT 和 STDERR 在多个位置生成输出。
在脚本中重定向输出的方法有两种。
- 临时重定向每一行。
- 永久重定向脚本中的所有命令。

**临时重定向**

如果你有意在脚本中生成错误消息，可以将单独的一行输出重定向到 STDERR。
这只需要使用输出重定向符号将输出重定向到 STDERR 文件描述符。
在重定向到文件描述符时，必须在文件描述符索引值之前加一个 `&`：

```bash
echo "This is an error message" >&2
```

这行会在脚本的 STDERR 文件描述符所指向的位置显示文本。下面这个例子就使用了这项功能：

```bash
#!/bin/bash
# testing STDERR messages

echo "This is an error" >&2
echo "This is normal output"
```

如果像平常一样运行这个脚本，你看不出任何区别：

```bash
$ ./01-testing-stderr-messages 
This is an error
This is normal output
```

记住，在默认情况下，STDERR 和 STDOUT 指向的位置是一样的。
但是，如果在运行脚本时重定向了 STDERR，那么脚本中所有送往 STDERR 的文本都会被重定向：

```bash
$ ./01-testing-stderr-messages 2> test
This is normal output
$ cat test
This is an error
```

通过 STDOUT 显示的文本出现在了屏幕上，而送往 STDERR 的 echo 语句的文本则被重定向到了输出文件。
这种方法非常适合在脚本中生成错误消息。脚本用户可以像上面的例子中那样，直接通过 STDERR 文件描述符重定向错误消息。


**永久重定向**

如果脚本中有大量数据需要重定向，那么逐条重定向所有的 echo 语句会很烦琐。
这时可以用 exec 命令，它会告诉 shell 在脚本执行期间重定向某个特定文件描述符：

```bash
#!/bin/bash
# redirecting all output to a file
exec 1>testout

echo "This is a test of redirecting all output"
echo "from a script to another file."
echo "Without having to redirect every individual line"
```

执行脚本，输出结果如下所示：

```bash
$ ./02-redirecting-all-output-to-a-file
$ cat testout
This is a test of redirecting all output
from a script to another file.
Without having to redirect every individual line
```

exec 命令会启动一个新 shell 并将 STDOUT 文件描述符重定向到指定文件。
脚本中送往 STDOUT 的所有输出都会被重定向。

也可以在脚本执行过程中重定向 STDOUT：

```bash
#!/bin/bash
# redirecting output to different locations

exec 2>testerror

echo "This is the start of the script"
echo "now redirecting all output to another location"

exec 1>testout

echo "This output should go to the testout file"
echo "but this should go to the testerror file" >&2
```

执行脚本，输出结果如下所示：

```bash
$ ./03-redirecting-output-to-different-locations
This is the start of the script
now redirecting all output to another location
$ cat testout
This output should go to the testout file
$ cat testerror
but this should go to the testerror file
```

该脚本使用 exec 命令将送往 STDERR 的输出重定向到了文件 testerror。
接下来，脚本用 echo 语句向 STDOUT 显示了几行文本。随后再次使用 exec 命令将 STDOUT 重定向到 testout 文件。
注意，尽管 STDOUT 被重定向了，仍然可以将 echo 语句的输出发送给 STDERR，在本例中仍是重定向到 testerror 文件。

当只想将脚本的部分输出重定向到其他位置（比如错误日志）时，这个特性用起来非常方便。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 15.2 在脚本中重定向输出
