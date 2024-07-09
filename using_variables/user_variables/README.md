### 用户自定义变量

除了环境变量，shell 脚本还允许用户在脚本中定义和使用自己的变量。

用户自定义变量的名称可以是任何由字母、数字或下划线组成的字符串。
因为变量名区分大小写，所以变量 Var1 和变量 var1 是不同的。

使用等号为变量赋值。在变量、等号和值之间不能出现空格。

下面是一些为用户自定义变量赋值的例子：

```shell
var1=10
var2=-57
var3=testing
var4="still more testing"
```

shell 脚本会以字符串形式存储所有的变量值，脚本中的各个命令可以自行决定变量值的数据类型。
shell 脚本中定义的变量在脚本的整个生命周期里会一直保持着它们的值，在脚本结束时会被删除。

与系统变量类似，用户自定义变量可以通过$引用，用法如下：

```shell
#!/bin/bash

# testing variables

days=10
guest="Katie"
echo "$guest checked in $days days ago"
days=5
guest="Jessica"
echo "$guest checked in $days days ago"
```

运行脚本会有下列输出：

```
$ chmod u+x test3
$ ./test3
Katie checked in 10 days ago
Jessica checked in 5 days ago
```


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 11.4.2 用户自定义变量

