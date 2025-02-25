### 脚本函数基础

函数是一个脚本代码块，你可以为其命名并在脚本中的任何位置重用它。
每当需要在脚本中使用该代码块时，直接写函数名即可（这叫作调用函数）。

**创建函数**

在 bash shell 脚本中创建函数的语法有两种。
第一种语法是使用关键字 function，随后跟上分配给该代码块的函数名：

```bash
function name {
    commands
}
```

name 定义了该函数的唯一名称。脚本中的函数名不能重复。
commands 是组成函数的一个或多个 bash shell 命令。
调用该函数时，bash shell 会依次执行函数内的命令，就像在普通脚本中一样。

第二种在 bash shell 脚本中创建函数的语法更接近其他编程语言中定义函数的方式：

```bash
name() {
    commands
}
```

函数名后的空括号表明正在定义的是一个函数。这种语法的命名规则和第一种语法一样。


**使用函数**

要在脚本中使用函数，只需像其他 shell 命令一样写出函数名即可：

```bash
#!/bin/bash
# using a function in a script

function func1 {
    echo "This is an example of a function"
}

count=1
while [ $count -le 5 ]
do
    func1
    count=$[ $count + 1 ]
done
echo "This is the end of the loop"
func1
echo "Now this is the end of the script"
```

执行脚本，输出结果如下所示：

```
$ ./script01-using-a-function-in-a-script
This is an example of a function
This is an example of a function
This is an example of a function
This is an example of a function
This is an example of a function
This is the end of the loop
This is an example of a function
Now this is tne end of the script
```

每次引用函数名 func1 时，bash shell 会找到 func1 函数的定义并执行在其中定义的命令。
函数定义不一定非要放在 shell 脚本的最开始部分，但是要注意这种情况。
如果试图在函数被定义之前调用它，则会收到一条错误消息：

```bash
#!/bin/bash
# using a function located in the middle of a script

count=1
echo "This line comes before the function definition"

function func1 {
	echo "This is an example of a function"
}

while [ $count -le 5 ]
do
	func1
	count=$[ $count + 1 ]
done
echo "This is the end of the loop"
func2
echo "Now this is the end of the script"

function func2 {
	echo "This is an example of a function"
}
```

执行脚本，输出结果如下所示：

```bash
$ ./script02-using-a-function-located-in-the-middle-of-a-script
This line comes before the function definition
This is an example of a function
This is an example of a function
This is an example of a function
This is an example of a function
This is an example of a function
This is the end of the loop
./script02-using-a-function-located-in-the-middle-of-a-script: 行 17: func2：未找到命令
Now this is the end of the script
```

脚本试图在 func2 函数被定义之前就调用该函数。由于 func2 函数此时尚未定义，因此在调用 func2 时，产生了一条错误消息。

另外也要注意函数名。记住，函数名必须是唯一的，否则就会出问题。如果定义了同名函数，
那么新定义就会覆盖函数原先的定义，而这一切不会有任何错误消息：

```bash
#!/bin/bash
# testing using a duplicate function name

function func1 {
	echo "This is the first definition of the function name"
}

func1

function func1 {
	echo "This is a repeat of the same function name"
}

func1
echo "This is the end of the script"
```

执行脚本，输出结果如下所示：

```bash
$ ./script03-testing-using-a-duplicate-function-name
This is the first definition of the function name
This is a repeat of the same function name
This is the end of the script
```

func1 函数最初的定义工作正常，但重新定义该函数后，后续的函数调用会使用第二个定义。

### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 17.1 脚本函数基础
