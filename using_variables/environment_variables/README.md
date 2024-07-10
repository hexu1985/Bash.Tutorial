### 环境变量

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

或者也可以用 export 命令（带-p命令行参数）显示当前环境：

```
$ export -p
declare -x CLUTTER_IM_MODULE="xim"
declare -x COLORTERM="truecolor"
declare -x CONDA_DEFAULT_ENV="base"
declare -x CONDA_EXE="/home/hexu/anaconda3/bin/conda"
declare -x CONDA_PREFIX="/home/hexu/anaconda3"
declare -x CONDA_PROMPT_MODIFIER="(base) "
declare -x CONDA_PYTHON_EXE="/home/hexu/anaconda3/bin/python"
declare -x CONDA_SHLVL="1"
...
```

在脚本中，可以在环境变量名之前加上$来引用这些环境变量，用法如下：

```bash
#!/bin/bash

# display user information from the system.

echo "User info for userid: $USER"
echo UID: $UID
echo HOME: $HOME
```

环境变量`$USER`、`$UID `和`$HOME`用来显示已登录用户的相关信息。脚本输出如下：

```bash
$ chmod u+x test2
$ ./test2
User info for userid: hexu
UID: 1000
HOME: /home/hexu
```

变量可以添加到程序环境中，但是对Shell或接下来的命令不会一直有效：
将该（变量）赋值，置于命令名称与参数前即可：

```
PATH=/bin:/usr/bin awk '...' file1 file2
```

这个PATH的值改变仅针对单个awk命令的执行。任何接下来的命令，所看到的
都是在它们的环境中PATH的当前值。

你可以用 env 命令临时地改变环境变量值：

```
env -i PATH=$PATH HOME=$HOME LC_ALL=C awk '...' file1 file2
```

`-i`选项是用来初始化环境变量的；也就是丢弃任何的继承值，仅传递命令行上指定的变量给程序使用。

创建全局环境变量的方法是先创建局部变量，然后再将其导出到全局环境中。
这可以通过 export 命令以及要导出的变量名（不加$符号）来实现：

```
$ my_variable="I am Global now"
$
$ export my_variable
$
$ echo $my_variable
I am Global now
$ bash
$ echo $my_variable
I am Global now
$ exit
exit
$ echo $my_variable
I am Global now
$
```

修改子 shell 中的全局环境变量并不会影响父 shell 中该变量的值：

```
$ export my_variable="I am Global now"
$ echo $my_variable
I am Global now
$
$ bash
$ echo $my_variable
I am Global now
$ my_variable="Null"
$ echo $my_variable
Null
$ exit
exit
$
$ echo $my_variable
I am Global now
$
```

既然可以创建新的环境变量，自然也能删除已有的环境变量。可以用 unset 命令来完成这个操作。
在 unset 命令中引用环境变量时，记住不要使用$。

```
$ my_variable="I am going to be removed"
$ echo $my_variable
I am going to be removed
$
$ unset my_variable
$ echo $my_variable
```

默认情况下， unset 命令会解除变量设置，也可以加上`-v`来完成：

```
unset full_name                 # Remove the full_name variable
unset -v first middle last      # Remove the other variables
```


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 11.4.1 环境变量，6.3 删除环境变量
- 《Shell脚本学习指南》: 6.1.1 变量赋值与环境

