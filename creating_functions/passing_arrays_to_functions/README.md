### 向函数传递数组

向脚本函数传递数组变量的方法有点儿难以理解。将数组变量当作单个参数传递的话，它不会起作用：

```bash
#!/bin/bash
# trying to pass an array variable

function testit {
	echo "The parameters are: $@"
	thisarray=$1
	echo "The recieved array is ${thisarray[*]}"
}

myarray=(1 2 3 4 5)
echo "The original array is: ${myarray[*]}"
testit $myarray
```

执行脚本，输出结果如下所示：

```bash
$ ./script14-trying-to-pass-an-array-variable
The original array is: 1 2 3 4 5
The parameters are: 1
The recieved array is 1
```

如果试图将数组变量作为函数参数进行传递，则函数只会提取数组变量的第一个元素。

要解决这个问题，必须先将数组变量拆解成多个数组元素，然后将这些数组元素作为函数参数传递。
最后在函数内部，将所有的参数重新组合成一个新的数组变量。来看下面的例子：

```bash
#!/bin/bash
# array variable to function test

function testit {
	local newarray
	newarray=(`echo "$@"`)
	echo "The new array value is: ${newarray[*]}"
}

myarray=(1 2 3 4 5)
echo "The original array is ${myarray[*]}"
testit ${myarray[*]}
```

执行脚本，输出结果如下所示：

```bash
$ ./script15-array-variable-to-function-test
The original array is 1 2 3 4 5
The new array value is: 1 2 3 4 5
```

该脚本用 `$myarray` 变量保存所有的数组元素，然后将其作为参数传递给函数。
该函数随后根据参数重建数组变量。在函数内部，数组可以照常使用：

```bash
#!/bin/bash
# adding values in an array

function addarray {
	local sum=0
	local newarray
    newarray=(`echo "$@"`)
	for value in ${newarray[*]}
	do
		sum=$[ $sum + $value ]
	done
	echo $sum
}

myarray=(1 2 3 4 5)
echo "The original array is: ${myarray[*]}"
arg1=$(echo ${myarray[*]})
result=$(addarray $arg1)
echo "The result is $result"
```

执行脚本，输出结果如下所示：

```bash
$ ./script16-adding-values-in-an-array
The original array is: 1 2 3 4 5
The result is 15
```

addarray 函数遍历了所有的数组元素，并将它们累加在一起。
你可以在 myarray 数组变量中放置任意数量的值，addarry 函数会将它们依次相加。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 17.4.1 向函数传递数组

