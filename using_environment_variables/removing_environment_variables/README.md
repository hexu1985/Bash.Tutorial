### 删除环境变量

可以用 unset 命令删除已有的环境变量。在 unset 命令中引用环境变量时，记住不要使用`$`。

```
$ my_variable="I am going to be removed"
$ echo $my_variable
I am going to be removed
$
$ unset my_variable
$ echo $my_variable
$
```

在处理全局环境变量时，事情就有点儿棘手了。如果是在子进程中删除了一个全局环境变量，
那么该操作仅对子进程有效。该全局环境变量在父进程中依然可用：

```
$ export my_variable="I am Global now"
$ echo $my_variable
I am Global now
$
$ bash
$ echo $my_variable
I am Global now
$ unset my_variable
$ echo $my_variable
$ exit
exit
$ echo $my_variable
I am Global now
$
```

和修改变量一样，在子 shell 中删除全局变量后，无法将效果反映到父 shell 中。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 6.3 删除环境变量
