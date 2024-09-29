### null命令

null 命令（由冒号`:`表示）是一个内置命令，它不执行任何操作，只返回退出状态 0。
null 命令有时被放在if命令后面作为一个占位符，这时if命令没什么事可做，
却需要一个命令放在 then 语句之后，否则程序会产生错误信息，因为 then 语句之后需要一个命令。
通常使用 null 命令作为循环命令的参数，作用是让循环无限执行下去。

**示例1：脚本**

```
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


### 参考资料:
- 《UNIX Shell范例精解（第4版）》: 14.5.7 null 命令

