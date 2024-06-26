### 变量

所有的编程语言都利用变量来存放数据，以备随后使用或修改。
和编译型语言不同，大多数脚本语言不要求在创建变量之前声明其类型。
用到什么类型就是什么类型。在变量名前面加上一个美元符号就可以访问到变量的值。
shell定义了一些变量，用于保存用到的配置信息，比如可用的打印机、搜索路径等。这些变量叫作环境变量。

变量名由一系列字母、数字和下划线组成，其中不包含空白字符。
常用的惯例是在脚本中使用大写字母命名环境变量，使用驼峰命名法或小写字母命名其他变量。

**定义变量**

定义变量时，变量名不加美元符号（`$`），如：

```bash
your_name="runoob.com"
```

注意，变量名和等号之间不能有空格，这可能和你熟悉的所有编程语言都不一样。同时，变量名的命名须遵循如下规则：

- 命名只能使用英文字母，数字和下划线，首个字符不能以数字开头。
- 中间不能有空格，可以使用下划线 `_`。
- 不能使用标点符号。
- 不能使用bash里的关键字（可用help命令查看保留关键字）。

有效的 Shell 变量名示例如下：

```bash
RUNOOB
LD_LIBRARY_PATH
_var
var2
```

无效的变量命名：

```bash
?var=123
user*name=runoob
```

除了显式地直接赋值，还可以用语句给变量赋值，如：

```bash
for file in `ls /etc`
```
或
```bash
for file in $(ls /etc)
```
以上语句将 /etc 下目录的文件名循环出来。


**使用变量**

使用一个定义过的变量，只要在变量名前面加美元符号即可，如：

```bash
your_name="qinjx"
echo $your_name
echo ${your_name}
```

变量名外面的花括号是可选的，加不加都行，加花括号是为了帮助解释器识别变量的边界，比如下面这种情况：

```bash
for skill in Ada Coffe Action Java; do
    echo "I am good at ${skill}Script"
done
```

如果不给skill变量加花括号，写成echo "I am good at $skillScript"，解释器就会把`$skillScript`当成一个变量（其值为空），代码执行结果就不是我们期望的样子了。

推荐给所有变量加上花括号，这是个好的编程习惯。

已定义的变量，可以被重新定义，如：

```bash
your_name="tom"
echo $your_name
your_name="alibaba"
echo $your_name
```

这样写是合法的，但注意，第二次赋值的时候不能写`$your_name="alibaba"`，使用变量的时候才加美元符（`$`）。


**只读变量**

使用 `readonly` 命令可以将变量定义为只读变量，只读变量的值不能被改变。

下面的例子尝试更改只读变量，结果报错：

```bash
#!/bin/bash

myUrl="https://www.google.com"
readonly myUrl
myUrl="https://www.runoob.com"
```

运行脚本，结果如下：

```
/bin/sh: NAME: This variable is read only.
```


**删除变量**

使用 `unset` 命令可以删除变量。语法：

```bash
unset variable_name
```

变量被删除后不能再次使用。`unset` 命令不能删除只读变量。

```bash
#!/bin/sh

myUrl="https://www.runoob.com"
unset myUrl
echo $myUrl
```

以上实例执行将没有任何输出。


**变量类型**

运行shell时，会同时存在三种变量：

1. 局部变量 局部变量在脚本或命令中定义，仅在当前shell实例中有效，其他shell启动的程序不能访问局部变量。
2. 环境变量 所有的程序，包括shell启动的程序，都能访问环境变量，有些程序需要环境变量来保证其正常运行。
   必要的时候shell脚本也可以定义环境变量。
3. shell变量 shell变量是由shell程序设置的特殊变量。shell变量中有一部分是环境变量，有一部分是局部变量，
   这些变量保证了shell的正常运行

**环境变量**

所有的应用程序和脚本都可以访问环境变量。可以使用env或printenv命令查看当前shell中所定义的全部环境变量：

```bash
$ env
PWD=/home/clif/ShellCookBook
HOME=/home/clif
SHELL=/bin/bash
# …… 其他行
```

要查看其他进程的环境变量，可以使用如下命令：

```bash
cat /proc/$PID/environ
```

其中，PID是相关进程的进程ID（PID是一个整数）。

export命令声明了将由子进程所继承的一个或多个变量。
这些变量被导出后，当前shell脚本所执行的任何应用程序都会获得这个变量。
shell创建并用到了很多标准环境变量，我们也可以导出自己的环境变量。

如果需要在PATH中添加一条新路径，可以使用如下命令：

```bash
export PATH="$PATH:/home/user/bin"
```

也可以使用

```bash
$ PATH="$PATH:/home/user/bin"
$ export PATH
$ echo $PATH
/home/slynux/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/user/bin
```

这样，我们就将/home/user/bin添加到了PATH中。


### 参考资料:
- [菜鸟教程 - shell 教程](https://www.runoob.com/linux/linux-shell.html)
