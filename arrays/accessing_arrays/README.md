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

另请注意，`${#myarray}` 返回 `${myarray[0]}` 中的字符串长度，而不是 `$myarray` 数组中的元素数。
要获取数组中第三项的长度，语法为 `${#array[2]}`，因为数组是从0开始索引的。
第一项的长度为 `${#array[0]}` ，`${#array[1]}` 是第二项的长度。

```
$ fruits=( apple banana pear orange )
$ echo ${#fruits[@]}
4
$ echo ${#fruits}
5
$ echo ${#fruits[0]}
5
$ echo ${#fruits[1]}
6
$ echo ${#fruits[2]}
4
$ echo ${#fruits[3]}
6
$
```

索引不必是硬编码出来的整数，它也可以是其他变量的值。所以你可以使用变量来遍历（非稀疏）数组，
甚至可以随机访问数组。此示例显示了四个 Beatles 的迭代，索引为 0-3。
命令 `seq 0 $((${#beatles[@]} - 1))` 从 0 到 3，或者更准确地说，从 0 到 (4–1)，
其中 4 是数组的长度，但由于数组是从0开始索引的，因此四个元素的索引为 0 到 3。

下面的脚本添加索引为 5 的第五个元素，创建一个稀疏数组（缺少元素 4），因此
Stuart Sutcliffe（或者应该是 Pete Best？）没有被这个循环所访问。

```bash
#!/bin/bash

beatles=( John Paul Ringo George )
for index in $(seq 0 $((${#beatles[@]} - 1)))
do
  echo "Beatle $index is ${beatles[$index]}."
done

echo "Now again with the fifth beatle..."
beatles[5]=Stuart

for index in $(seq 0 $((${#beatles[@]} - 1)))
do
  echo "Beatle $index is ${beatles[$index]}."
done
echo "Missed it; Beatle 5 is ${beatles[5]}."
```

运行这个脚本时，会产生如下输出：

```
$ ./index.sh
Beatle 0 is John.
Beatle 1 is Paul.
Beatle 2 is Ringo.
Beatle 3 is George.
Now again with the fifth beatle...
Beatle 0 is John.
Beatle 1 is Paul.
Beatle 2 is Ringo.
Beatle 3 is George.
Beatle 4 is .
Missed it; Beatle 5 is Stuart.
```

只要数组不是关联型的，我们就还可以在 [] 括号内进行基本数学运算。
这不仅可以使代码更易于编写，还使代码更具可读性。

有时需要从数组中选择一定范围的元素，这是以类似 substr 的方式完成的，
方法是给数组提供起始索引和元素数量。简单的 `${food[@]:0:1}` 可以获得第一个元素，
`:1:1` 得到第二个，`:2:1` 得到第三个，以此类推。
这与使用 `${food[0]}`、`${food[1]}` 和 `${food[2]}` 相同，显然不是很有用。

```
$ food=( apples bananas cucumbers dates eggs fajitas grapes )
$ echo ${food[@]:0:1}
apples
$ echo ${food[@]:1:1}
bananas
$ echo ${food[@]:2:1}
cucumbers
$ echo ${food[@]:7:1}
$
```

扩大范围使机制更加灵活。通过替换前面代码中最后的 `:1`，您可以从数组中检索一组元素。

```
$ echo ${food[@]:2:4}
cucumbers dates eggs fajitas
$ echo ${food[@]:0:3}
apples bananas cucumbers
$
```

如果你更进一步，可以省略元素数量。这将检索从提供的偏移量开始的数组。

```
$ echo ${food[@]:3}
dates eggs fajitas grapes
$ echo ${food[@]:1}
bananas cucumbers dates eggs fajitas grapes
$ echo ${food[@]:6}
grapes
$
```

要显示整个数组的变量，简单的 `echo ${array[@]}` 就足够了，但不是特别吸引力：

```
$ distros=( Ubuntu Fedora Debian openSuSE Sabayon Arch Puppy )
$ echo ${distros[@]}
Ubuntu Fedora Debian openSuSE Sabayon Arch Puppy
```

更灵活的选项是使用 printf 向输出添加文本和格式。
printf 将格式化数组中的每个元素都具有相同的格式字符串，因此这几乎模拟了一个循环：

```
$ printf "Distro: %s\n" "${distros[@]}"
Distro: Ubuntu
Distro: Fedora
Distro: Debian
Distro: openSuSE
Distro: Sabayon
Distro: Arch
Distro: Puppy
$
```

### 参考资料:
- 《Shell脚本编程诀窍 适用于Linux、Bash等》: 9.2 数组的访问


