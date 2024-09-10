### 关联数组

关联数组是 bash 4.0 中的一项新功能。关联数组将值和索引连接（关联）到一起，所以我们可以将元数据与实际数据相关联。
使用这种方式可以将音乐家与他的乐器相关联。关联数组必须使用大写的 `declare -A` 命令来进行声明。

```bash
#!/bin/bash

declare -A beatles
beatles=( [singer]=John [bassist]=Paul [drummer]=Ringo [guitarist]=George )

for musician in singer bassist drummer guitarist
do
  echo "The ${musician} is ${beatles[$musician]}."
done
```

运行这个脚本时，会产生如下输出：

```
$ ./musicians.sh
The singer is John.
The bassist is Paul.
The drummer is Ringo.
The guitarist is George.
$
```

使关联数组更有用的是能够引用回索引。这意味着给定乐器的名称，您可以获取音乐家的名字。
还可以给出音乐家的名字，你可以确定他的乐器。为此，请使用 `${!array[@]}` 语法。

```bash
#!/bin/bash

declare -A beatles
beatles=( [singer]=John [bassist]=Paul [drummer]=Ringo [guitarist]=George )

for instrument in ${!beatles[@]}
do
  echo "The ${instrument} is ${beatles[$instrument]}"
done
```

运行这个脚本时，会产生如下输出：

```
$ ./instruments.sh
The bassist is Paul
The singer is John
The guitarist is George
The drummer is Ringo
$
```

### 参考资料:
- 《Shell脚本编程诀窍 适用于Linux、Bash等》: 9.3 关联数组

