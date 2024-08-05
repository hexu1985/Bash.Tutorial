### 在函数中处理变量

给 shell 脚本程序员带来麻烦的情况之一就是变量的作用域。作用域是变量的有效区域。
在函数中定义的变量与普通变量的作用域不同。也就是说，对脚本的其他部分而言，在函数中定义的变量是无效的。
函数有两种类型的变量。
- 全局变量
- 局部变量

全局变量是在 shell 脚本内任何地方都有效的变量。如果在脚本的主体部分定义了一个全局变量，那么就可以在函数内读取它的值。
类似地，如果在函数内定义了一个全局变量，那么也可以在脚本的主体部分读取它的值。
在默认情况下，在脚本中定义的任何变量都是全局变量。在函数外定义的变量可在函数内正常访问：

```bash
#!/bin/bash
# using a global variable to pass a value

function db1 {
	value=$[ $value * 2 ]
}

read -p "Enter a value: " value
db1
echo "The new value is: $value"
```

执行脚本，输出结果如下所示：

```
$ ./script11-using-a-global-variable-to-pass-a-value
Enter a value: 150
The new value is: 300
```

`$value` 变量在函数外定义并被赋值。当 dbl 函数被调用时，该变量及其值在函数中依然有效。
如果变量在函数内被赋予了新值，那么在脚本中引用该变量时，新值仍可用。

但这种情况其实很危险，尤其是想在不同的 shell 脚本中使用函数的时候，
因为这要求你清清楚楚地知道函数中具体使用了哪些变量，包括那些用来计算非返回值的变量。
这里有个例子可以说明事情是如何被搞砸的：

```bash
#!/bin/bash
# demonstrating a bad use of variables

function func1 {
	temp=$[ $value + 5 ]
	result=$[ $temp * 2 ]
}

temp=4
value=6

func1
echo "The result is $result"
if [ $temp -gt $value ]
then
	echo "temp is larger"
else
	echo "temp is smaller"
fi
```

执行脚本，输出结果如下所示：

```
$ ./script12-demonstrating-a-bad-use-of-variables
The result is 22
temp is larger
```

由于函数中用到了 `$temp` 变量，因此它的值在脚本中使用时受到了影响，产生了意想不到的后果。
有一种简单的方法可以解决函数中的这个问题，那就是使用局部变量。

无须在函数中使用全局变量，任何在函数内部使用的变量都可以被声明为局部变量。
为此，只需在变量声明之前加上 local 关键字即可：

```
local temp
```

也可以在变量赋值语句中使用 local 关键字：

```
local temp=$[ $value + 5 ]
```

local 关键字保证了变量仅在该函数中有效。如果函数之外有同名变量，那么 shell 会保持这两个变量的值互不干扰。
这意味着你可以轻松地将函数变量和脚本变量分离开，只共享需要共享的变量：

```bash
#!/bin/bash
# demonstrating the local keyword

function func1 {
	local temp=$[ $value + 5 ]
	result=$[ $temp * 2 ]
}

temp=4
value=6

func1

if [ $temp -gt $value ]
then
	echo "temp is larger"
else
	echo "temps is smaller"
fi
```

执行脚本，输出结果如下所示：

```
$ ./script13-demonstrating-the-local-keyword
temps is smaller
```

现在，当你在 func1 函数中使用 `$temp` 变量时，该变量的值不会影响到脚本主体中赋给 `$temp` 变量的值。
