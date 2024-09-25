### 子串的变量扩展

模式匹配变量用来在字符串首或字符串尾截掉串的某一特定部分。
这些运算符最常见的用途是从路径头或为删除路径名元素。

| 表达式                 | 功能                                                         |
| ---------------------- | ------------------------------------------------------------ |
| `${variable%pattern}`  | 将变量variable值的尾部与模式pattern进行最小匹配，并将匹配到的部分删除 |
| `${variable%%pattern}` | 将变量variable值的尾部与模式pattern进行最大匹配，并将匹配到的部分删除 |
| `${variable#pattern}`  | 将变量variable值的头部与模式pattern进行最小匹配，并将匹配到的部分删除 |
| `${variable##pattern}` | 将变量variable值的头部与模式pattern进行最大匹配，并将匹配到的部分删除 |
| `${#variable}`         | 替换为变量中的字符个数。如果是`*`或`@`，长度则是位置参数的个数 |


示例1：

```
1 $ pathname="/usr/bin/local/bin"
2 $ echo ${pathname%/bin*}
  /usr/bin/local
```

1. 给局部变量 pathname 赋值 `/usr/bin/local/bin`。
2. `%` 删除 pathname 中包含模式 `/bin` 的最小尾随部分，后跟零个或多个字符；也就是说，它去除了 `/bin`。


示例2：

```
1 $ pathname="usr/bin/local/bin"
2 $ echo ${pathname%%/bin*}
  /usr
```

1. 给局部变量 pathname 赋值 `/usr/bin/local/bin`。
2. `%%` 删除 pathname 中包含模式 `/bin` 的最大尾随部分，后跟零个或多个字符；也就是说，它去除了 `/bin/local/bin`。


示例3：

```
1 $ pathname=/home/lilliput/jake/.bashrc
2 $ echo ${pathname#/home}
  /lilliput/jake/.bashrc
```

1. 局部变量 pathname 被分配了 `/home/lilliput/jake/.bashrc`。
2. `#` 删除 pathname 中包含模式 `/home` 的路径名的最小前导部分；也就是说，pathname 变量的开头删除 `/home`。


示例4：

```
1 $ pathname=/home/lilliput/jake/.bashrc
2 $ echo ${pathname##*/}
  .bashrc
```

1. 局部变量 pathname 被分配了 `/home/lilliput/jake/.bashrc`。
2. `##` 删除 pathname 中最大的前导部分，其中包含零个或多个字符，直到最后一个斜杠（包括最后一个斜杠）；
   也就是说，它从 pathname 变量的开头删除 `/home/lilliput/jake`。


示例5：

```
1 $ name="Ebenezer Scrooge"
2 $ echo ${#name}
  16
```

1. 给变量 name 赋值 Ebenezer Scrooge。
2. `${#variable}` 语法显示赋给变量 name 的字符串中字符的个数。
   字符串Ebenezer Scrooge 中有 16 个字符。


### 参考资料:
- 《UNIX Shell范例精解（第4版）》: 13.10.9 子串的变量扩展
