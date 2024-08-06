### 使用变量

运行 shell 脚本中的单个命令自然有用，但也有局限。你经常需要在 shell 命令中使用其他数据来处理信息。
这可以通过变量来实现。变量允许在 shell 脚本中临时存储信息，以便同脚本中的其他命令一起使用。

shell 维护着一组用于记录特定的系统信息的环境变量，比如系统名称、已登录系统的用户名、
用户的系统 ID（也称为 UID）、用户的默认主目录以及 shell 查找程序的搜索路径。
你可以用 env 命令显示一份完整的当前环境变量列表：

```
$ env
BASH=/bin/bash
BASHOPTS=checkwinsize:cmdhist:complete_fullquote:expand_aliases:extglob:extquote:force_fignore:histappend:interactive_comments:progcomp:promptvars:sourcepath
...
HISTFILE=/home/hexu/.bash_history
HISTFILESIZE=2000
HISTSIZE=1000
HOME=/home/hexu
HOSTNAME=hexu-Lenovo-Legion-Y7000P2020H
HOSTTYPE=x86_64
IFS=$' \t\n'
...
```

在脚本中，可以在环境变量名之前加上 `$` 来引用这些环境变量，用法如下：

```bash
#!/bin/bash
# display user information from the system.

echo "User info for userid: $USER"
echo UID: $UID
echo HOME: $HOME
```

环境变量 `$USER`、`$UID` 和 `$HOME` 用来显示已登录用户的相关信息。脚本输出如下：

```
$ ./04-userid-home
User info for userid: hexu
UID: 1000
HOME: /home/hexu
```

注意，echo 命令中的环境变量会在脚本运行时被替换成当前值。
另外，在第一个字符串中可以将 `$USER` 系统变量放入双引号中，而 shell 依然能够知道我们的意图。
但这种方法存在一个问题。看看下面这个例子：

```
$ echo "The cost of the item is $15"
The cost of the item is 5
```

显然这不是我们想要的。只要脚本在双引号中看到 `$`，就会以为你在引用变量。
在这个例子中，脚本会尝试显示变量 `$1` 的值（尚未定义），再显示数字 5。
要显示 `$`，必须在它前面放置一个反斜线：

```
$ echo "The cost of the item is \$15"
The cost of the item is $15
```

反斜线允许 shell 脚本按照字面意义解释 `$` ，而不是引用变量。


除了环境变量，shell 脚本还允许用户在脚本中定义和使用自己的变量。
定义变量允许在脚本中临时存储并使用数据。

用户自定义变量的名称可以是任何由字母、数字或下划线组成的字符串。
因为变量名区分大小写，所以变量 Var1 和变量 var1 是不同的。

使用等号为变量赋值。在变量、等号和值之间不能出现空格（另一个初学者经常犯错的地方）。
下面是一些为用户自定义变量赋值的例子：

```
var1=10
var2=-57
var3=testing
var4="still more testing"
```

shell 脚本会以字符串形式存储所有的变量值，脚本中的各个命令可以自行决定变量值的数据类型。
shell 脚本中定义的变量在脚本的整个生命周期里会一直保持着它们的值，在脚本结束时会被删除。
与系统变量类似，用户自定义变量可以通过 `$` 引用：

```bash
#!/bin/bash
# testing variables

days=10
guest="Katie"
echo "$guest checked in $days days ago"
days=5
guest="Jessica"
echo "$guest checked in $days days ago"
```

运行脚本会有下列输出：

```
$ ./06-testing-variables
Katie checked in 10 days ago
Jessica checked in 5 days ago
$
```

每次引用变量时，都会输出该变量的当前值。重要的是记住，引用变量值时要加 `$`，对变量赋值时则不用加 `$`。
通过下面这个例子可以说明：

```bash
#!/bin/bash
# assigning a variable value to another variable

value1=10
value2=value1
echo The resuling value is $value2

value1=10
value2=$value1
echo The resuling value is $value2
```

在赋值语句中使用 value1 变量的值时，必须使用 `$`。以上代码会产生下列输出：

```bash
$ ./07-assiging-variable-value-to-another-variable
The resuling value is value1
The resuling value is 10
$
```

shell 脚本中最有用的特性之一是可以从命令输出中提取信息并将其赋给变量。
把输出赋给变量之后，就可以随意在脚本中使用了。在脚本中处理数据时，这个特性显得尤为方便。
有两种方法可以将命令输出赋给变量。
- 反引号（\`）
- `$()`格式

要注意反引号，这可不是用于字符串的那个普通的单引号。

命令替换允许将 shell 命令的输出赋给变量。

你要么将整个命令放入反引号内：

```
testing=`date`
```

要么使用`$()`格式：

```
testing=$(date)
```

shell 会执行命令替换符内的命令，将其输出赋给变量 testing。
注意，赋值号和命令替换符之间没有空格。下面是一个使用 shell 命令输出创建变量的例子：

```bash
#!/bin/bash

testing=$(date)
echo "The date and time are:" $testing
```

变量 testing 保存着 date 命令的输出，然后会使用 echo 命令显示出该变量的值。
运行这个 shell 脚本会生成下列输出：

```
$ ./08-command-substitution
The date and time are: 2024年 08月 06日 星期二 15:23:52 CST
$
```

下面这个例子很常见，它在脚本中通过命令替换获得当前日期并用其来生成唯一文件名：

```bash
#!/bin/bash
# copy the /usr/bin directory listing to a log file
today=$(date +%0Y%0m%0d)
ls /usr/bin -al > log.$today
```

today 变量保存着格式化后的 date 命令的输出。这是提取日期信息，用于生成日志文件的一种常用技术。
`+%y%m%d` 格式会告诉 date 命令将日期显示为两位数的年、月、日的组合：

```
$ date +%y%m%d
240806
$
```

该脚本会将日期值赋给变量，然后再将其作为文件名的一部分。
文件本身包含重定向的目录列表输出。运行该脚本之后，应该能在目录中看到一个新文件：

```
$ ./09-command-substitution-logfile-today 
$ ls -tlr
-rw-rw-r-- 1 hexu hexu 212647 8月   6 15:27 log.20240806
```

目录中出现的日志文件采用 `$today` 变量的值作为文件名的一部分。
日志文件的内容是 /usr/bin 目录内容的列表输出。
如果脚本在次日运行，那么日志文件名会是 log.20240807，因此每天都会创建一个新文件。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 11.4 使用变量
