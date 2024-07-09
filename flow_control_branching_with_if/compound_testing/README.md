### 复合条件测试

if-then 语句允许使用布尔逻辑将测试条件组合起来。可以使用以下三种布尔运算符。
- [ condition1 ] && [ condition2 ]
- [ condition1 ] || [ condition2 ]
- ! [ condition ]

第一种布尔运算使用布尔运算符 AND 来组合两个条件。要执行 then 部分的命令，两个条件都必须满足。

第二种布尔运算使用 OR 布尔运算符来组合两个条件。如果任意条件为真，那么 then 部分的命令就会执行。

第三种布尔运算使用 NOT 布尔运算符来反转一个条件。如果条件为真，则返回假。

下面来演示 AND 布尔运算符的用法：

```bash
$ cat AndBoolean.sh
#!/bin/bash
# Testing an AND Boolean compound condition
#
if [ -d $HOME ] && [ -w $HOME/newfile ]
then
    echo "The file exists and you can write to it."
#
else
    echo "You cannot write to the file."
#
fi
$
$ ls -l $HOME/newfile
ls: cannot access '/home/christine/newfile': No such file or directory
$
$ ./AndBoolean.sh
You cannot write to the file.
$
$ touch $HOME/newfile
$
$ ./AndBoolean.sh
The file exists and you can write to it.
$
```

使用 AND 布尔运算符时，两个测试条件都必须满足。

我们再看看 NOT 布尔运算符的用法：

```bash
if ! grep pattern myfile > /dev/null
then
    ... Pattern is not there
fi
```

或者

```
if ! [ -f $HOME/test.txt ]; then echo "has not test.txt"; fi
```

“&&”（AND）和“||”（OR）两种布尔运算符，还可以用于命令行中的多个命令的执行，语法如下。

```bash
command1 && command2
```

和

```bash
command1 || command2
```

理解这两个运算符是非常重要的。对于“&&”运算符来说，先执行command1，
只有在command1执行成功时，command2才能够执行。
对于“||”运算符来说，先执行command1，则只有在command1执行失败时，command2才能够执行。

例如：

```bash
$ mkdir temp && cd temp
```

这会创建一个temp目录，并且当这个创建工作执行成功后，当前的工作目录才会更改为temp。
只有在第一个mkdir命令执行成功后，才会尝试执行第二个命令。

同样，看如下命令：

```bash
$ [ -d temp ] || mkdir temp
```

这个命令先检测temp目录是否存在，只有当检测失败时，才会创建这个目录。

其实把"["(test命令)当成普通命令的特例，就不用分别记忆了。


### 参考资料:
- 《Linux命令行大全 第2版》: 27.7 控制操作符：另一种分支方式
- 《Linux命令行与shell脚本编程大全（第4版）》: 12.5 复合条件测试
- 《Shell脚本学习指南》: 6.2.3 逻辑的NOT、AND与OR
