### 创建自己的重定向

在脚本中重定向输入和输出时，并不局限于这 3 个默认的文件描述符。在 shell 中最多可以打开 9 个文件描述符。
替代性文件描述符从 3 到 8 共 6 个，均可用作输入或输出重定向。这些文件描述符中的任意一个都可以分配给文件并用在脚本中。

**创建输出文件描述符**

可以用 exec 命令分配用于输出的文件描述符。和标准的文件描述符一样，一旦将替代性文件描述符指向文件，
此重定向就会一直有效，直至重新分配。来看一个在脚本中使用替代性文件描述符的简单例子：

```bash
#!/bin/bash
# using an alternative file descriptor

exec 3>test13out

echo "This should display on the monitor"
echo "and this should be stored in the file" >&3
echo "Then this should be back on the monitor"
```

执行脚本，输出结果如下所示：

```bash
$ ./05-using-an-alternative-file-descriptor
This should display on the monitor
Then this should be back on the monitor
$ cat test13out
and this should be stored in the file
```

这个脚本使用 exec 命令将文件描述符 3 重定向到了另一个文件。当脚本执行 echo 语句时，
文本会像预想中那样显示在 STDOUT 中。但是，重定向到文件描述符 3 的那行 echo 语句的输出进入了另一个文件。
这样就可以维持显示器的正常输出，并将特定信息重定向到指定文件（比如日志文件）。

也可以不创建新文件，而是使用 exec 命令将数据追加到现有文件：

```bash
exec 3>>test13out
```

现在，输出会被追加到 test13out 文件，而不是创建一个新文件。


**重定向文件描述符**

有一个技巧能帮助你恢复已重定向的文件描述符。你可以将另一个文件描述符分配给标准文件描述符，反之亦可。
这意味着可以将 STDOUT 的原先位置重定向到另一个文件描述符，然后再利用该文件描述符恢复 STDOUT。
这听起来可能有点儿复杂，但实际上并不难。来看一个例子：

```bash
#!/bin/bash
# storing STDOUT, then coming back to it

exec 3>&1
exec 1>test14out

echo "This should store in the output file"
echo "along with this line."

exec 1>&3

echo "Now things should be back to normal"
```

执行脚本，输出结果如下所示：

```bash
$ ./06-storing-stdout-then-coming-back-to-it
Now things should be back to normal
$ cat test14out
This should store in the output file
along with this line.
```

第一个 exec 命令将文件描述符 3 重定向到了文件描述符 1（STDOUT）的当前位置，也就是显示器。
这意味着任何送往文件描述符 3 的输出都会出现在屏幕上。

第二个 exec 命令将 STDOUT 重定向到了文件，shell 现在会将发送给 STDOUT 的输出直接送往该文件。
但是，文件描述符 3 仍然指向 STDOUT 原先的位置（显示器）。
如果此时将输出数据发送给文件描述符 3，则它仍然会出现在显示器上，即使 STDOUT 已经被重定向了。

向 STDOUT（现在指向一个文件）发送一些输出之后，
第三个 exec 命令将 STDOUT 重定向到了文件描述符 3 的当前位置（现在仍然是显示器）。
这意味着现在 STDOUT 又恢复如初了，即指向其原先的位置——显示器。


**创建输入文件描述符**

可以采用和重定向输出文件描述符同样的办法来重定向输入文件描述符。
在重定向到文件之前，先将 STDIN 指向的位置保存到另一个文件描述符，
然后在读取完文件之后将 STDIN 恢复到原先的位置：

```bash
#!/bin/bash
# redirecting input file descriptors

exec 6<&0

exec 0< testfile

count=1
while read line
do
	echo "Line #$count: $line"
	count=$[ $count + 1 ]
done
exec 0<&6

read -n 1 -p "Are you done now? (Y/n) " answer
echo

case $answer in
	Y|y) echo "Goodbye"
	;;
    *) echo "Sorry, this is the end."
	;;
esac
```

执行脚本，输出结果如下所示：

```bash
$ ./07-redirecting-input-file-descriptors
Line #1: This is the first line.
Line #2: This is the second line.
Line #3: This is the third line.
Are you done now? (Y/n) y
Goodbye
```

