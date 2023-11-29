### if/else

最基本的结构化命令是 if-then 语句。if-then 语句的格式如下：

```bash
if command
then
    commands
fi
```

bash shell 的 if 语句会运行 if 之后的命令。如果该命令的退出状态码为 0（命令成功运行），
那么位于 then 部分的命令就会被执行。如果该命令的退出状态码是其他值，
则 then 部分的命令不会被执行，bash shell 会接着处理脚本中的下一条命令。
fi 语句用来表示if-then 语句到此结束。


### 参考资料:
- 《Linux Command Line and Shell Scripting Bible》: Chapter 12: Using Structured Commands

