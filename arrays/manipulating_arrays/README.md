### 数组操作

数组与其他变量在结构上是有差异的。这意味着对数组进行操作需要一些新的语法。
只要可能，对数组的操作在语法上与对字符串做同样的操作都非常相似。
但在某些情况下，该语法不够灵活。

将一个数组复制到另一个数组很简单。对于引用和空格来说，重要的是使用格式 `${array[@]}` 格式（而不是 `${array[*]}`），
并且药用双引号将整个结构括起来。下面的例子非常清晰地显示了使用其他形式时产生的效果。

```
$ activities=( swimming "water skiing" canoeing "white-water rafting" surfing )
$ for act in ${activities[@]}
> do
> echo "Activity: $act"
> done
Activity: swimming
Activity: water
Activity: skiing
Activity: canoeing
Activity: white-water
Activity: rafting
Activity: surfing
$
```

这里发生的事情是，因为列表周围没有双引号，swimming 、 water 和 skiing 都被视为单独的词。
在周围添加双引号可以修正这一问题：

```
$ for act in "${activities[@]}"
> do
> echo "Activity: $act"
> done
Activity: swimming
Activity: water skiing
Activity: canoeing
Activity: white-water rafting
Activity: surfing
$
```

同样，星号 `*` 对于带或不带引号都不适合。如果没有引号，它的作用与 `@` 符号相同。
如果使用引号，整个数组被归结为一个字符串。

```
$ for act in ${activities[*]}
> do
> echo "Activity: $act"
> done
Activity: swimming
Activity: water
Activity: skiing
Activity: canoeing
Activity: white-water
Activity: rafting
Activity: surfing
$ for act in "${activities[*]}"
> do
> echo "Activity: $act"
> done
Activity: swimming water skiing canoeing white-water rafting surfing
$
```

因此，要复制数组，请定义一个值为 "${activities[@]}" 的新数组。
这将以与前面代码中的 for 循环得到正确处理相同的方式保留空格的空白。
这如下面的代码所示。

```
$ hobbies=( "${activities[@]}" )
$ for hobby in "${hobbies[@]}"
> do
> echo "Hobby: $hobby"
> done
Hobby: swimming
Hobby: water skiing
Hobby: canoeing
Hobby: white-water rafting
Hobby: surfing
$
```

但是，这不适用于稀疏数组。索引的实际值不是以这种方式来传递的，
因此 hobbies 数组不能是 activities 数组的真实副本。

```
$ activities[10]=”scuba diving”
$ hobbies=”( ${activities[@]} )”
$ for act in `seq 0 10`
> do
> echo “$act : ${activities[$act]} / ${hobbies[$act]}”
> done
0 : swimming / swimming
1 : water skiing / water skiing
2 : canoeing / canoeing
3 : white-water rafting / white-water rafting
4 : surfing / surfing
5 : / scuba diving
6 : /
7 : /
8 : /
9 : /
10 : scuba diving /
$
```
