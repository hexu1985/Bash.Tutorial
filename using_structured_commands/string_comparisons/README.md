### 字符串比较

条件测试还允许比较字符串值。
下表列出了可用的字符串比较功能。

| 表达式       | 成为true的条件                                |
| ------------ | --------------------------------------------- |
| str1 = str2  | 检查 str1 是否和 str2 相同（=两侧必须有空格） |
| str1 == str2 | 检查 str1 是否和 str2 相同（==两侧必须有空格）|
| str1 != str2 | 检查 str1 是否和 str2 不同（!=两侧必须有空格）|
| str1 < str2  | 检查 str1 是否小于 str2                       |
| str1 > str2  | 检查 str1 是否大于 str2                       |
| -n str1      | 检查 str1 的长度是否不为 0                    |
| -z str1      | 检查 str1 的长度是否为 0                      |


**字符串相等性**

字符串的相等和不等条件不言自明，很容易看出两个字符串值是否相同：

```bash
#!/bin/bash
# Using string test evaluations
#
testuser=christine
#
if [ $testuser = christine ]
then
    echo "The testuser variable contains: christine"
else
    echo "The testuser variable contains: $testuser"
fi
```

运行这个脚本时，会产生如下输出：

```
$ ./12-testing-string-equality
The testuser variable contains: christine
```

字符串不等条件也可以判断两个字符串值是否相同：

```bash
#!/bin/bash
# Using string test not equal evaluations
#
testuser=rich 
#
if [ $testuser != christine ]
then
    echo "The testuser variable does NOT contain: christine"
else
    echo "The testuser variable contains: christine"
fi 
```

运行这个脚本时，会产生如下输出：

```
$ ./12-testing-string-not-equality
The testuser variable does NOT contain: christine
```

记住，在比较字符串的相等性时，比较测试会将所有的标点和大小写情况都考虑在内。


**字符串顺序**

要测试一个字符串是否大于或小于另一个字符串就开始变得棘手了。
使用测试条件的大于或小于功能时，会出现两个经常困扰 shell 程序员的问题。
- 大于号和小于号必须转义，否则 shell 会将其视为重定向符，将字符串值当作文件名。
- 大于和小于顺序与 sort 命令所采用的不同。

在编写脚本时，第一个问题可能会导致不易察觉的严重后果。
下面的例子展示了 shell 脚本编程初学者不时会碰到的状况：

```bash
#!/bin/bash
# Misusing string comparisons
#
string1=soccer
string2=zorbfootball
#
if [ $string1 > $string2 ]
then
    echo "$string1 is greater than $string2"
else
    echo "$string1 is less than $string2"
fi
```

运行这个脚本时，会产生如下输出：

```
$ ./13-mis-using-string-comparison
soccer is greater than zorbfootball
$ ls z*
zorbfootball
$
```

这个脚本中只用了大于号，虽然没有出现错误，但结果不对。
脚本把大于号解释成了输出重定向，因此创建了一个名为 zorbfootball 的文件。
由于重定向顺利完成了，测试条件返回了退出状态码 0，if 语句便认为条件成立。
要解决这个问题，需要使用反斜线（\）正确地转义大于号：

```bash
#!/bin/bash
# Properly using string comparisons
#
string1=soccer
string2=zorbfootball
#
if [ $string1 \> $string2 ]
then
    echo "$string1 is greater than $string2"
else
    echo "$string1 is less than $string2"
fi
```

运行这个脚本时，会产生如下输出：

```
$ ./14-mis-using-string-comparison-corrected
soccer is less than zorbfootball
$ ls z*
ls: 无法访问'z*': 没有那个文件或目录
```

现在的答案才是我们想要的。


第二个问题更细微，除非经常处理大小写字母，否则几乎遇不到。
sort 命令处理大写字母的方法刚好与 test 命令相反：

```
$ cat SportsFile.txt
Soccer
soccer
$ sort SportsFile.txt
soccer
Soccer
```

接下来看看 shell 中的字符串大小比较：

```bash
#!/bin/bash
# Testing string sort order
#
string1=Soccer
string2=soccer
#
if [ $string1 \> $string2 ]
then
    echo "$string1 is greater than $string2"
else
    echo "$string1 is less than $string2"
fi
```

运行这个脚本时，会产生如下输出：

```
$ ./15-string-sort-order
Soccer is less than soccer
$
```

在比较测试中，大写字母被认为是小于小写字母的。但 sort 命令正好相反。
当你将同样的字符串放进文件中并用 sort 命令排序时，小写字母会先出现。
这是由于各个命令使用了不同的排序技术。

比较测试中使用的是标准的 Unicode 顺序，根据每个字符的 Unicode 编码值来决定排序结果。
sort 命令使用的是系统的语言环境设置中定义的排序顺序。
对于英语，语言环境设置指定了在排序顺序中小写字母出现在大写字母之前。


**字符串大小**

`-n` 和 `-z` 可以很方便地用于检查一个变量是否为空：

```bash
#!/bin/bash
# Testing string length
#
string1=Soccer
string2=''
#
if [ -n $string1 ]
then
    echo "The string '$string1' is NOT empty"
else
    echo "The string '$string1' IS empty"
fi
#
if [ -z $string2 ]
then
    echo "The string '$string2' IS empty"
else
    echo "The string '$string2' is NOT empty"
fi
#
if [ -z $string3 ]
then
    echo "The string '$string3' IS empty"
else
    echo "The string '$string3' is NOT empty"
fi 
```

运行这个脚本时，会产生如下输出：

```
$ ./16-testing-string-length
The string 'Soccer' is NOT empty
The string '' IS empty
The string '' IS empty
```

这个例子创建了两个字符串变量。string1 变量包含了一个字符串，string2 变量包含的是一个空串。
后续的比较如下：

```
if [ -n "$string1" ]
```
上述代码用于判断 string1 变量的长度是否不为 0。因为的确不为 0，所以执行 then 部分。

```
if [ -z "$string2" ]
```
上述代码用于判断 string2 变量的长度是否为 0。因为的确为 0，所以执行 then 部分。

```
if [ -z "$string3" ]
```
上述代码用于判断 string3 变量的长度是否为 0。shell 脚本中并未定义该变量，所以长度可视为 0，尽管它未被定义过。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 12.4.2 字符串比较
