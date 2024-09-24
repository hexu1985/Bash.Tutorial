### 子串的变量扩展

| 表达式                 | 功能                                                         |
| ---------------------- | ------------------------------------------------------------ |
| `${variable%pattern}`  | 将变量variable值的尾部与模式pattern进行最小匹配，并将匹配到的部分删除 |
| `${variable%%pattern}` | 将变量variable值的尾部与模式pattern进行最大匹配，并将匹配到的部分删除 |
| `${variable#pattern}`  | 将变量variable值的头部与模式pattern进行最小匹配，并将匹配到的部分删除 |
| `${variable##pattern}` | 将变量variable值的头部与模式pattern进行最大匹配，并将匹配到的部分删除 |
| `${#variable}`         | 替换为变量中的字符个数。如果是`*`或`@`，长度则是位置参数的个数 |


示例1：

```
$ pathname="/usr/bin/local/bin"
$ echo ${pathname%/bin*}
/usr/bin/local
$
```

示例2：

```
$ pathname="usr/bin/local/bin"
$ echo ${pathname%%/bin*}
usr
$
```

示例3：

```
$ pathname=/home/lilliput/jake/.bashrc
$ echo ${pathname#/home}
/lilliput/jake/.bashrc
$
```

示例4：

```
$ pathname=/home/lilliput/jake/.bashrc
$ echo ${pathname##*/}
.bashrc
$
```

示例5：

```
$ name="Ebenezer Scrooge"
$ echo ${#name}
16
$
```

### 参考资料:
- 《UNIX Shell范例精解（第4版）》: 13.10.9 子串的变量扩展
