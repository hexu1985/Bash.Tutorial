### 设置用户自定义变量

你可以在 bash shell 中直接设置自己的变量。


**设置局部用户自定义变量**

启动 bash shell（或者执行 shell 脚本）之后，就能创建仅对该 shell 进程可见的局部用户自定义变量。
可以使用等号为变量赋值，值可以是数值或字符串：

```
$ my_variable=Hello
$ echo $my_variable
Hello
$
```

如果要引用 my_variable 变量的值，使用 `$my_variable` 即可。
如果用于赋值的字符串包含空格，则必须用单引号或双引号来界定该字符串的起止：

```
$ my_variable=Hello World
bash: World: command not found...
$
$ my_variable="Hello World"
$ echo $my_variable
Hello World
$
```

如果没有引号，则 bash shell 会将下一个单词（World）视为另一个要执行的命令。
注意，你定义的局部变量用的是小写字母，而系统环境变量用的都是大写字母。

记住，在变量名、等号和值之间没有空格，这一点非常重要。
如果在赋值表达式中加上了空格，那么 bash shell 会将值视为单独的命令：

```
$ my_variable = "Hello World"
bash: my_variable: command not found...
$
```

设置好局部变量后，就能在 shell 进程中随意使用了。
但如果又生成了另一个 shell，则该变量在子 shell 中不可用：

```
$ my_variable="Hello World"
$
$ bash
$ echo $my_variable
$ exit
exit
$ echo $my_variable
Hello World
$
```

在本例中，通过 bash 命令生成了一个子 shell。用户自定义变量 my_variable 无法在该子 shell 中使用。
echo $my_variable 命令返回的空行就是证据。当你退出子 shell，返回到原来的 shell 中时，这个局部变量依然可用。
类似地，如果在子进程中设置了一个局部变量，那么一旦退出子进程，该局部变量就不能用了：

```
$ echo $my_child_variable
$ bash
$ my_child_variable="Hello Little World"
$ echo $my_child_variable
Hello Little World
$ exit
exit
$ echo $my_child_variable
$
```

返回父 shell 后，子 shell 中设置的局部变量就不存在了。可以通过将局部用户自定义变量改为全局变量来解决这个问题。


**设置全局环境变量**

全局环境变量在设置该变量的父进程所创建的子进程中都是可见的。
创建全局环境变量的方法是先创建局部变量，然后再将其导出到全局环境中。
这可以通过 export 命令以及要导出的变量名（不加 `$` 符号）来实现：

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

在定义并导出局部变量 my_variable 后，bash 命令生成了一个子 shell。
在该子 shell 中可以正确显示出变量 my_variable 的值。原因在于 export 命令使其变成了全局环境变量。

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

在定义并导出变量 my_variable 后，bash 命令生成了一个子 shell。
在该子 shell 中可以正确显示出全局环境变量 my_variable 的值。子 shell 随后改变了这个变量的值。
但是，这种改变仅在子 shell 中有效，并不会反映到父 shell 环境中。
子 shell 甚至无法使用 export 命令改变父 shell 中全局环境变量的值：

```
$ echo $my_variable
I am Global now
$
$ bash
$ export my_variable="Null"
$ echo $my_variable
Null
$ exit
exit
$
$ echo $my_variable
I am Global now
$
```

尽管子 shell 重新定义并导出了变量 my_variable，但父 shell 中的 my_variable 变量依然保留着原先的值。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 6.2 设置用户自定义变量
