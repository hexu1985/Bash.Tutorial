### case命令

case命令提供了一种更加清晰、易于编写以及更具可读性的代替if/then/else的结构，
尤其是在多个值进行测试的情况下。在case语句中，我们列出要识别以及要操作的值，
然后为每个值提供一个代码块。

case 命令会将指定变量与不同模式进行比较。如果变量与模式匹配，那么 shell 就会执行为
该模式指定的命令。你可以通过竖线运算符在一行中分隔出多个模式。星号会捕获所有与已知模
式不匹配的值。

其语法如下所示：

```
case variable in
pattern1 | pattern2) commands1;;
pattern3) commands2;;
*) default commands;;
esac
```

我们将一个长串 if-then-else 语句，改写成等价的case语句为例：

首先，给出if-then-else的脚本，如下：

```bash
$ cat LongIf.sh
#!/bin/bash
# Using a tedious and long if statement
#
if [ $USER == "rich" ]
then
    echo "Welcome $USER"
    echo "Please enjoy your visit."
elif [ $USER == "barbara" ]
then
    echo "Hi there, $USER"
    echo "We're glad you could join us."
elif [ $USER == "christine" ]
then
    echo "Welcome $USER"
    echo "Please enjoy your visit."
elif [ $USER == "tim" ]
then
    echo "Hi there, $USER"
    echo "We're glad you could join us."
elif [ $USER = "testing" ]
then
    echo "Please log out when done with test."
else
    echo "Sorry, you are not allowed here."
fi
$
$ ./LongIf.sh
Welcome christine
Please enjoy your visit.
$
```

下面是将 if-then-else 程序转换成使用 case 命令的脚本：

```bash
$ cat ShortCase.sh
#!/bin/bash
# Using a short case statement
#
case $USER in
rich | christine)
    echo "Welcome $USER"
    echo "Please enjoy your visit.";;
barbara | tim)
    echo "Hi there, $USER"
    echo "We're glad you could join us.";;
testing)
    echo "Please log out when done with test.";;
*)
    echo "Sorry, you are not allowed here."
esac
$
$ ./ShortCase.sh
Welcome christine
Please enjoy your visit.
$
```

**模式**

case同样支持通配符模式匹配：

下表给出一些case模式范例：

| 模式         | 描述                      |
| ------------ | ------------------------- |
| a)           | 若关键字为a则吻合         |
| [[:alpha:]]) | 若关键字为单个字母则吻合。|
| ???)         | 若关键字为三个字符则吻合。|
| *.txt)       | 若关键字以.txt结尾则吻合。|
| *)           |  与任何关键字吻合。       |

下面是一个使用模式的范例。

```bash
#!/bin/bash
read -p "enter word > "
case $REPLY in
    [[:alpha:]]) echo "is a single alphabetic character." ;;
     [ABC][0-9]) echo "is A, B, or C followed by a digit." ;;
            ???) echo "is three characters long." ;;
          *.txt) echo "is a word ending in '.txt'" ;;
              *) echo "is something else." ;;
esac
```

**多个模式的组合**

我们也可以使用竖线作为分隔符来组合多个模式，模式之间是“或”的条
件关系。这对一些类似同时处理大写和小写字母的事件很有帮助。如下所示。

```bash
#!/bin/bash
# case-menu: a menu driven system information program
clear
echo "
Please Select:
A. Display System Information
B. Display Disk Space
C. Display Home Space Utilization
Q. Quit
"
read -p "Enter selection [A, B, C or Q] > "
case $REPLY in
    q|Q) echo "Program terminated."
        exit
        ;;
    a|A) echo "Hostname: $HOSTNAME"
        uptime
        ;;
    b|B) df -h
        ;;
    c|C) if [[ $(id -u) -eq 0 ]]; then
            echo "Home Space Utilization (All Users)"
            du -sh /home/ *
        else
            echo "Home Space Utilization ($USER)"
            du -sh $HOME
        fi
        ;;
    *) echo "Invalid entry" >&2
        exit 1
        ;;
esac
```

以上代码通过字母而不是进行菜单选择。用户进行选择时可以输入大写字母，也可以输入
小写字母。


### 参考资料:
- 《The Linux Command Line: A Complete Introduction》: 27. Flow Control: Branching with if - Control Operators: Another Way to Branch
- 《Linux Command Line and Shell Scripting Bible》: Chapter 12: Using Structured Commands - Considering Compound Testing
- 《Shell Scripting Expert Recipes》: 5 Conditional Execution
- 《UNIX Shells by Example》: 8.5.9 The case Command

