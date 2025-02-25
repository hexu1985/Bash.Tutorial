### 无显示读取

有时你需要从脚本用户处得到输入，但又不想在屏幕上显示输入信息。
典型的例子就是输入密码，但除此之外还有很多种需要隐藏的数据。

`-s` 选项可以避免在 read 命令中输入的数据出现在屏幕上（其实数据还是会被显示，只不过 read 命令将文本颜色设成了跟背景色一样）。
来看一个在脚本中使用 `-s` 选项的例子：

```bash
#!/bin/bash
# Hiding input data
#
read -s -p "Enter your password: " pass
echo
echo "Your password is $pass"
exit
```

执行脚本，输出结果如下所示：

```bash
$ ./29-hiding-input-data-from-the-monitor
Enter your password:
Your password is abc
```

屏幕上不会显示输入的数据，但这些数据会被赋给变量，以便在脚本中使用。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 14.6.3 无显示读取

