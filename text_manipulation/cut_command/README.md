### 使用 cut 按列切分文件

cut命令可以按列，而不是按行来切分文件。
该命令可用于处理使用固定宽度字段的文件、CSV文件或是由空格分隔的文件（例如标准日志文件）。

#### 实战演练

cut命令能够提取指定位置或列之间的字符。你可以指定每列的分隔符。在cut的术语中，每列被称为一个字段。


(1) 选项`-f`可以指定要提取的字段：

```bash
cut -f FIELD_LIST filename
```

FIELD_LIST是需要显示的列。它由列号组成，彼此之间用逗号分隔。例如：

```bash
$ cut -f 2,3 filename
```

该命令将显示第2列和第3列。

(2) cut命令也能够从stdin中读取输入。

制表符是字段默认的分隔符。对于没有使用分隔符的行，会将该行照原样打印出来。
cut 的选项`-s`可以禁止打印出这种行。
下面的例子演示了如何从使用制表符作为分隔符的文件中提取列：

```
$ cat student_data.txt
No Name Mark Percent
1 Sarath 45 90
2 Alex 49 98
3 Anu 45 90
$ cut -f1 student_data.txt
No
1
2
3
```

(3) 要想提取多个字段，就得给出由逗号分隔的多个字段编号：

```bash
$ cut -f2,4 student_data.txt
Name    Percent
Sarath  90
Alex    98
Anu     90
```

(4) 我们也可以用 `--complement`选项显示出没有被`-f`指定的那些字段。
下面的命令会打印出除第3列之外的所有列：

```bash
$ cut -f3 --complement student_data.txt
No      Name    Percent
1       Sarath  90
2       Alex    98
3       Anu     90
```

(5) 选项`-d`能够设置分隔符。下面的命令展示了如何使用cut处理由分号分隔的字段：

```bash
$ cat delimited_data.txt
No;Name;Mark;Percent
1;Sarath;45;90
2;Alex;49;98
3;Anu;45;90
$ cut -f2 -d";" delimited_data.txt
Name
Sarath
Alex
Anu
```

#### 补充内容

cut命令还有其他一些选项可以指定要显示的列。

**指定字段的字符或字节范围**

固定列宽的报表在列与列之间都存在数量不等的空格。
你没法根据字段的位置来提取值，但是可以根据字符位置提取。
cut命令可以根据字节或者字符来指定选择范围。

输入每一个字符的提取位置就说不过去了，因此除了逗号分隔的列表，cut可以接受下表中列出的记法。

| 记法 | 说明 |
| ---- | ---- |
| N-   | 从第N个字节、字符或字段开始到行尾 |
| N-M  | 从第N个字节、字符或字段开始到第M个（包括第M个在内）字节、字符或字段 |
| -M   | 从第1个字节、字符或字段开始到第M个（包括第M个在内）字节、字符或字段 |


我们使用上面介绍的记法，结合下列选项将字段指定为某个范围内的字节、字符或字段：
- `-b` 表示字节
- `-c` 表示字符
- `-f` 用于定义字段

例如：

```bash
$ cat range_fields.txt
abcdefghijklmnopqrstuvwxyz
abcdefghijklmnopqrstuvwxyz
abcdefghijklmnopqrstuvwxyz
abcdefghijklmnopqrstuvwxy
```

你可以打印第2个到第5个字符：

```bash
$ cut -c2-5 range_fields.txt
bcde
bcde
bcde
bcde
```

打印前2个字符：

```bash
$ cut -c -2 range_fields.txt
ab
ab
ab
ab
```

若要用字节作为计数单位，可以将`-c`替换成`-b`。

选项`--output-delimiter`可以指定输出分隔符。
在显示多组数据时，该选项尤为有用：

```bash
$ cut range_fields.txt -c1-3,6-9 --output-delimiter ","
abc,fghi
abc,fghi
abc,fghi
abc,fghi
```

### 参考资料:
- 《Linux Shell脚本攻略（第3版）》: 4.4 使用 cut 按列切分文件

