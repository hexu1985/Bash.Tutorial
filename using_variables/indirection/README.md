### 间接操作

bash shell 中一个特别有用的技巧是间接操作。使用它时必须小心，因为很容易混淆哪个变量是哪个，但它确实作用不小。

我们可以使用一个变量的值作为其他变量的名称。例如：

```
for myvar in PATH GDMSESSION HOSTNAME
do
    echo $myvar is ${!myvar}
done
```

运行结果如下：

```
PATH is /usr/bin:/bin:/usr/local/bin:/home/steve/bin:/usr/games
GDMSESSION is gnome
HOSTNAME is declan
```

乍一看，不是很有用。但这意味着您可以动态创建自己的变量名称，然后访问该名称中的数据：

```
#!/bin/bash
# Employee Data
Dave_Fullname="Dave Smith"
Dave_Country="USA"
Dave_Email=dave@example.com

Jim_Fullname="Jim Jones"
Jim_Country="Germany"
Jim_Email=jim.j@example.com

Bob_Fullname="Bob Anderson"
Bob_Country="Australia"
Bob_Email=banderson@example.com

echo "Select an Employee:"
select Employee in Dave Jim Bob
do
    echo "What do you want to know about ${Employee}?"
    select Data in Fullname Country Email
    do
        echo $Employee			# Jim
        echo $Data			# Email
        empdata=${Employee}_${Data} 	# Jim_Email
        echo "${Employee}'s ${Data} is ${!empdata}"	# jim.j@example.com
        break
    done 
    break
done
```

运行脚本会有下列输出：

```
$ ./empdata.sh 
Select an Employee:
1) Dave
2) Jim
3) Bob
#? 3
What do you want to know about Bob?
1) Fullname
2) Country
3) Email
#? 2
Bob
Country
Bob's Country is Australia
```

此脚本使用 select 循环提供了一个基本菜单，目的只是为了以简单的方式从用户获取数据。
比较巧妙的是通过另外两个变量的值来定义 `$empdata` 变量的那一行代码，以及接下来使用 `$empdata` 间接访问变量值的那一行。


### 参考资料:
- 《Shell脚本编程诀窍 适用于Linux、Bash等》: 7.4 间接操作


