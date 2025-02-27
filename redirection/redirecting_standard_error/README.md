### 标准错误重定向

你已经知道如何用重定向符来重定向 STDOUT 数据。
重定向 STDERR 数据也没太大差别，只要在使用重定向符时指定 STDERR 文件描述符就可以了。
以下是两种实现方法。
- 只重定向错误
- 重定向错误消息和正常输出

**只重定向错误**

STDERR 的文件描述符为 2。可以将该文件描述符索引值放在重定向符号之前，只重定向错误消息。
注意，两者必须紧挨着，否则无法正常工作：

```bash
$ ls -al badfile 2> test4
$ cat test4
ls: 无法访问 'badfile': 没有那个文件或目录
```

现在运行该命令，错误消息就不会出现在屏幕上了。命令生成的任何错误消息都会保存在指定文件中。
用这种方法，shell 只重定向错误消息，而非普通数据。
下面是另一个混合使用 STDOUT 和 STDERR 错误消息的例子：

```bash
$ ls -al test badtest test4 2> test5
-rw-rw-r-- 1 hexu hexu 56 2月  27 16:29 test4
$ cat test5
ls: 无法访问 'test': 没有那个文件或目录
ls: 无法访问 'badtest': 没有那个文件或目录
```

ls 命令尝试列出了 3 个文件（test、badtest 和 test2）的信息。
正常输出被送往默认的 STDOUT 文件描述符，也就是显示器。
由于该命令将文件描述符 2（STDERR）重定向到了一个输出文件，因此 shell 会将产生的所有错误消息直接送往指定文件。


**重定向错误消息和正常输出**

如果想重定向错误消息和正常输出，则必须使用两个重定向符号。
你需要在重定向符号之前放上需要重定向的文件描述符，然后让它们指向用于保存数据的输出文件：

```bash
$ ls -al test test4 test5 badtest 2> test6 1> test7
$ cat test6
ls: 无法访问 'test': 没有那个文件或目录
ls: 无法访问 'badtest': 没有那个文件或目录
$ cat test7
-rw-rw-r-- 1 hexu hexu  56 2月  27 16:29 test4
-rw-rw-r-- 1 hexu hexu 109 2月  27 16:31 test5
```

ls 命令的正常输出本该送往 STDOUT，shell 使用 `1>` 将其重定向到了文件 test7，
而本该送往 STDERR 的错误消息则通过 `2>` 被重定向到了文件 test6。

你可以用这种方法区分脚本的正常输出和错误消息。这样就可以轻松识别错误消息，而不用在成千上万行正常输出中翻找了。

另外，如果愿意，也可以将 STDERR 和 STDOUT 的输出重定向到同一个文件。

有两种实现方法。先来看传统方法，适用于旧版Shell：

```bash 
$ ls -al test test4 test5 badtest > test7 2>&1
$ cat test7
ls: 无法访问 'test': 没有那个文件或目录
ls: 无法访问 'badtest': 没有那个文件或目录
-rw-rw-r-- 1 hexu hexu  56 2月  27 16:29 test4
-rw-rw-r-- 1 hexu hexu 109 2月  27 16:31 test5
```

我们执行了两次重定向。先将标准输出重定向到ls-output.txt，
然后使用2>&1将文件描述符2（标准错误）重定向到文件描述符1（标准输出）。

较新版本的Bash提供了另一种更流畅的方法来实现这种联合重定向：

```bash
$ ls -al test test4 test5 badtest &> test7
$ cat test7
ls: 无法访问 'test': 没有那个文件或目录
ls: 无法访问 'badtest': 没有那个文件或目录
-rw-rw-r-- 1 hexu hexu  56 2月  27 16:29 test4
-rw-rw-r-- 1 hexu hexu 109 2月  27 16:31 test5
```

bash shell 提供了特殊的重定向符 `&>`，当使用 `&>` 时，命令生成的所有输出（正常输出和错误消息）会被送往同一位置。
注意，其中一条错误消息出现的顺序和预想不同。badtest 文件（列出的最后一个文件）的这条错误消息出现在了输出文件的第二行。
为了避免错误消息散落在输出文件中，相较于标准输出，bash shell 自动赋予了错误消息更高的优先级。
这样你就能集中浏览错误消息了。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 15.1.2 重定向错误
- 《Linux命令行大全 第2版》: 6.3 标准错误重定向


