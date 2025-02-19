### until 命令

while命令退出状态不为0时终止循环，而until命令则刚好相反。除此之外，
until命令与while命令很相似。until循环会在接收到为0的退出状态时终止。

until 命令的格式如下：

```bash
until test commands
do
    other commands
done
```


来看一个 until 命令的例子：

```bash
#!/bin/bash
# using until command

var1=100

until [ $var1 -eq 0 ]
do
	echo $var1
	var1=$[ $var1 - 25 ]
done
```

执行脚本，输出结果如下所示：

```bash
$ ./17-until-command
100
75
50
25
```


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 13.4 until 命令 
