### case命令

你经常会发现自己在尝试计算一个变量的值，在一组可能的值中寻找特定值。在这种情形下，
你不得不写出一长串 if-then-else 语句，就像下面这样：

```bash
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
```

运行这个脚本时，会产生如下输出：

```
$ ./31-looking-for-a-possible-value
Sorry, you are not allowed here.
```

elif 语句会不断检查 if-then，为比较变量寻找特定的值。
有了 case 命令，就无须再写大量的 elif 语句来检查同一个变量的值了。
case 命令会采用列表格式来检查变量的多个值：

```bash
case variable in
pattern1 | pattern2) commands1;;
pattern3) commands2;;
*) default commands;;
esac
```

case 命令会将指定变量与不同模式进行比较。如果变量与模式匹配，那么 shell 就会执行为该模式指定的命令。
你可以通过竖线运算符在一行中分隔出多个模式。星号会捕获所有与已知模式不匹配的值。
下面是一个将 if-then-else 程序转换成使用 case 命令的例子：

```bash
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
```

运行这个脚本时，会产生如下输出：

```
$ ./32-case-command
Sorry, you are not allowed here.
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

我们也可以使用竖线作为分隔符来组合多个模式，模式之间是“或”的条件关系。
这对一些类似同时处理大写和小写字母的事件很有帮助。如下所示。

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

以上代码通过字母而不是进行菜单选择。用户进行选择时可以输入大写字母，也可以输入小写字母。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 12.7 case 命令
- 《Linux命令行大全 第2版》: 31.1 case命令

