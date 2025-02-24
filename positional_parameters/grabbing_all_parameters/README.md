### 获取所有的参数

`$*` 变量和 `$@` 变量可以轻松访问所有参数，它们各自包含了所有的命令行参数。

`$*` 变量会将所有的命令行参数视为一个单词。这个单词含有命令行中出现的每一个参数。
基本上，`$*` 变量会将这些参数视为一个整体，而不是一系列个体。

另外，`$@` 变量会将所有的命令行参数视为同一字符串中的多个独立的单词，以便你能遍历并处理全部参数。
这通常使用 for 命令完成。

这两个变量的工作方式不太容易理解。下面来看一个例子，你就能明白二者之间的区别了：

```bash
#!/bin/bash
# Testing different methods for grabbing all the parameters
#
echo
echo "Using the \$* method: $*"
echo 
echo "Using the \$@ method: $@"
echo 
exit
```

执行脚本，输出结果如下所示：

```bash
$ ./13-testing-dollar-star-and-dollar-at-sign alpha beta charlie delta

Using the $* method: alpha beta charlie delta

Using the $@ method: alpha beta charlie delta

$
```

注意，从表面上看，两个变量产生的输出相同，均显示了所有命令行参数。下面的例子演示了不同之处：

```bash
#!/bin/bash
# Exploring different methods for grabbing all the parameters
#
echo
echo "Using the \$* method: $*"
count=1

for param in "$*"
do
	echo "\$* Parameter #$count = $param"
	count=$[ $count + 1 ]
done

echo
echo "Using the \$@ method: $@"
count=1

for param in "$@"
do
	echo "\$@ Parameter #$count = $param"
	count=$[ $count + 1 ]
done
```

执行脚本，输出结果如下所示：

```bash
$ ./14-testing-dollar-star-and-dollar-at-sign-difference alpha beta charlie

Using the $* method: alpha beta charlie delta
$* Parameter #1 = alpha beta charlie delta

Using the $@ method: alpha beta charlie delta
$@ Parameter #1 = alpha
$@ Parameter #2 = beta
$@ Parameter #3 = charlie
$@ Parameter #4 = delta
```

现在就清楚多了。通过使用 for 命令遍历这两个特殊变量，可以看出二者如何以不同的方式处理命令行参数。
`$*` 变量会将所有参数视为单个参数，而 `$@` 变量会单独处理每个参数。这是遍历命令行参数的一种绝妙方法。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 14.2.2 获取所有的数据

