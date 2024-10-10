### 字符串查找

sed（“流编辑器”）提供了灵活的搜索和替换功能。例如，您可以通过将 Wintel 替换为 Linux 来一次性提升数据中心：

```
$ sed s/Wintel/Linux/g datacenter
```

sed 非常强大，但基本的搜索和替换功能也是 Bash 的一项功能。
创建进程需要额外的时间，由其是在运行 10、100 或 1,000 次的循环中。
因为 sed 是一个相对较大的程序，如果只是为了执行一些简单的文本替换，使用内置的 bash 功能要高效得多。

bash的内置查找替换语法与 sed 语法没有太大区别。
如果 `$datacenter` 是变量，且任务依然是用 Linux 替换 Wintel，
上一行代码中的 sed 将是相当于：

```
# echo $datacenter | sed 's/Wintel/Linux/'
$ echo ${datacenter/Wintel/Linux}
```

**查找与替换**

考虑 `/etc/passwd` 中一个名为 Fred 的用户的行。此语法可用于将模式 fred 更改为 wilma。

```
$ user=`grep fred /etc/passwd`
$ echo $user
fred:x:1000:1000:Fred Flintstone:/home/fred:/bin/bash
$ echo ${user/fred/wilma}
wilma:x:1000:1000:Fred Flintstone:/home/fred:/bin/bash
$
```

这只是改变了 fred 这个词的第一个实例。要将 fred 的所有实例更改为 wilma，将第一个 `/` 更改为双精度 `//` 。
这会将搜索模式的每个实例替换为新文本。

上面的代码将用户名字段和主目录字段从 fred 更改为 wilma。它仍然没有改变 GECOS 字段（人类可读的部分，仍然写着 Fred Flintstone）。
bash 的这一特性不能直接对它进行修改。

如果模式必须在变量值的开头匹配，则标准正则表达式语法将使用 `/^fred/wilma`。
但是，shell 不执行正则表达式，并且脱字符 （`^`） 用于变量修改以更改变量的大小写。
正确的语法是以使用 `#` 而不是 `^`。在这里，最终搜索尝试将 1000 替换为 1001，但它不匹配因为它不在行的开头：

```
$ echo ${user/^fred/wilma}
fred:x:1000:1000:Fred Flintstone:/home/fred:/bin/bash
$ echo ${user/#fred/wilma}
wilma:x:1000:1000:Fred Flintstone:/home/fred:/bin/bash
$ echo ${user/1000/1001}
fred:x:1001:1000:Fred Flintstone:/home/fred:/bin/bash
$ echo ${user/#1000/1001}
fred:x:1000:1000:Fred Flintstone:/home/fred:/bin/bash
$
```

同样，要匹配行尾，请在搜索字符串的开头使用 `%`，而不是在末尾使用 `$` 中。
下面的代码将 bash 修改为 ksh：

```
$ echo ${user/%bash/ksh}
fred:x:1000:1000:Fred Flintstone:/home/fred:/bin/ksh
$
```

这一特性还可以用于更实际的用途，如修改文件扩展名。文件名可能包含任何内容，包括正在搜索的模式，在名称本身中任意次数。
如果要将所有 `*.TXT` 文件重命名为 Unix 风格的 `*.txt`，请使用 `/%.TXT/.txt`：

```bash
#!/bin/bash
for myfile in *.TXT
do
    mynewfile=${myfile/%.TXT/.txt}
    echo "Renaming $myfile to ${mynewfile} ..."
    mv $myfile $mynewfile
done
```

由于文件列表可能包含 `FILE.TXT.TXT`，因此包含 `%` 符号可确保仅替换最后的 `.TXT`。
`FILE.TXT.TXT` 将重命名为 `FILE.TXT.txt`，而不是 `FILE.txt.txt`。
保留句点可确保 `fileTXT` 不会更改为 `filetxt`，但 `file.TXT` 确实会发生变化到 `file.txt`。


**模式替换**

通配符在搜索模式中也可以使用，但只能使用“贪婪匹配”样式。
将 `f*d` 替换为 wilma 将尽可能地匹配星号；在本例中，星号将匹配 `red:x:1000:1000:Fred Flintstone:/home/fre`。
相反，fred 可以与 `f??d`。

```
$ echo $user
fred:x:1000:1000:Fred Flintstone:/home/fred:/bin/bash
$ echo ${user/f*d/wilma}
wilma:/bin/bash
$ echo ${user/f??d/wilma}
wilma:x:1000:1000:Fred Flintstone:/home/fred:/bin/bash
$
```

**模式删除**

当您只需要删除模式时，只需不提供任何替换文本（以及最终的 `/` 也是可选的）。
相同的模式匹配规则依然适用，单个斜线 `/` 仅匹配第一个模式实例， `/#` 仅匹配行首， `/%` 仅匹配行尾， `//` 匹配所有实例：

```
$ echo ${user/fred}
:x:1000:1000:Fred Flintstone:/home/fred:/bin/bash
$ echo ${user/#fred}
:x:1000:1000:Fred Flintstone:/home/fred:/bin/bash
$ echo ${user//fred}
:x:1000:1000:Fred Flintstone:/home/:/bin/bash
$ echo ${user/%bash}
fred:x:1000:1000:Fred Flintstone:/home/fred:/bin/
$
```

**大小写转换**

bash shell 还提供了在大写和小写之间切换的功能。要转换为大写，请使用 `${variable^^}`；要更改为小写，请使用 `${variable,,}`。

```
$ echo ${user^^}
FRED:X:1000:1000:FRED FLINTSTONE:/HOME/FRED:/BIN/BASH
$ echo ${user,,}
fred:x:1000:1000:fred flintstone:/home/fred:/bin/bash
$
```


### 参考资料:
- 《Shell脚本编程诀窍 适用于Linux、Bash等》: 7.2 字符串查找

