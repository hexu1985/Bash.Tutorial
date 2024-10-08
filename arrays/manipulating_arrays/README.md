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
$ activities[10]="scuba diving"
$ hobbies="( ${activities[@]} )"
$ for act in `seq 0 10`
> do
> echo "$act : ${activities[$act]} / ${hobbies[$act]}"
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

向数组追加元素的方法与复制数组非常类似。最简单的追加到数组的方法是将复制数组的语句进行扩展。

```
$ hobbies=( "${activities[@]}" diving )
$ for hobby in "${hobbies[@]}"
> do
> echo "Hobby: $hobby"
> done
Hobby: swimming
Hobby: water skiing
Hobby: canoeing
Hobby: white-water rafting
Hobby: surfing
Hobby: scuba diving
Hobby: diving
$
```

当将单个项目附加到数组时，数组实际上是零索引的事实让它变得更容易。

```
$ hobbies[${#hobbies[@]}]=rowing
$ for hobby in "${hobbies[@]}"
> do
> echo "Hobby: $hobby"
> done
Hobby: swimming
Hobby: water skiing
Hobby: canoeing
Hobby: white-water rafting
Hobby: surfing
Hobby: scuba diving
Hobby: diving
Hobby: rowing
$
```

bash shell 确实具有用于组合两个数组的内置语法。
使用类似 C 的 `+=` 的表示法，此方法更简洁，并使代码更清晰。

```
$ airsports=( flying gliding parachuting )
$ activities+=("${airsports[@]}")
$ for act in "${activities[@]}"
> do
> echo "Activity: $act"
> done
Activity: swimming
Activity: water skiing
Activity: canoeing
Activity: white-water rafting
Activity: surfing
Activity: scuba diving
Activity: climbing
Activity: walking
Activity: cycling
Activity: flying
Activity: gliding
Activity: parachuting
$
```

从数组中删除元素与删除变量相同。可以使用 `myarray[3]=` 或 `unset myarray[3]`。
同样，可以 unset 整个数组。但是，`myarray=` 本身只会清除数组中第一元素的值。
所有这些情况都在接下来的代码中进行了演示。

```
$ activities=( swimming water skiing canoeing white-water rafting surfing scuba diving climbing walking cycling flying gliding parachuting )
$ for act in `seq 0 $((${#activities[@]} - 1))`
> do
> echo "Activity $act: ${activities[$act]}"
> done
Activity 0: swimming
Activity 1: water skiing
Activity 2: canoeing
Activity 3: white-water rafting
Activity 4: surfing
Activity 5: scuba diving
Activity 6: climbing
Activity 7: walking
Activity 8: cycling
Activity 9: flying
Activity 10: gliding
Activity 11: parachuting
$ activities[7]=
$ for act in `seq 0 $((${#activities[@]} - 1))`
> do
> echo "Activity $act: ${activities[$act]}"
> done
Activity 0: swimming
Activity 1: water skiing
Activity 2: canoeing
Activity 3: white-water rafting
Activity 4: surfing
Activity 5: scuba diving
Activity 6: climbing
Activity 7:
Activity 8: cycling
Activity 9: flying
Activity 10: gliding
Activity 11: parachuting
$
```

这样做的效果是创建一个稀疏数组。使用 `unset activity[7]` 几乎可以得到相同的效果。
将变量设置为空字符串与完全删除是有区别的，但它们的区别只有在 
`${variable+string}` 或使用 `${variable?string}` 形式时才会比较明显。

```
$ echo ${activities[7]}
$ echo ${activities[7]+"Item 7 is set"}
Item 7 is set
$ unset activities[7]
$ echo ${activities[7]+"Item 7 is set"}
$
```

另外，对不使用索引来引用数组被解释为对数组第一个元素的引用。
因此，以这种方式清除数组只会删除数组的第一项。

```
$ activities=
$ for act in `seq 0 $((${#activities[@]} - 1))`
> do
> echo "Activity $act: ${activities[$act]}"
> done
Activity 0:
Activity 1: water skiing
Activity 2: canoeing
Activity 3: white-water rafting
Activity 4: surfing
Activity 5: scuba diving
Activity 6: climbing
Activity 7:
Activity 8: cycling
Activity 9: flying
Activity 10: gliding
Activity 11: parachuting
```

如果对 activities 数组本身进行unset，则这个数组都会消失。
尽管你也可以使用 `unset myarray[*]`，但将数组整个删除才是正确的。


### 参考资料:
- 《Shell脚本编程诀窍 适用于Linux、Bash等》: 9.4 数组操作

