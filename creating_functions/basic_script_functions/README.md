### 脚本函数基础

函数是一个脚本代码块，你可以为其命名并在脚本中的任何位置重用它。
每当需要在脚本中使用该代码块时，直接写函数名即可（这叫作调用函数）。

**创建函数**

在 bash shell 脚本中创建函数的语法有两种。
第一种语法是使用关键字 function，随后跟上分配给该代码块的函数名：

```shell
function name {
    commands
}
```

name 定义了该函数的唯一名称。脚本中的函数名不能重复。
commands 是组成函数的一个或多个 bash shell 命令。
调用该函数时，bash shell 会依次执行函数内的命令，就像在普通脚本中一样。

第二种在 bash shell 脚本中创建函数的语法更接近其他编程语言中定义函数的方式：

```shell
name() {
    commands
}
```

函数名后的空括号表明正在定义的是一个函数。这种语法的命名规则和第一种语法一样。


**使用函数**

要在脚本中使用函数，只需像其他 shell 命令一样写出函数名即可：

```shell
#!/bin/bash

# using a function in a script

function func1 {
	echo "This is an example of a function"
}

for ((count = 1; count <= 5; count++))
do
	func1
done

echo "This is the end of the loop"
func1
echo "Now this is tne end of the script"
```

执行脚本，输出结果如下所示：

```shell
This is an example of a function
This is an example of a function
This is an example of a function
This is an example of a function
This is an example of a function
This is the end of the loop
This is an example of a function
Now this is tne end of the script
```

### 参考资料:
- 《Linux Command Line and Shell Scripting Bible》: Chapter 17: Creating Functions

