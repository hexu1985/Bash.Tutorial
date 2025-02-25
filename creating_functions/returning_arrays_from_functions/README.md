### 从函数返回数组

函数向 shell 脚本返回数组变量的方法：函数先用 echo 语句按正确顺序输出数组的各个元素，
然后脚本再将数组元素重组成一个新的数组变量：

```bash
#!/bin/bash
# returning an array value

function arraydblr {
    local origarray
    local newarray
    local elements
    local i
    origarray=($(echo "$@"))
    newarray=($(echo "$@"))
    elements=$[ $# - 1 ]
    for (( i = 0; i <= $elements; i++ ))
    {
        newarray[$i]=$[ ${origarray[$i]} * 2 ]
    }
    echo ${newarray[*]}
}
myarray=(1 2 3 4 5)
echo "The original array is: ${myarray[*]}"
arg1=$(echo ${myarray[*]})
result=($(arraydblr $arg1))
echo "The new array is: ${result[*]}"
```

执行脚本，输出结果如下所示：

```bash
$ ./script17-returning-an-array-value
The original array is: 1 2 3 4 5
The new array is: 2 4 6 8 10
```

该脚本通过 `$arg1` 变量将数组元素作为参数传给 arraydblr 函数。
arraydblr 函数将传入的参数重组成新的数组变量，生成该数组变量的副本。
然后对数据元素进行遍历，将每个元素的值翻倍，并将结果存入函数中的数组变量副本。

arraydblr 函数使用 echo 语句输出每个数组元素的值。脚本用 arraydblr 函数的输出重组了一个新的数组变量。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 17.4.2 从函数返回数组


