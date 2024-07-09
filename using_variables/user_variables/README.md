### 用户自定义变量

除了环境变量，shell 脚本还允许用户在脚本中定义和使用自己的变量。

用户自定义变量的名称可以是任何由字母、数字或下划线组成的字符串。
因为变量名区分大小写，所以变量 Var1 和变量 var1 是不同的。

使用等号为变量赋值。在变量、等号和值之间不能出现空格。

下面是一些为用户自定义变量赋值的例子：

```bash
var1=10
var2=-57
var3=testing
var4="still more testing"
```

shell 脚本会以字符串形式存储所有的变量值，脚本中的各个命令可以自行决定变量值的数据类型。
shell 脚本中定义的变量在脚本的整个生命周期里会一直保持着它们的值，在脚本结束时会被删除。

与系统变量类似，用户自定义变量可以通过$引用，用法如下：

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
$ chmod u+x test3
$ ./test3
Katie checked in 10 days ago
Jessica checked in 5 days ago
```

除了显式定义方式`VAR=value`，对变量赋值还有另外几种：
- 读取：`read VAR`
- 命令替换：`` VAR=`date` ``、`VAR=$(date)`

下面通过示例给出说明：

**读取：`read VAR`**

使用read命令可以交互式地对变量赋值：

```bash
#!/bin/bash

echo -n "Enter your name: "
read myvar
echo "myvar is $myvar"
```

运行脚本会有下列输出：

```
$ bash first.sh 
Enter your name: Steve
myvar is Steve
$ bash first.sh 
Enter your name: Steve Parker
myvar is Steve Parker
```

注意，输入的一整行都被读入到变量myvar中，
也可以使用read一次性读入多个变量：

```bash
#!/bin/bash

echo -n "Please enter your first name and last name: "
read firstname lastname
echo "Hello, $firstname. How is the $lastname family?"
```

上面的代码将读取两个变量，并且忽略任何空格。
行中的最后一个变量将读取输入行中还没有读取的任何文本，
所以这恰好能处理复姓的情况：

```
$ bash firstlast.sh
Please enter your first name and last name: Steve Parker Smith
Hello, Steve. How is the Parker Smith family?
```

然而，它对于输入过少的情况处理欠佳，变量lastname会一直存在于环境中
（可以通过在脚本中添加`set | grep name=`来查看），但值为空字符串：

```bash
#!/bin/bash

echo -n "Please enter your first name and last name: "
read firstname lastname
echo "Hello, $firstname. How is the $lastname family?"

echo "Relevant environment variables:"
set | grep "name="
```

运行脚本会有下列输出：

```
$ bash firstlast2.sh 
Please enter your first name and last name: Steve Parker
Hello, Steve. How is the Parker family?
Relevant environment variables:
firstname=Steve
lastname=Parker
$ bash examples/firstlast2.sh 
Please enter your first name and last name: Steve
Hello, Steve. How is the  family?
Relevant environment variables:
firstname=Steve
lastname=
```

在上面的代码中，the与family之间有两个空格，所以脚本显示`How is the $lastname family?`，
但是这两个空格之间是一个长度为0的字符串`$lastname`。


**从文件读取**

我们可以使用read命令从文件读取文本行。下面的代码更清晰地展示了这一做法：

```
$ read message < /etc/motd
$ echo $message
Linux goldie 2.6.32-5-amd64 #1 SMP Fri Oct 15 00:56:30 UTC 2010 x86_64
$
```

然而，`/etc/motd`文件的内容不止一行。
下面的代码将文件行读入到变量message中，一直循环直到不再有输入：

```
$ while read message
> do
>   echo $message
>   sleep 1
>   date
> done < /etc/motd
Linux goldie 2.6.32-5-amd64 #1 SMP Fri Oct 15 00:56:30 UTC 2010 x86_64
The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.
Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
```


**命令替换：`` VAR=`date` ``、`VAR=$(date)`**

变量赋值的另一种常见方式是将其值设置为某个命令的输出。
这其实是第一种赋值方式`VAR=value`的变种。
如果希望某个变量在星期一时值为Monday，星期二时为Tuesday等，
我们可以对date命令使用%A标志。

```bash
#!/bin/bash

TODAY=`date +%A`
echo "Today is $TODAY"
```

执行脚本，输出结果如下所示：

```
Today is Tuesday
```


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 11.4.2 用户自定义变量
- 《Shell脚本编程诀窍 适用于Linux、Bash等》: 3.1.2 变量的赋值

