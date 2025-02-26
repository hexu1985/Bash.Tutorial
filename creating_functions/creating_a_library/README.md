### 创建库

使用函数可以为脚本省去一些重复性的输入工作，这一点是显而易见的。
但如果你碰巧要在多个脚本中使用同一段代码呢？
就为了使用一次而在每个脚本中都定义同样的函数，这显然很麻烦。

有一种方法能解决这个问题。bash shell 允许创建函数库文件，然后在多个脚本中引用此库文件。

这个过程的第一步是创建一个包含脚本中所需函数的公用库文件。来看一个库文件 myfuncs，
其中定义了 3 个简单的函数：

```bash
$ cat myfuncs
#!/bin/bash
# my script functions

function addem {
        echo $[ $1 + $2 ]
}

function multem {
        echo $[ $1 * $2 ]
}

function divem {
        if [ $2 -ne 0 ]
        then
                echo $[ $1 / $2 ]
        else
                echo -1
        fi
}
```

第二步是在需要用到这些函数的脚本文件中包含 myfuncs 库文件。这时候，事情变得棘手起来。

问题出在 shell 函数的作用域上。和环境变量一样，shell 函数仅在定义它的 shell 会话内有效。
如果在 shell 命令行界面运行 myfuncs 脚本，那么 shell 会创建一个新的 shell 并在其中运行这个脚本。
在这种情况下，以上 3 个函数会定义在新 shell 中，当你运行另一个要用到这些函数的脚本时，它们是无法使用的。

这同样适用于脚本。如果尝试像普通脚本文件那样运行库文件，那么这 3 个函数也不会出现在脚本中：

```bash
#!/bin/bash
# using a library file the wrong way

./myfuncs

result=$(addem 10 15)
echo "The result is $result"
```

执行脚本，输出结果如下所示：

```bash
$ ./script19-using-a-library-file-the-wrong-way
./script19-using-a-library-file-the-wrong-way: 行 6: addem: 未找到命令
The result is
```

使用函数库的关键在于 source 命令。source 命令会在当前 shell 的上下文中执行命令，
而不是创建新的 shell 并在其中执行命令。
可以用 source 命令在脚本中运行库文件。这样脚本就可以使用库中的函数了。

source 命令有个别名，称作点号操作符。要在 shell 脚本中运行 myfuncs 库文件，只需添加下面这一行代码：

```bash
. ./myfuncs
```

这个例子假定 myfuncs 库文件和 shell 脚本位于同一目录。
如果不是，则需要使用正确路径访问该文件。来看一个使用 myfuncs 库文件创建脚本的例子：

```bash
#!/bin/bash
# using functions defined in a library file

. ./myfuncs

value1=10
value2=5
result1=$(addem $value1 $value2)
result2=$(multem $value1 $value2)
result3=$(divem $value1 $value2)

echo "The result of adding them is: $result1"
echo "The result of multiplying them is: $result2"
echo "The result of dividing them is: $result3"
```

执行脚本，输出结果如下所示：

```bash
$ ./script20-using-functions-defined-in-a-library-file 
The result of adding them is: 15
The result of multiplying them is: 50
The result of dividing them is: 2
```

脚本成功地使用了 myfuncs 库文件中定义的函数。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 17.6 创建库


