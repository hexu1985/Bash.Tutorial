### getopts命令

getopts（注意是复数）是 bash shell 的内建命令，getopts 每次只处理一个检测到的命令行参数。
在处理完所有的参数后，getopts 会退出并返回一个大于 0 的退出状态码。
这使其非常适合用在解析命令行参数的循环中。

getopts 命令的格式如下：

```bash
getopts optstring variable
```

optstring 值与 getopt 命令中使用的值类似。有效的选项字母会在 optstring 中列出，
如果选项字母要求有参数值，就在其后加一个冒号。不想显示错误消息的话，可以在 optstring之前加一个冒号。
getopts 命令会将当前参数保存在命令行中定义的 variable 中。

getopts 命令要用到两个环境变量。如果选项需要加带参数值，那么 OPTARG 环境变量保存的就是这个值。
OPTIND 环境变量保存着参数列表中 getopts 正在处理的参数位置。这样在处理完当前选项之后就能继续处理其他命令行参数了。

下面来看一个使用 getopts 命令的简单例子：

```bash
#!/bin/bash
# Extract command-line options and values with getopts
#
echo
while getopts :ab:c opt
do
    case "$opt" in
        a) echo "Found the -a option" ;;
        b) echo "Found the -b option with parameter value $OPTARG";;
        c) echo "Found the -c option" ;;
        *) echo "Unknown option: $opt" ;;
    esac
done
exit
```

执行脚本，输出结果如下所示：

```bash
$ ./21-getopts-command -ab BValue -c

Found the -a option
Found the -b option with parameter value BValue
Found the -c option
```

while 语句定义了 getopts 命令，指定要查找哪些命令行选项，以及每次迭代时存储它们的变量名（opt）。

你会注意到在本例中 case 语句的用法有些不同。在解析命令行选项时，getopts 命令会移除起始的连字符，
所以在 case 语句中不用连字符。

getopts 命令有几个不错的特性。对新手来说，可以在参数值中加入空格：

```bash
$ ./21-getopts-command -b "BValue1 BValue2" -a

Found the -b option with parameter value BValue1 BValue2
Found the -a option
```

另一个好用的特性是可以将选项字母和参数值写在一起，两者之间不加空格：

```bash
$ ./21-getopts-command -abBValue

Found the -a option
Found the -b option with parameter value BValue
```

getopts 命令能够从 `-b` 选项中正确解析出 BValue 值。
除此之外，getopts 命令还可以将在命令行中找到的所有未定义的选项统一输出成问号：

```bash
$ ./21-getopts-command -d

Unknown option: ?
$
$ ./21-getopts-command -ade

Found the -a option
Unknown option: ?
Unknown option: ?
```

optstring 中未定义的选项字母会以问号形式传给脚本。

getopts 命令知道何时停止处理选项，并将参数留给你处理。
在处理每个选项时，getopts 会将 OPTIND 环境变量值增 1。
处理完选项后，可以使用 shift 命令和 OPTIND 值来移动参数：

```bash
#!/bin/bash
# Extract command-line options and parameters with getopts
#
echo
while getopts :ab:cd opt
do
    case "$opt" in
        a) echo "Found the -a option" ;;
        b) echo "Found the -b option with parameter value $OPTARG";;
        c) echo "Found the -c option" ;;
        d) echo "Found the -d option" ;;
        *) echo "Unknown option: $opt" ;;
    esac
done
#
shift $[ $OPTIND - 1 ]
#
echo
count=1
for param in "$@"
do
    echo "Parameter $count: $param"
    count=$[ $count + 1 ]
done
exit 
```

执行脚本，输出结果如下所示：

```bash
$ ./22-processing-options-and-parameters-getopts -db BValue test1 test2

Found the -d option
Found the -b option with parameter value BValue

Parameter 1: test1
Parameter 2: test2
```


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 14.4.3 使用 getopts 命令

