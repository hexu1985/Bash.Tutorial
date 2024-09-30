### 复合条件测试

if-then 语句允许使用布尔逻辑将测试条件组合起来。可以使用以下两种布尔运算符。

- [ condition1 ] && [ condition2 ]
- [ condition1 ] || [ condition2 ]

第一种布尔运算使用布尔运算符 AND 来组合两个条件。要执行 then 部分的命令，两个条件都必须满足。

第二种布尔运算使用 OR 布尔运算符来组合两个条件。如果任意条件为真，那么 then 部分的命令就会执行。

下面来演示 AND 布尔运算符的用法：

```bash
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
```

运行这个脚本时，会产生如下输出：

```
$ ls -l $HOME/newfile
ls: 无法访问'/home/hexu/newfile': 没有那个文件或目录
$ ./28-testing-compound-comparisons
You cannot write to the file.
$ touch $HOME/newfile
$ ./28-testing-compound-comparisons
The file exists and you can write to it.
$
```

使用 AND 布尔运算符时，两个测试条件都必须满足。第一个测试会检查用户的 `$HOME` 目录是否存在。
第二个测试会检查在用户的 `$HOME` 目录中是否有名为 newfile 的文件，以及用户是否有该文件的写权限。
如果两个测试条件有任意一个未通过，那么 if 语句就会失败，shell 则执行 else 部分的命令。
如果两个测试条件都通过了，那么 if 语句就会成功，shell 就会执行 then 部分的命令。


**逻辑的NOT**

有时，用否定的措辞来表达你的测试会更容易：“如果 John 不在家，然后......”，
在 shell 中执行此操作的方法是在管道前面加上感叹号（`!`）：

```bash
if ! grep pattern myfile > /dev/null
then
    ... Pattern is not there
fi
```

POSIX 在 1992 年标准中引入了这种表示法。
您可能会看到较旧的 shell 使用冒号（`:`）命令的脚本，该命令不执行任何操作，来处理此类情况：

```bash
if grep pattern myfile > /dev/null
then
    : # do nothing
else
    ... Pattern is not there
fi
```


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 12.5 复合条件测试
- 《Shell脚本学习指南》: 6.2.3 逻辑的NOT、AND与OR
