### 数值比较

使用 test 命令最常见的情形是对两个数值进行比较。
下表列出了测试两个值时可用的条件参数。

| 表达式    | 成为true的条件            |
| --------- | ------------------------- |
| n1 -eq n2 | 检查 n1 是否等于 n2       |
| n1 -ge n2 | 检查 n1 是否大于或等于 n2 |
| n1 -gt n2 | 检查 n1 是否大于 n2       |
| n1 -le n2 | 检查 n1 是否小于或等于 n2 |
| n1 -lt n2 | 检查 n1 是否小于 n2       |
| n1 -ne n2 | 检查 n1 是否不等于 n2     |

数值条件测试可用于数字和变量。来看一个例子：

```bash
#!/bin/bash
# Using numeric test evaluations
value1=10
value2=11

if [ $value1 -gt 5 ]
then
	echo "The test value $value1 is greater than 5"
fi
if [ $value1 -eq $value2 ]
then
	echo "The values are equal"
else
	echo "The values are different"
fi
```

第一个条件测试如下：

```
if [ $value1 -gt 5 ]
```

该测试会测试变量 value1 的值是否大于 5。第二个条件测试如下：

```
if [ $value1 -eq $value2 ]
```

该测试会测试变量 value1 的值是否和变量 value2 的值相等。
这两个数值条件测试的结果和预想中的一样。

```
$ ./10-numeric-test
The test value 10 is greater than 5
The values are different

21 is not zero
21 > 20
```

> 警告 对于条件测试，bash shell 只能处理整数。尽管可以将浮点值用于某些命令（比如 echo），
> 但它们在条件测试下无法正常工作。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 12.4.1 数值比较
