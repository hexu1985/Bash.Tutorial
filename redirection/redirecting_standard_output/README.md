### 标准输出重定向

STDOUT 文件描述符代表 shell 的标准输出。在终端界面上，标准输出就是终端显示器。
shell的所有输出（包括 shell 中运行的程序和脚本）会被送往标准输出，也就是显示器。

在默认情况下，大多数 bash 命令会将输出送往 STDOUT 文件描述符。可以用输出重定向来更改此设置：

```bash
$ ls -l > test2
$ cat test2
总计 48
drwxrwxr-x  6 hexu hexu 4096 10月 11 10:56 arrays
drwxrwxr-x  9 hexu hexu 4096 10月 11 10:56 basic_script_building
drwxrwxr-x 10 hexu hexu 4096  2月 26 20:07 creating_functions
drwxrwxr-x  7 hexu hexu 4096  2月 17 22:20 examples
drwxrwxr-x  6 hexu hexu 4096  2月 26 17:54 getting_user_input
drwxrwxr-x  8 hexu hexu 4096  2月 26 17:54 more_structured_commands
drwxrwxr-x  8 hexu hexu 4096  2月 26 17:54 positional_parameters
-rw-rw-r--  1 hexu hexu 3991  2月 26 20:07 README.md
drwxrwxr-x  3 hexu hexu 4096  2月 26 20:37 redirection
-rw-rw-r--  1 hexu hexu    0  2月 26 20:42 test2
drwxrwxr-x  5 hexu hexu 4096 10月 11 10:56 using_environment_variables
drwxrwxr-x 13 hexu hexu 4096 10月 11 10:56 using_structured_commands
drwxrwxr-x  9 hexu hexu 4096 10月 11 10:56 using_variables
```

通过输出重定向符（ `>` ），原本应该出现在屏幕上的所有输出被 shell 重定向到了指定的文件。
也可以使用 `>>` 将数据追加到某个文件：

```bash
$ who >> test2
hexu@hexu-Aspire-TC-600:~/git/Bash.Tutorial$ cat test2
总计 48
drwxrwxr-x  6 hexu hexu 4096 10月 11 10:56 arrays
drwxrwxr-x  9 hexu hexu 4096 10月 11 10:56 basic_script_building
drwxrwxr-x 10 hexu hexu 4096  2月 26 20:07 creating_functions
drwxrwxr-x  7 hexu hexu 4096  2月 17 22:20 examples
drwxrwxr-x  6 hexu hexu 4096  2月 26 17:54 getting_user_input
drwxrwxr-x  8 hexu hexu 4096  2月 26 17:54 more_structured_commands
drwxrwxr-x  8 hexu hexu 4096  2月 26 17:54 positional_parameters
-rw-rw-r--  1 hexu hexu 3991  2月 26 20:07 README.md
drwxrwxr-x  3 hexu hexu 4096  2月 26 20:37 redirection
-rw-rw-r--  1 hexu hexu    0  2月 26 20:42 test2
drwxrwxr-x  5 hexu hexu 4096 10月 11 10:56 using_environment_variables
drwxrwxr-x 13 hexu hexu 4096 10月 11 10:56 using_structured_commands
drwxrwxr-x  9 hexu hexu 4096 10月 11 10:56 using_variables
hexu     tty2         2025-02-13 21:36 (tty2)
hexu     pts/4        2025-02-26 19:12 (192.168.50.103)
hexu     pts/5        2025-02-26 19:13 (192.168.50.103)
```

who 命令生成的输出被追加到了 test2 文件中已有数据之后。

但是，如果对脚本使用标准输出重定向，就会遇到一个问题。来看下面的例子：

```bash
$ ls -al badfile > test3
ls: 无法访问 'badfile': 没有那个文件或目录
$ cat test3
$
```

当命令产生错误消息时，shell 并未将错误消息重定向到指定文件。shell 创建了输出重定向
文件，但错误消息依然显示在屏幕上。注意，在查看 test3 文件的内容时，里面没有错误消息。
test3文件创建成功了，但里面空无一物。

shell 对于错误消息的处理是跟普通输出分开的。如果你创建了一个在后台运行的 shell 脚本，
则通常必须依赖发送到日志文件的输出消息。
用这种方法的话，如果出现错误消息，这些消息也不会出现在日志文件中，因此需要换一种方法来处理。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 15.1.1 标准文件描述符

