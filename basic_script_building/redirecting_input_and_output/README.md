### 重定向输入和输出

有时候，你想要保存命令的输出而不只是在屏幕上显示。bash shell 提供了几个运算符，
它们可以将命令的输出重定向到其他位置（比如文件）。重定向既可用于输入，也可用于输出，
例如将文件重定向，作为命令输入。

最基本的重定向会将命令的输出发送至文件。bash shell 使用大于号（`>`）来实现该操作：

```
command > outputfile
```

之前出现在显示器上的命令输出会被保存到指定的输出文件中：

```
$ date > test6
$ ls -l test6
-rw-rw-r-- 1 hexu hexu 43 8月   7 14:22 test6
$ cat test6
2024年 08月 07日 星期三 14:22:15 CST
$
```

重定向运算符创建了文件 test6（使用默认的 umask 设置）并将 date 命令的输出重定向至该文件。
如果输出文件已存在，则重定向运算符会用新数据覆盖已有的文件：

```
$ who > test6
$ cat test6
hexu     :1           2024-07-25 12:04 (:1)
$
```

现在 test6 文件的内容包含 who 命令的输出。

有时，你可能并不想覆盖文件原有内容，而是想将命令输出追加到已有文件中，
例如，你正在创建一个记录系统操作的日志文件。
在这种情况下，可以用双大于号（`>>`）来追加数据：

```
$ date >> test6
$ cat test6
hexu     :1           2024-07-25 12:04 (:1)
2024年 08月 07日 星期三 14:24:37 CST
$
```

test6 文件仍然包含早些时候 who 命令的数据，现在又追加了 date 命令的输出。


输入重定向和输出重定向正好相反。输入重定向会将文件的内容重定向至命令，而不是将命令输出重定向至文件。

输入重定向运算符是小于号（`<`）：

```
command < inputfile
```

一种简单的记忆方法是，在命令行中，命令总是在左侧，而重定向运算符“指向”数据流动的方向。
小于号说明数据正在从输入文件流向命令。下面是一个和 wc 命令一起使用输入重定向的例子。

```
$ wc < test6
 2 11 87
$
```

wc 命令可以统计数据中的文本。在默认情况下，它会输出 3 个值。
- 文本的行数
- 文本的单词数
- 文本的字节数

通过将文本文件重定向到 wc 命令，立刻就可以得到文件中的行、单词和字节的数量。
这个例子说明 test6 文件包含 2 行、11 个单词以及 87 字节。

还有另外一种输入重定向的方法，称为内联输入重定向（inline input redirection）。
这种方法无须使用文件进行重定向，只需在命令行中指定用于输入重定向的数据即可。

内联输入重定向运算符是双小于号（`<<`）。
除了这个符号，必须指定一个文本标记来划分输入数据的起止。
任何字符串都可以作为文本标记，但在数据开始和结尾的文本标记必须一致：

```
command << marker
data
marker
```

在命令行中使用内联输入重定向时，shell 会用 PS2 环境变量中定义的次提示符来提示输入数据，
其用法如下所示：

```
$ wc << EOF
> test string 1
> test string 2
> test string 3
> EOF
 3 9 42
$
```

次提示符会持续显示，以获取更多的输入数据，直到输入了作为文本标记的那个字符串。
wc 命令会统计内联输入重定向提供的数据包含的行数、单词数和字节数。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 11.5 重定向输入和输出
