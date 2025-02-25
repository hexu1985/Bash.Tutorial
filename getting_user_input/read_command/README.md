### read命令

read 命令从标准输入（键盘）或另一个文件描述符中接受输入。
获取输入后，read 命令会将数据存入变量。下面是该命令最简单的用法：

```bash
#!/bin/bash
# Using the read command
#
echo -n "Enter your name: "
read name
echo "Hello $name, welcome to my script."
exit
```

执行脚本，输出结果如下所示：

```bash
$ ./23-read-command
Enter your name: He Xu
Hello He Xu, welcome to my script.
```

用于生成提示的 echo 命令使用了-n 选项。该选项不会在字符串末尾输出换行符，
允许脚本用户紧跟其后输入数据。这让脚本看起来更像表单。

实际上，read 命令也提供了-p 选项，允许直接指定提示符：

```bash
#!/bin/bash
# Using the read command with the -p option
#
read -p "Please enter your age: " age
days=$[ $age * 365 ]
echo "That means you are over $days days old!"
exit
```

执行脚本，输出结果如下所示：

```bash
$ ./24-testing-the-read-p-option
Please enter your age: 30
That means you are over 10950 days old!
```

read 命令会将提示符后输入的所有数据分配给单个变量。
如果指定多个变量，则输入的每个数据值都会分配给变量列表中的下一个变量。
如果变量数量不够，那么剩下的数据就全部分配给最后一个变量：

```bash
#!/bin/bash
# Using the read command for multiple variables
#
read -p "Enter your first and last name: " first last
echo "Checking data for $last, $first..."
exit
```

执行脚本，输出结果如下所示：

```bash
$ ./25-entering-multiple-variables
Enter your first and last name: Xu He
Checking data for He, Xu...
```

也可以在 read 命令中不指定任何变量，这样 read 命令便会将接收到的所有数据都放进特殊环境变量 REPLY 中：

```bash
#!/bin/bash
# Using the read command with REPLY variable
#
read -p "Enter your name: "
echo
echo "Hello $REPLY, welcome to my script."
exit
```

执行脚本，输出结果如下所示：

```bash
$ ./26-reply-environment-variable
Enter your name: He xu

Hello He xu, welcome to my script.
```

REPLY 环境变量包含输入的所有数据，其可以在 shell 脚本中像其他变量一样使用。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 14.6.1 基本的读取

