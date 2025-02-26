### 函数递归

局部函数变量的一个特性是自成体系（self-containment）。
除了获取函数参数，自成体系的函数不需要使用任何外部资源。

这个特性使得函数可以递归地调用，也就是说函数可以调用自己来得到结果。
递归函数通常有一个最终可以迭代到的基准值。
许多高级数学算法通过递归对复杂的方程进行逐级规约，直到基准值。

递归算法的经典例子是计算阶乘。一个数的阶乘是该数之前的所有数乘以该数的值。
要计算 5 的阶乘，可以执行下列算式：

```
5! = 1 * 2 * 3 * 4 * 5 = 120
```

使用递归，这一算法可以简化为以下形式：

```
x! = x * (x-1)!
```

也就是说，x 的阶乘等于 x 乘以 x-1 的阶乘。这可以用简单的递归脚本表达为以下形式：

```bash
function factorial {
    if [ $1 -eq 1 ]
    then
        echo 1
    else
        local temp=$[ $1 - 1 ]
        local result=`factorial $temp`
        echo $[ $result * $1 ]
    fi
}
```

阶乘函数用其自身计算阶乘的值：

```bash
#!/bin/bash
# using recursion

function factorial {
	if [ $1 -eq 1 ]
	then
		echo 1
	else
		local temp=$[ $1 - 1 ]
		local result=$(factorial $temp)
		echo $[ $result * $1 ]
	fi
}

read -p "Enter value: " value
result=$(factorial $value)
echo "The factorial of $value is: $result"
```

执行脚本，输出结果如下所示：

```bash
$ ./script18-using-recursion
Enter value: 5
The factorial of 5 is: 120
```


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 17.6 创建库

