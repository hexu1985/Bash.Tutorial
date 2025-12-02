### 使用 tar 归档

tar命令可以归档文件。它最初是设计用来将数据存储在磁带上，因此其名字也来源于Tape ARchive。
tar可以将多个文件和文件夹打包为单个文件，同时还能保留所有的文件属性，如所有者、权限等。
由tar创建的文件通常称为tarball。


#### 实战演练

(1) 用tar创建归档文件：

```bash
$ tar -cf output.tar [SOURCES]
```

选项`-c`表示创建新的归档文件。选项`-f`表示归档文件名，该选项后面必须跟一个文件名称：

```bash
$ tar -cf archive.tar file1 file2 file3 folder1 ..
```

(2) 选项`-t`可以列出归档文件中所包含的文件：

```bash
$ tar -tf archive.tar
file1
file2
```

(3) 选项`-v`或`-vv`参数可以在命令输出中加入更多的细节信息。
这个特性叫作“冗长模式（v，verbose）”或“非常冗长模式（vv，very verbose）”。
对于能够在终端中生成报告的命令，`-v`是一个约定的选项。
该选项能够显示出更多的细节，例如文件权限、所有者所属的分组、文件修改日期等信息：

```bash
$ tar -tvf archive.tar
-rw-rw-r-- shaan/shaan 0 2013-04-08 21:34 file1
-rw-rw-r-- shaan/shaan 0 2013-04-08 21:34 file2
```

文件名必须紧跟在`-f`之后出现，而且`-f`应该是选项中的最后一个。
假如你希望使用冗长模式，应该像这样写：

```bash
$ tar -cvf output.tar file1 file2 file3 folder1 ..
```

#### 补充内容

**向归档文件中追加文件**

选项`-r`可以将新文件追加到已有的归档文件末尾：

```bash
$ tar -rvf original.tar new_file
```

创建一个包含文本文件的归档：

```bash
$ echo hello >hello.txt
$ tar -cf archive.tar hello.txt
```

选项`-t`可以列出归档文件中的内容。选项`-f`可以指定归档文件名：

```bash
$ tar -tf archive.tar
hello.txt
```

接着使用选项`-r`向该归档文件中再追加一个文件：

```bash
$ tar -rf archive.tar world.txt
$ tar -tf archive.tar
hello.txt
world.txt
```

这个归档文件中现在包含了两个文件。


**从归档文件中提取文件或目录**

选项`-x`可以将归档文件的内容提取到当前目录：

```bash
$ tar -xf archive.tar
```

使用`-x`时，tar命令将归档文件中的内容提取到当前目录。我们也可以用选项`-C`来指定将文件提取到哪个目录：

```bash
$ tar -xf archive.tar -C /path/to/extraction_directory
```

该命令将归档文件的内容提取到指定目录中。它提取的是归档文件中的全部内容。
我们可以通过将文件名作为命令行参数来提取特定的文件：

```bash
$ tar -xvf file.tar file1 file4
```

上面的命令只提取file1和file4，忽略其他文件。


**拼接两个归档文件**

我们可以用选项`-A`合并多个tar文件。

假设我们现在有两个tar文件：file1.tar和file2.tar。
下面的命令可以将file2.tar的内容合并到file1.tar中：

```bash
$ tar -Af file1.tar file2.tar
```

查看内容，验证操作是否成功：

```bash
$ tar -tvf file1.tar
```

**从归档中删除文件**

我们可以用`--delete`选项从归档中删除文件：

```bash
$ tar -f archive.tar --delete file1 file2 ..
```

或者

```bash
$ tar --delete --file archive.tar [FILE LIST]
```

来看另外一个例子：

```bash
$ tar -tf archive.tar
filea
fileb
filec
$ tar --delete --file archive.tar filea
$ tar -tf archive.tar
fileb
filec
```

**压缩tar归档文件**

tar命令默认只归档文件，并不对其进行压缩。不过tar支持用于压缩的相关选项。
压缩能够显著减少文件的体积。归档文件通常被压缩成下列格式之一。

- gzip格式：file.tar.gz或file.tgz。
- bzip2格式：file.tar.bz2。
- Lempel-Ziv-Markov格式：file.tar.lzma。

不同的tar选项可以用来指定不同的压缩格式：
- `-j`指定bunzip2格式；
- `-z`指定gzip格式；
- `--lzma`指定lzma格式。

不明确指定上面那些特定的选项也可以使用压缩功能。tar能够基于输出或输入文件的扩展名来进行压缩。
为了让tar支持根据扩展名自动选择压缩算法，使用`-a`或`--auto-compress`选项：

```bash
$ tar -acvf archive.tar.gz filea fileb filec
filea
fileb
filec
$ tar -tf archive.tar.gz
filea
fileb
filec
```


**在归档过程中排除部分文件**

选项`--exclude [PATTERN]`可以将匹配通配符模式的文件排除在归档过程之外。
例如，排除所有的.txt文件：

```bash
$ tar -cf arch.tar * --exclude "*.txt"
```

也可以将需要排除的文件列表放入文件中，同时配合选项`-X`：

```bash
$ cat list
filea
fileb
$ tar -cf arch.tar * -X list
```

这样就把filea和fileb排除了。


### 参考资料:
- 《Linux Shell脚本攻略（第3版）》: 7.2 使用 tar 归档

