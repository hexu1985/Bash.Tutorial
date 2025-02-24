### shift命令

bash shell 工具箱中的另一件工具是 shift 命令，该命令可用于操作命令行参数。
跟字面上的意思一样，shift 命令会根据命令行参数的相对位置进行移动。

在使用 shift 命令时，默认情况下会将每个位置的变量值都向左移动一个位置。
因此，变量 `$3` 的值会移入 `$2`，变量 `$2` 的值会移入 `$1`，而变量 `$1` 的值则会被删除
（注意，变量 `$0` 的值，也就是脚本名，不会改变）。

这是遍历命令行参数的另一种好方法，尤其是在不知道到底有多少参数的时候。
你可以只操作第一个位置变量，移动参数，然后继续处理该变量。

来看一个简单的例子：

```bash
#!/bin/bash
# Shifting through the parameters
#
echo
echo "Using the shift method:"
count=1
while [ -n "$1" ]
do
	echo "Parameter #$count = $1"
	count=$[ $count + 1 ]
	shift
done
exit
```

执行脚本，输出结果如下所示：

```bash
$ ./15-shift-command alpha bravo charlie delta

Using the shift method:
Parameter #1 = alpha
Parameter #2 = bravo
Parameter #3 = charlie
Parameter #4 = delta
```

该脚本在 while 循环中测试第一个参数值的长度。当第一个参数值的长度为 0 时，循环结束。
测试完第一个参数后，shift 命令会将所有参数移动一个位置。

另外，也可以一次性移动多个位置。只需给 shift 命令提供一个参数，指明要移动的位置数即可：

```bash
#!/bin/bash
# Shifting multiple positions through the parameters
#
echo
echo "The original parameters: $*"
echo "Now shifting 2..."
shift 2
echo "Here's the new first parameter: $1"
echo
```

执行脚本，输出结果如下所示：

```bash
$ ./16-demonstrating-a-multi-position-shift alpha bravo charlie delta

The original parameters: alpha bravo charlie delta
Now shifting 2...
Here's the new first parameter: charlie
$
```

使用 shift 命令的值可以轻松地跳过不需要的参数。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 14.3 移动参数


