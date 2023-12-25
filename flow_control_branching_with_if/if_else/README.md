### if/else语句

**使用 if-then 语句**

最基本的结构化命令是 if-then 语句。if-then 语句的格式如下：

```bash
if command
then
    commands
fi
```

bash shell 的 if 语句会运行 if 之后的命令。如果该命令的退出状态码为 0（命令成功运行），
那么位于 then 部分的命令就会被执行。如果该命令的退出状态码是其他值，
则 then 部分的命令不会被执行，bash shell 会接着处理脚本中的下一条命令。
fi 语句用来表示if-then 语句到此结束。

下面用一个简单的例子来解释一下这个概念：

```bash
$ cat test1.sh
#!/bin/bash
# testing the if statement
if pwd
then
    echo "it worked"
fi
$
```

该脚本在 if 行中使用了 pwd 命令。如果命令成功结束，那么 echo 语句就会显示字符串。
当你在命令行中运行该脚本时，会得到如下结果：

```bash
$ ./test1.sh
/home/christine/scripts
It worked
$
```
shell 执行了 if 行中的 pwd 命令。由于退出状态码是 0，因此它也执行了 then 部分的 echo 语句。


**if-then-else 语句**

在if-then语句中，不管命令是否成功执行，你都只有一种选择。如果命令返回一个非零退出状态码，
bash shell会继续执行脚本中的下一条命令。在这种情况下，如果能够执行另一组命令就好了。
这正是if-then-else语句的作用。

if-then-else语句在语句中提供了另外一组命令。

```bash
if command
then
    commands
else
    commands
fi
```

当if语句中的命令返回退出状态码0时，then部分中的命令会被执行，这跟普通的if-then语句一样。
当if语句中的命令返回非零退出状态码时，bash shell会执行else部分中的命令。

例如：

```bash
x=5
if [ $x = 5 ]; then
    echo "x equals 5."
else
    echo "x does not equal 5."
fi
```

**嵌套 if**

有时你需要检查脚本代码中的多种条件。对此，可以使用嵌套的if-then语句。
也可以使用else部分的另一种形式：elif。这样就不用再书写多个if-then语句了。
elif使用另一个if-then语句延续else部分。

```bash
if command1
then
    commands
elif command2
then
    more commands
fi
```

elif语句行提供了另一个要测试的命令，这类似于原始的if语句行。如果elif后命令的退出状态码是0，
则bash会执行第二个then语句部分的命令。使用这种嵌套方法，代码更清晰，逻辑更易懂。

可以继续将多个elif语句串起来，形成一个大的if-then-elif嵌套组合。

```bash
if command1
then
    command set 1
elif command2
then
    command set 2
elif command3
then
    command set 3
elif command4
then
    command set 4
fi
```

每块命令都会根据命令是否会返回退出状态码0来执行。记住，bash shell会依次执行if语句，
只有第一个返回退出状态码0的语句中的then部分会被执行。

例如：

```bash
#!/bin/bash
OS=`uname -s`

if [ "$OS" = "FreeBSD" ]; then
  echo "This Is FreeBSD"
elif [ "$OS" = "CYGWIN_NT-5.1" ]; then
  echo "This is Cygwin"
elif [ "$OS" = "SunOS" ]; then
  echo "This is Solaris"
elif [ "$OS" = "Darwin" ]; then
  echo "This is Mac OSX"
elif [ "$OS" = "AIX" ]; then
  echo "This is AIX"
elif [ "$OS" = "Minix" ]; then
  echo "This is Minix"
elif [ "$OS" = "Linux" ]; then
  echo "This is Linux"
else
  echo "Failed to identify this OS"
fi
```

### 参考资料:
- 《Linux Command Line and Shell Scripting Bible》: Chapter 12: Using Structured Commands
- 《The Linux Command Line》: 27 Flow Control: Branching with if
- 《Shell Scripting Expert Recipes》: 5 Conditional Execution

