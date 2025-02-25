### 处理选项

选项是在连字符之后出现的单个字母，能够改变命令的行为。

**处理简单选项**

你可以使用 shift 命令来处理命令行选项。

在提取单个参数时，使用 case 语句来判断某个参数是否为选项：

```bash
#!/bin/bash
# Extract command-line options
#
echo
while [ -n "$1" ]
do
    case "$1" in
        -a) echo "Found the -a option" ;;
        -b) echo "Found the -b option" ;;
        -c) echo "Found the -c option" ;;
        *) echo "$1 is not an option" ;;
    esac
    shift
done
echo
exit
```

执行脚本，输出结果如下所示：


```bash
$ ./17-extracting-command-line-options-as-parameters -a -b -c -d

Found the -a option
Found the -b option
Found the -c option
-d is not an option

```

case 语句会检查每个参数，确认是否为有效的选项。找到一个，处理一个。
无论选项在命令行中以何种顺序出现，这种方法都能应对。

```bash
$ ./17-extracting-command-line-options-as-parameters -d -c -a

-d is not an option
Found the -c option
Found the -a option

```

**分离参数和选项**

你会经常碰到需要同时使用选项和参数的情况。
在 Linux 中，处理这个问题的标准做法是使用特殊字符将两者分开，该字符会告诉脚本选项何时结束，普通参数何时开始。

在 Linux 中，这个特殊字符是双连字符（`--`）。shell 会用双连字符表明选项部分结束。
在双连字符之后，脚本就可以放心地将剩下的部分作为参数处理了。

要检查双连字符，只需在 case 语句中加一项即可：

```bash
#!/bin/bash
# Extract command-line options and parameters
#
echo
while [ -n "$1" ]
do
    case "$1" in
        -a) echo "Found the -a option" ;;
        -b) echo "Found the -b option" ;;
        -c) echo "Found the -c option" ;;
        --) shift
            break;;
        *) echo "$1 is not an option" ;;
    esac
    shift
done
#
echo
count=1
for param in $@
do
    echo "Parameter #$count: $param"
    count=$[ $count + 1 ]
done
echo
exit
```

在遇到双连字符时，脚本会用 break 命令跳出 while 循环。
由于提前结束了循环，因此需要再加入另一个 shift 命令来将双连字符移出位置变量。
先用一组普通的选项和参数来测试一下这个脚本：

```bash
$ ./18-extracting-options-and-parameters -a -b -c test1 test2 test3

Found the -a option
Found the -b option
Found the -c option
test1 is not an option
test2 is not an option
test3 is not an option


```

结果表明，脚本认为所有的命令行参数都是选项。
接下来，进行同样的测试，只是这次会用双连字符将命令行中的选项和参数分开：

```bash
$ ./18-extracting-options-and-parameters -a -b -c -- test1 test2 test3

Found the -a option
Found the -b option
Found the -c option

Parameter #1: test1
Parameter #2: test2
Parameter #3: test3
```

当脚本遇到双连字符时，便会停止处理选项，将剩下的部分作为命令行参数。


**处理含值的选项**

有些选项需要一个额外的参数值。在这种情况下，命令行看起来像下面这样：

```bash
$ ./testing.sh -a test1 -b -c -d test2
```

当命令行选项要求额外的参数时，脚本必须能够检测到并正确地加以处理。来看下面的处理方法：

```bash
#!/bin/bash
# extracting command line options and values

echo
while [ -n "$1" ]
do
    case "$1" in
        -a) echo "Found the -a option" ;;
        -b) param=$2
            echo "Found the -b option with parameter value $param"
            shift;;
        -c) echo "Found the -c option" ;;
        --) shift
            break;;
        *) echo "$1 is not an option" ;;
    esac
    shift
done
#
echo
count=1
for param in $@
do
    echo "Parameter #$count: $param"
    count=$[ $count + 1 ]
done
exit
```

执行脚本，输出结果如下所示：


```bash
$ ./19-extracting-command-line-options-and-value -a -b BValue -d

Found the -a option
Found the -b option with parameter value BValue
-d is not an option

```

在这个例子中，case 语句定义了 3 个要处理的选项。`-b` 选项还需要一个额外的参数值。
由于要处理的选项位于 `$1`，因此额外的参数值就应该位于 `$2`（因为所有的参数在处理完之后都会被移出）。
只要将参数值从 `$2` 变量中提取出来就可以了。当然，因为这个选项占用了两个位置，所以还需要使用 shift 命令多移动一次。

只需这些基本的功能，整个过程就能正常工作，不管按什么顺序放置选项（只要记住放置好相应的选项参数）：

```bash
$ ./19-extracting-command-line-options-and-value -c -d -b BValue -a

Found the -c option
-d is not an option
Found the -b option with parameter value BValue
Found the -a option

```

现在 shell 脚本已经拥有了处理命令行选项的基本能力。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 14.4.1 查找选项

