### 使用 zip 归档及压缩

ZIP作为一种流行的压缩格式，在Linux、Mac和Windows平台中都可以看到它的身影。


#### 实战演练

(1) 创建zip格式的压缩归档文件（zip archive）：

```bash
$ zip archive_name.zip file1 file2 file3...
```

例如：

```bash
$ zip file.zip file
```

该命令会生成file.zip。

(2) 选项`-r`可以对目录进行递归式归档：

```bash
$ zip -r archive.zip folder1 folder2
```

(3) unzip命令可以从ZIP文件中提取内容：

```bash
$ unzip file.zip
```

在完成提取操作之后，unzip并不会删除file.zip（这一点与unlzma和gunzip不同）。

(4) 选项`-u`可以更新压缩归档文件中的内容：

```bash
$ zip file.zip -u newfile
```

(5) 选项`-d`从压缩归档文件中删除一个或多个文件：

```bash
$ zip -d arc.zip file.txt
```

(6) 选项`-l`可以列出压缩归档文件中的内容：

```bash
$ unzip -l archive.zi
```


### 参考资料:
- 《Linux Shell脚本攻略（第3版）》: 7.4 使用 zip 归档及压缩

