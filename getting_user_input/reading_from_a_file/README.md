### 从文件中读取输入

我们也可以使用 read 命令读取文件。每次调用 read 命令都会从指定文件中读取一行文本。
当文件中没有内容可读时，read 命令会退出并返回非 0 退出状态码。

其中麻烦的地方是将文件数据传给 read 命令。最常见的方法是对文件使用 cat 命令，
将结果通过管道直接传给含有 read 命令的 while 命令。来看下面的例子：

```bash
#!/bin/bash
# Using the read command to read a file
#
count=1
current_file_dir=$( cd $(dirname ${BASH_SOURCE[0]}) && pwd )
cat ${current_file_dir}/test.txt | while read line
do
    echo "Line $count: $line"
    count=$[ $count + 1 ]
done
echo "Finished processing the file."
exit
```

执行脚本，输出结果如下所示：

```bash
$ ./30-reading-data-from-a-file
Line 1: The quick brown dog jumps over the lazy fox.
Line 2: This is a test. This is only a test.
Line 3: O Romeo, Romeo! Wherefore art thou Romeo?
Finished processing the file.
```

while 循环会持续通过 read 命令处理文件中的各行，直到 read 命令以非 0退出状态码退出。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 14.6.4 从文件中读取

