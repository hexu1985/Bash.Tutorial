### 数组的赋值

有很多不同的方法可以为数组赋值。尽管有些比较类似，但是有三种主要方法可以分配值，
分别为 “一次一个”，“一次全部” 或介于两者之间的“按索引”。
还可以从各种来源（包括通配符扩展和程序输出）为数组赋值。

如果数组是通过 “一次一个” 或 “一次全部” 方法声明的，则 shell 会自动检测是否有数组正在被声明。
另外，语句 `declare -a myarray` 可以用来向 shell 声明此变量将被视为数组。

设置数组值的最简单、最直接的方法是每次对一个元素进行赋值。就像常规变量一样，在赋值值时不使用美元（`$`）符号，
只再引用时才使用。在变量名称后面的索引号要使用方括号括起来：

```bash
numberarray[0]=zero
numberarray[1]=one
numberarray[2]=two
numberarray[3]=three
```

除了简单明了之外，这种方式的另一个优点是可以定义稀疏数组。在下面的示例中，数组中没有第3项 （“two”） ：

```bash
numberarray[0]=zero
numberarray[1]=one
numberarray[3]=three
```

与常规变量一样，在值中可以包含空格，但需要用引号括起来，或反斜杠将空格转义：

```bash
country[0]=”United States of America”
country[1]=United\ Kingdom
country[2]=Canada
country[3]=Australia
```

分配数组的更有效方法是在单个命令中列出所有值。可以通过以下方式执行此操作，
只需在以空格分隔的列表中列出值，并用括号括起来：

```bash
students=( Dave Jennifer Michael Alistair Lucy Richard Elizabeth )
```

这样做的一个缺点是不能以这种方式创建稀疏数组。另一个缺点是必须预先知道要赋的值，
并能够将它们硬编码到脚本中或由脚本自行计算它们。

IFS 中的任何字符都可用于分隔元素，包括换行符。将数组定义拆分为多行是完全合法的。
您甚至可以用注释结束这一行。
在下面的代码中，students 被分成单独的几行，每行以一个注释结束，每行的按列表子集表示每组学生代表的那个年份。

```bash
#!/bin/bash

students=( Dave Jennifer Michael    # year 1
  Alistair Lucy Richard Elizabeth   # year 2
  Albert Roger Dennis James Roy     # year 3
  Rory Jim Andi Elaine Clive        # year 4
  )

for name in ${students[@]}
do
  echo -en "$name "
done
echo
```

运行这个脚本时，会产生如下输出：


```
$ ./studentarray.sh 
Dave Jennifer Michael Alistair Lucy Richard Elizabeth Albert Roger Dennis James Roy Rory Jim Andi Elaine Clive 
```

也可以通过指定各个值的索引，将值赋给特定元素，
这种方法是“一次一个”方法的简写版本，或者把它看成是“一次全部” 方法的更明确版本。
这种方法要在一组括号中，说明索引和值。这主要在创建稀疏数组时有用，但也可以作为一种明确元素索引位置的方法，
而无需使用冗长的 “一次一个” 方法，该方法需要每次都提供变量的名称。

此方法在使用关联数组时也特别有用。
以下代码段分配了前 32 个 ASCII 字符的名称添加到数组中。
这对于确认名称是否位于正确的位置非常有用。
例如你可以很容易地看到 CR 位于索引 13 处，而不必从开头数它的索引位置。

```bash
nonprinting=([0]=NUL [1]=SOH [2]=STX [3]=ETX [4]=EOT [5]=ENQ
 [6]=ACK [7]=BEL [8]=BS [9]=HT [10]=LF [11]=VT [12]=FF [13]=CR
 [14]=SO [15]=SI [16]=DLE [17]=DC1 [18]=DC2 [19]=DC3 [20]=DC4
 [21]=NAK [22]=SYN [23]=ETB [24]=CAN [25]=EM [26]=SUB [27]=ESC
 [28]=FS [29]=GS [30]=RS [31]=US)
```