在这个例子中，文件描述符 6 用于保存 STDIN 指向的位置。然后脚本将 STDIN 重定向到一个文件。
read 命令的所有输入都来自重定向后的 STDIN（也就是输入文件）。

在读完所有行之后，脚本会将 STDIN 重定向到文件描述符 6，恢复 STDIN 原先的位置。
该脚本使用另一个 read 命令来测试 STDIN 是否恢复原位，这次 read 会等待键盘的输入。


**创建读/写文件描述符**

尽管看起来可能很奇怪，但你也可以打开单个文件描述符兼做输入和输出，
这样就能用同 个文件描述符对文件进行读和写两种操作了。

但使用这种方法时要特别小心。由于这是对一个文件进行读和写两种操作，因此 shell 会维护一个内部指针，
指明该文件的当前位置。任何读或写都会从文件指针上次的位置开始。
如果粗心的话，这会产生一些令人瞠目的结果。来看下面这个例子：

```bash
#!/bin/bash
# testing input/output file descriptor

exec 3<> testfile
read line <&3
echo "Read: $line"
echo "This is a test line" >&3
```

执行脚本，输出结果如下所示：

```bash
$ cat testfile
This is the first line.
This is the second line.
This is the third line.
$ ./08-testing-input-output-file-descriptor
Read: This is the first line.
$ cat testfile
This is the first line.
This is a test line
ine.
This is the third line.
```

在这个例子中，exec 命令将文件描述符 3 用于文件 testfile 的读和写。
接下来，使用分配好的文件描述符，通过 read 命令读取文件中的第一行，然后将其显示在 STDOUT 中。
最后，使用 echo 语句将一行数据写入由同一个文件描述符打开的文件中。

在运行脚本时，一开始还算正常。输出内容表明脚本读取了 testfile 文件的第一行。
但如果在脚本运行完毕后查看 testfile 文件内容，则会发现写入文件中的数据覆盖了已有数据。

当脚本向文件中写入数据时，会从文件指针指向的位置开始。read 命令读取了第一行数据，
这使得文件指针指向了第二行数据的第一个字符。当 echo 语句将数据输出到文件时，
会将数据写入文件指针的当前位置，覆盖该位置上的已有数据。


**关闭文件描述符**

如果创建了新的输入文件描述符或输出文件描述符，那么 shell 会在脚本退出时自动将其关闭。
然而在一些情况下，需要在脚本结束前手动关闭文件描述符。

要关闭文件描述符，只需将其重定向到特殊符号 `&-` 即可。在脚本中如下所示：

```bash
exec 3>&-
```

该语句会关闭文件描述符 3，不再在脚本中使用。下面的例子演示了试图使用已关闭的文件描述符时的情况：

```bash
#!/bin/bash
# testing closing file descriptors

exec 3> test17file

echo "This is a test line of data" >&3

exec 3>&-

echo "This won't work" >&3
```

执行脚本，输出结果如下所示：

```bash
$ ./09-closing-file-descriptors
./09-closing-file-descriptors: 行 10: 3: 错误的文件描述符
$ cat test17file
This is a test line of data
```

一旦关闭了文件描述符，就不能在脚本中向其写入任何数据，否则 shell 会发出错误消息。

在关闭文件描述符时还要注意另一件事。如果随后你在脚本中打开了同一个输出文件，
那么 shell 就会用一个新文件来替换已有文件。这意味着如果你输出数据，它就会覆盖已有文件。
来看下面这个例子：

```bash
#!/bin/bash
# testing closing file descriptors

exec 3> test17file
echo "This is a test line of data" >&3
exec 3>&-

cat test17file

exec 3> test17file
echo "This'll be bad" >&3
```

执行脚本，输出结果如下所示：

```bash
$ ./10-closing-file-descriptors-overwrite
This is a test line of data
$ cat test17file
This'll be bad
```

在向 test17file 文件发送了字符串并关闭该文件描述符之后，脚本会使用 cat 命令显示文件内容。
到这一步的时候，一切都还好。接下来，脚本重新打开了该输出文件并向它发送了另一个字符串。
在显示该文件的内容时，你能看到的就只有第二个字符串。shell 覆盖了原来的输出文件。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 15.4 创建自己的重定向

