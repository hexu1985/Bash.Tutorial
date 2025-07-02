### 使用 sed 替换文本

sed是stream editor（流编辑器）的缩写。它最常见的用法是进行文本替换。

#### 实战演练

sed可以使用另一个字符串来替换匹配模式。模式可以是简单的字符串或正则表达式：

```bash
$ sed 's/pattern/replace_string/' file
```

sed也可以从stdin中读取输入：

```bash
$ cat file | sed 's/pattern/replace_string/'
```

##### 1. 选项`-i`会使得sed用修改后的数据替换原始文件：

```bash
$ sed -i 's/text/replace/' file
```

##### 2. 之前的例子只替换了每行中模式首次匹配的内容。g标记可以使sed执行全局替换：

```bash
$ sed 's/pattern/replace_string/g' file
```

`/#g`标记可以使sed替换第N次出现的匹配：

```bash
$ echo thisthisthisthis | sed 's/this/THIS/2g'
thisTHISTHISTHIS
$ echo thisthisthisthis | sed 's/this/THIS/3g'
thisthisTHISTHIS
$ echo thisthisthisthis | sed 's/this/THIS/4g'
thisthisthisTHIS
```

sed命令会将s之后的字符视为命令分隔符。这允许我们更改默认的分隔符`/`：

```bash
sed 's:text:replace:g'
sed 's|text|replace|g'
```

如果作为分隔符的字符出现在模式中，必须使用\对其进行转义：

```bash
sed 's|te\|xt|replace|g'
```

`\|`是出现在模式中被转义的分隔符。

#### 补充内容

sed命令可以使用正则表达式作为模式，另外还包含了大量可用于文本处理的选项。

##### 1. 移除空行

有了正则表达式的支持，移除空行不过是小菜一碟。空行可以用正则表达式 `^$` 进行匹配。

最后的/d告诉sed不执行替换操作，而是直接删除匹配到的空行：

```bash
$ sed '/^$/d' file
```

##### 2. 直接在文件中替换

如果将文件名传递给sed，它会将文件内容输出到stdout。要是我们想就地（in place）修改文件内容，可以使用选项`-i`：

```bash
$ sed 's/PATTERN/replacement/' -i filename
```

例如，使用指定的数字替换文件中所有3位数的数字：

```bash
$ cat sed_data.txt
11 abc 111 this 9 file contains 111 11 88 numbers 0000
$ sed -i 's/\b[0-9]\{3\}\b/NUMBER/g' sed_data.txt
$ cat sed_data.txt
11 abc NUMBER this 9 file contains NUMBER 11 88 numbers 0000
```

上面的单行命令只替换了所有的3位数字。正则表达式`\b[0-9]\{3\}\b`用于匹配3位数字。
`[0-9]`表示数字取值范围是从0到9。`{3}`表示匹配之前的数字3次。`\{3\}`中的`\`用于转义`{`和`}`。
`\b`表示单词边界。


##### 3. 已匹配字符串标记（`&`）

在sed中，我们可以用`&`指代模式所匹配到的字符串，这样就能够在替换字符串时使用已匹配的内容：

```bash
$ echo this is an example | sed 's/\w\+/[&]/g'
[this] [is] [an] [example]
```

在这个例子中，正则表达式`\w\+`匹配每一个单词，然后我们用`[&]`替换它。`&`对应于之前所匹配到的单词。


##### 4. 子串匹配标记（`\1`）

`&`指代匹配给定模式的字符串。我们还可以使用`\#`来指代出现在括号中的部分正则表达式（子模式）所匹配到的内容：

```bash
$ echo this is digit 7 in a number | sed 's/digit \([0-9]\)/\1/'
this is 7 in a number
```

这条命令将`digit 7`替换为`7`。`\(pattern\)`用于匹配子串，在本例中匹配到的子串是`7`。
子模式被放入使用反斜线转义过的`()`中。对于匹配到的第一个子串，其对应的标记是`\1`，匹配到的第二个子串是`\2`，往后以此类推。

```bash
$ echo seven EIGHT | sed 's/\([a-z]\+\) \([A-Z]\+\)/\2 \1/'
EIGHT seven
```

`([a-z]\+\)`匹配第一个单词，`\([A-Z]\+\)`匹配第二个单词。`\1`和`\2`分别用来引用这两个单词。
这种引用形式叫作向后引用（back reference）。在替换部分，它们的次序被更改为`\2 \1`，因此就呈现出了逆序的结果。


##### 5. 组合多个表达式

可以利用管道组合多个sed命令，多个模式之间可以用分号分隔，或是使用选项`-e PATTERN`：

```bash
$ sed 'expression' | sed 'expression'
```

它等同于

```bash
$ sed 'expression; expression'
```

或者

```bash
$ sed -e 'expression' -e 'expression'
```

考虑下列示例：

```bash
$ echo abc | sed 's/a/A/' | sed 's/c/C/'
AbC
$ echo abc | sed 's/a/A/;s/c/C/'
AbC
$ echo abc | sed -e 's/a/A/' -e 's/c/C/'
AbC
```

##### 6. 引用

sed表达式通常用单引号来引用。不过也可以使用双引号。shell会在调用sed前先扩展双引号中的内容。
如果想在sed表达式中使用变量，双引号就能派上用场了。

例如：

```bash
$ text=hello
$ echo hello world | sed "s/$text/HELLO/"
HELLO world

```
`$text`的求值结果是`hello`。


### 参考资料:
- 《Linux Shell脚本攻略（第3版）》: 4.5 使用 sed 替换文本

