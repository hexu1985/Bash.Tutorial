### echo命令

echo是用于终端打印的最基本命令。
默认情况下，echo在每次调用后会添加一个换行符

Shell 的 echo 指令与 PHP 的 echo 指令类似，都是用于字符串的输出。命令格式：

```bash
$ echo "Welcome to Bash"
Welcome to Bash
```

您可以使用echo实现更复杂的输出格式控制。

**1. 显示普通字符串:**

```bash
echo "It is a test"
```

这里的双引号完全可以省略，以下命令与上面实例效果一致：
```
echo It is a test
```

**2. 显示转义字符**

```bash
echo "\"It is a test\""
```

结果将是:
```
"It is a test"
```

同样，双引号也可以省略

**3. 显示变量**

read 命令从标准输入中读取一行,并把输入行的每个字段的值指定给 shell 变量
```bash
#!/bin/bash

read name 
echo "$name It is a test"
```

以上代码保存为 test.sh，name 接收标准输入的变量，结果将是:
```
$ bash test.sh
OK                     #标准输入
OK It is a test        #输出
```

**4. 显示换行**

```bash
#!/bin/bash

echo -e "OK! \n" # -e 开启转义
echo "It is a test"
```

输出结果：

```
OK!

It is a test
```

**5. 不显示换行**

```bash
#!/bin/bash

echo -n "OK!"
echo "It is a test"
```

输出结果：

```
OK! It is a test
```

**6. 显示结果定向至文件**

```bash
echo "It is a test" > myfile
```

**7. 原样输出字符串，不进行转义或取变量(用单引号)**

```bash
echo '$name\"'
```

输出结果：

```
$name\"
```

**8. 显示命令执行结果**

```bash
echo `date`
```

注意： 这里使用的是反引号 \`, 而不是单引号 '。

结果将显示当前日期

```
Thu Jul 24 10:08:46 CST 2014
```


### 参考资料:
- [菜鸟教程 - shell 教程](https://www.runoob.com/linux/linux-shell.html)
- 《Linux Shell脚本攻略 第3版》: 1.2 在终端中显示输出
