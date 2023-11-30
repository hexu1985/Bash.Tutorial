### null命令

null命令用冒号:表示，是一个内建的什么都不做的命令，返回状态值为0。
如果在if命令后面没有内容，同时又要避免产生错误信息，就需要在then后面写null语句。

例如：

```bash
$ cat test.sh
#!/usr/bin/bash
name=tom
if grep "$name" /etc/passwd >& /dev/null
then
   :
else
   echo "$name not found in database"
   exit 1
fi
$ ./test.sh
 not found in databasefile
```

### 参考资料:
- 《UNIX Shells by Example》: 14.5.7 The null command
