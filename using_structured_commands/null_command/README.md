### null命令

null 命令（由冒号`:`表示）是一个内置命令，它不执行任何操作，只返回退出状态 0。
null 命令有时被放在if命令后面作为一个占位符，这时if命令没什么事可做，
却需要一个命令放在 then 语句之后，否则程序会产生错误信息，因为 then 语句之后需要一个命令。
通常使用 null 命令作为循环命令的参数，作用是让循环无限执行下去。

**示例1：脚本**

```bash
    #!/bin/bash
    # filename: name_grep
1   name=Tom
2   if grep "$name" databasefile >& /dev/null
    then
3       :
4   else
        echo "$1 not found in databasefile"
        exit 1
    fi
```

1. 变量 name 被赋值为字符串 Tom。
2. if 命令测试 grep 命令的退出状态。如果在 databasefile 中找到 Tom，则执行 null 命令（冒号）并且不执行任何操作。
   标准输出和错误输出将重定向到 `/dev/null`。
3. 冒号代表 null 命令。它只返回 0 退出状态。
4. 我们真正想做的是打印一条错误消息，如果未找到 Tom 则退出。
   如果 grep 命令失败，将执行 else 之后的命令。


**示例2：命令行**

```
1   $ DATAFILE=
2   $ : ${DATAFILE:=$HOME/db/datafile}
    $ echo $DATAFILE
    /home/hexu/db/datafile
3   $ : ${DATAFILE:=$HOME/junk}
    $ echo $DATAFILE
    /home/hexu/db/datafile
```

1. 变量 DATAFILE 被赋值为空。
2. 冒号命令是一个不执行任何操作的命令。修饰符（`:=`）返回一个可以赋给变量或用于测试的值。
   在此示例中，表达式作为参数传递给这条空命令。shell 会执行变量替换；也就是说，如果 DATAFILE 还没有值，则将路径名赋给 DATAFILE。
   变量 DATAFILE 是永久设置的。
3. 因为变量已经设置好了，所以 shell 不会再用修饰符（`:=`）右边提供的默认值重置它。


**示例3：脚本**

```bash
    #!/bin/bash
    # Scriptname: wholenum
    # Purpose:The expr command tests that the user enters an integer
1   echo "Enter an integer."
    read number
2   if expr "$number" + 0 >& /dev/null
    then
3       :
    else
4       echo "You did not enter an integer value."
        exit 1
5   fi
```

1. 要求用户输入一个整数。将该整数赋值给变量 number。
2. expr 命令计算表达式。如果可以执行加法，则说明 number 是整数，expr 返回 Success exit 状态。
   所有输出都被重定向到位容器 `/dev/null`。
3. 如果 expr 成功，则返回 0 退出状态，并且冒号命令不执行任何操作。
4. 如果 expr 命令失败，它将返回非零退出状态，echo 命令显示消息，程序退出。
5. fi 结束 if 块。


### 参考资料:
- 《UNIX Shell范例精解（第4版）》: 14.5.7 null 命令

