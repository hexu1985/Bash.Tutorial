### 向函数传递参数

bash shell 会将函数当作小型脚本来对待。这意味着你可以像普通脚本那样向函数传递参数。

函数可以使用标准的位置变量来表示在命令行中传给函数的任何参数。
例如，函数名保存在 `$0` 变量中，函数参数依次保存在 `$1` 、`$2` 等变量中。
也可以用特殊变量`$#`来确定传给函数的参数数量。

在脚本中调用函数时，必须将参数和函数名放在同一行，就像下面这样：

```
func1 $value1 10
```

来看一个使用此方法向函数传递参数的例子：

```bash
#!/bin/bash
# passing parameters to a function

function addem {
	if [ $# -eq 0 ] || [ $# -gt 2 ]
	then
		echo -1
	elif [ $# -eq 1 ]
	then
		echo $[ $1 + $1 ]
	else
		echo $[ $1 + $2 ]
	fi
}

echo -n "Adding 10 and 15: "
value=$(addem 10 15)
echo $value

echo -n "Let's try adding just one number: "
value=$(addem 10)
echo $value

echo -n "Now trying adding no numbers: "
value=$(addem)
echo $value

echo -n "Finally, try adding three numbers: "
value=$(addem 10 15 20)
echo $value
```

执行脚本，输出结果如下所示：

```
$ ./script08-passing-parameters-to-a-function
Adding 10 and 15: 25
Let's try adding just one number: 20
Now trying adding no numbers: -1
Finally, try adding three numbers: -1
```

脚本中的 addem 函数首先会检查脚本传给它的参数数目。
如果没有参数或者参数多于两个，那么 addem 会返回-1。
如果只有一个参数，那么 addem 会将参数与自身相加。
如果有两个参数，则 addem 会将二者相加。

由于函数使用位置变量访问函数参数，因此无法直接获取脚本的命令行参数。
下面的例子无法成功运行：

```bash
#!/bin/bash
# trying to access script parameters inside a function

function badfunc1 {
	echo $[ $1 * $2 ]
}

if [ $# -eq 2 ]
then
	value=$(badfunc1)
	echo "The result is $value"
else
	echo "Usage: $(basename $0) a b"
fi
```

执行脚本，输出结果如下所示：

```
$ ./script09-trying-to-access-script-parameters-inside-a-function
Usage: script09-trying-to-access-script-parameters-inside-a-function a b
$ ./script09-trying-to-access-script-parameters-inside-a-function 10 15
./script09-trying-to-access-script-parameters-inside-a-function: 行 10: *  : 语法错误: 需要操作数 (错误符号是 "*  ")
The result is
$
```

尽管函数使用了 `$1` 变量和 `$2` 变量，但它们和脚本主体中的 `$1` 变量和 `$2` 变量不是一回事。
要在函数中使用脚本的命令行参数，必须在调用函数时手动将其传入：

```bash
#!/bin/bash
# trying to access script parameters inside a function good way

function func7 {
	echo $[ $1 * $2 ]
}

if [ $# -eq 2 ]
then
	value=$(func7 $1 $2)
	echo "The result is $value"
else
	echo "Usage: $(basename $0) a b"
fi
```

执行脚本，输出结果如下所示：

```
$ ./script10-trying-to-access-script-parameters-inside-a-function-good-way
Usage: script10-trying-to-access-script-parameters-inside-a-function-good-way a b
$ ./script10-trying-to-access-script-parameters-inside-a-function-good-way 10 15
The result is 150
```

在将 `$1` 变量和 `$2` 变量传给函数后，它们就能跟其他变量一样，可供函数使用了。

### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 17.3.1 向函数传递参数

