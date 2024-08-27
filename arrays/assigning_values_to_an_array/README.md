### 为数组赋值

为数组赋值有两种方法，单个值可以使用下列方法：

```bash
name[subscript]=value
```

其中，name是数组名，subscript是一个大于或等于0的整数（或者算术表达式）。
注意，数组的第一个元素的索引是0，而非1。value是赋给该元素的字符串或整数。

多个值可以使用下列方法：

```bash
name=(value1 value2 ...)
```

其中，name是数组名，value是依次赋给数组元素（从元素0开始）的一系列值。
例如，如果我们想将一周中各天的缩写赋给数组days，可以这么做：

```bash
$ days=(Sun Mon Tue Wed Thu Fri Sat)
```

也可以通过指定各个值的索引，将值赋给特定元素：

```bash
$ days=([0]=Sun [1]=Mon [2]=Tue [3]=Wed [4]=Thu [5]=Fri [6]=Sat)
```


### 参考资料:
- 《Linux命令行大全 第2版》: 35.1.2 为数组赋值

