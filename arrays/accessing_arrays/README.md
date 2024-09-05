### 数组的访问

访问数组值的基本方法与为数组赋值的方法大致相同。
大括号是强制性的。如果省略索引，则假定访问第一个元素。

以名为 numberarray 数组为例，以下代码添加了一些 echo 语句来显示赋值后的值。
请注意，稀疏数组表示没有 numberarray[2] 存在。

```
$ numberarray[0]=zero
$ numberarray[1]=one
$ numberarray[3]=three
$ echo ${numberarray[0]}
zero
$ echo ${numberarray[2]}
$ echo ${numberarray[3]}
three
$
```

如果要不用大括号来访问 `$numberarray[1]`，shell 将会把 `$numberarray` 解释为 numberArray 中的第一个元素，
[1] 作为文本字符串。这会返回文本字符串 `zero[1]` ，这不是我们想要的。

```
$ echo $numberarray[1]
zero[1]
$
```

计算数组元素的数量与计算常规变量的长度非常相似。`${#myvar}` 给出了 `$myvar` 变量中包含的字符串的长度，
`${#myarray[@]}` 或 `${#myarray[*]}` 返回数组中的元素个数。
对于稀疏数组，这只是返回数组中的实际赋过值的元素数目，这与数组使用的最大索引不同。
