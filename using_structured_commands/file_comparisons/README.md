### 文件比较

最后一类比较测试很有可能是 shell 编程中最为强大且用得最多的比较形式。
它允许测试Linux 文件系统中文件和目录的状态。下表列出了这类比较。

| 表达式          | 成为true的条件                                                                        |
| --------------- | ------------------------------------------------------------------------------------- |
| file1 -ef file2 | file1和file2拥有相同的信息节点编号（这两个文件通过硬链接指向同一个文件）              |
| file1 -nt file2 | file1比file2新                                                                        |
| file1 -ot file2 | file1比file2旧                                                                        |
| -b file         | file存在并且是一个块（设备）文件                                                      |
| -c file         | file存在并且是一个字符（设备）文件                                                    |
| -d file         | file存在并且是一个目录                                                                |
| -e file         | file存在                                                                              |
| -f file         | file存在并且是一个普通文件                                                            |
| -g file         | file存在并且设置了组ID                                                                |
| -G file         | file存在并且属于有效组ID                                                              |
| -k file         | file存在并且有“粘滞位（sticky bit）”属性                                              |
| -L file         | file存在并且是一个符号链接                                                            |
| -O file         | file存在并且属于有效用户ID                                                            |
| -p file         | file存在并且是一个命名管道                                                            |
| -r file         | file存在并且可读（有效用户有可读权限）                                                |
| -s file         | file存在并且其长度大于0                                                               |
| -S file         | file存在并且是一个网络套接字                                                          |
| -t fd           | fd是一个定向到终端/从终端定向的文件描述符，可以用来确定标准输入/输出/错误是否被重定向 |
| -u file         | file存在并且设置了setuid位                                                            |
| -w file         | file存在并且可写（有效用户拥有可写权限）                                              |
| -x file         | fiile存在并且可执行（有效用户拥有执行/搜索权限）                                      |

这些测试条件使你能够在 shell 脚本中检查文件系统中的文件。它们经常出现在需要进行文件访问的脚本中。

**检查目录**

`-d` 测试会检查指定的目录是否存在于系统中。如果打算将文件写入目录或是准备切换到某个目录，
那么先测试一下总是件好事：

```bash
#!/bin/bash
# Look before you leap
#
jump_directory=/home/Torfa
#
if [ -d $jump_directory ]
then
    echo "The $jump_directory directory exists."
    cd $jump_directory
    ls
else
    echo "The $jump_directory directory does NOT exist."
fi 
```

运行这个脚本时，会产生如下输出：

```
$ ./17-look-before-you-leap
The /home/Torfa directory does NOT exist.
```

示例代码使用了 `-d` 测试来检查 jump_directory 变量中的目录是否存在。
如果存在，就使用 cd 命令切换到该目录并列出其中的内容；
如果不存在，则输出一条警告信息，然后退出。


**检查对象是否存在**

`-e` 测试允许在使用文件或目录前先检查其是否存在：

```bash
#!/bin/bash
# Check if either a directory or file exists
#
location=$HOME
file_name="sentinel"
#
if [ -d $location ]
then
    echo "OK on the $location directory"
    echo "Now checking on the file, $file_name..."
    if [ -e $location/$file_name ]
    then
        echo "OK on the file, $file_name."
        echo "Updating file's contents."
        date >> $location/$file_name
        #
    else
        echo "File, $location/$file_name, does NOT exist."
        echo "Nothing to update."
    fi
    #
else
    echo "Directory, $location, does NOT exist."
    echo "Nothing to update."
fi
```

运行这个脚本时，会产生如下输出：

```
$ ./18-check-either-file-or-direcotry-exists
OK on the /home/hexu directory
Now checking on the file, sentinel...
File, /home/hexu/sentinel, does NOT exist.
Nothing to update.
$
$ touch $HOME/sentinel
$
$ ./18-check-either-file-or-direcotry-exists
OK on the /home/hexu directory
Now checking on the file, sentinel...
OK on the file, sentinel.
Updating file's contents.
$
```

首先使用 `-e` 测试检查用户的$HOME 目录是否存在。
如果存在，那么接下来的 `-e` 测试会检查 sentinel 文件是否存在于 `$HOME` 目录中。
如果文件不存在，则 shell 脚本会提示该文件缺失，不需要进行更新。

为了确保更新正常进行，我们创建了 sentinel 文件，然后重新运行这个 shell 脚本。
这一次在进行条件测试时，`$HOME` 和 sentinel 文件都存在，因此当前日期和时间就被追加到了文件中。


**检查文件**

`-e` 测试可用于文件和目录。如果要确定指定对象为文件，那就必须使用 `-f` 测试：

```bash
#!/bin/bash
# Check if object exists and is a directory or a file
#
object_name=$HOME
echo
echo "The object being checked: $object_name"
echo
#
if [ -e $object_name ]
then
    echo "The object, $object_name, does exist,"
    #
    if [ -f $object_name ]
    then
        echo "and $object_name is a file."
        #
    else
        echo "and $object_name is a directory."
    fi
    #
else
    echo "The object, $object_name, does NOT exist."
fi 
```

运行这个脚本时，会产生如下输出：

```
$ ./19-check-either-file-or-direcotry-exists-check-file
The object being checked: /home/hexu

The object, /home/hexu, does exist,
and /home/hexu is a directory.
```

首先，脚本会使用 `-e` 测试检查 `$HOME` 是否存在。如果存在，就接着用 `-f` 测试检查其是否为文件。
如果不是文件（当然不会是文件），则显示消息，说明这是目录。

下面对变量 object_name 略作修改，将目录 `$HOME` 替换成文件 `$HOME/sentinel`，结果可就不一样了：

```bash
#!/bin/bash
# Check if object exists and is a directory or a file
#
object_name=$HOME/sentinel
echo
echo "The object being checked: $object_name"
echo
#
if [ -e $object_name ]
then
    echo "The object, $object_name, does exist,"
    #
    if [ -f $object_name ]
    then
        echo "and $object_name is a file."
        #
    else
        echo "and $object_name is a directory."
    fi
    #
else
    echo "The object, $object_name, does NOT exist."
fi 
```

运行这个脚本时，会产生如下输出：

```
$ ./19-check-either-file-or-direcotry-exists-check-file
The object being checked: /home/hexu/sentinel

The object, /home/hexu/sentinel, does exist,
and /home/hexu/sentinel is a file.
```

当运行该脚本时，对 `$HOME/sentinel` 进行的 `-f` 测试所返回的退出状态码为 0，
then 语句得以执行，然后输出消息 `and /home/hexu/sentinel is a file`。


**检查是否可读**

在尝试从文件中读取数据之前，最好先使用 `-r` 测试检查一下文件是否可读：

```bash
#!/bin/bash
# Check if you can read a file
#
pwfile=/etc/shadow
echo
echo "Checking if you can read $pwfile..."
#
# Check if file exists and is a file.
#
if [ -f $pwfile ]
then
    # File does exist. Check if can read it.
    #
    if [ -r $pwfile ]
    then
        echo "Displaying end of file..."
        tail $pwfile
        #
    else
        echo "Sorry, read access to $pwfile is denied."
    fi
    #
else
    echo "Sorry, the $pwfile file does not exist."
fi
```

运行这个脚本时，会产生如下输出：

```
$ ./20-testing-read

Checking if you can read /etc/shadow...
Sorry, read access to /etc/shadow is denied.
```

`/etc/shadow` 文件包含系统用户经过加密后的密码，所以普通用户是无法读取该文件的。
`-r` 测试判断出了该文件不允许读取，因此测试失败，bash shell 执行了 if-then 语句的 else 部分。


**检查空文件**

应该用 `-s` 测试检查文件是否为空，尤其是当你不想删除非空文件时。
要当心，如果 `-s` 测试成功，则说明文件中有数据：

```bash
#!/bin/bash
# Check if a file is empty
#
file_name=$HOME/sentinel
echo
echo "Checking if $file_name file is empty..."
echo
#
# Check if file exists and is a file.
#
if [ -f $file_name ]
then
    # File does exist. Check if it is empty.
    #
    if [ -s $file_name ]
    then
        echo "The $file_name file exists and has data in it."
        echo "Will not remove this file."
        #
    else
        echo "The $file_name file exits, but is empty."
        echo "Deleting empty file..."
        rm $file_name
    fi
    #
else
    echo "The $file_name file does not exist."
fi
```

运行这个脚本时，会产生如下输出：

```
$ ls -sh $HOME/sentinel
4.0K /home/hexu/sentinel
$ ./21-testing-a-file-is-empty

Checking if /home/hexu/sentinel file is empty...

The /home/hexu/sentinel file exists and has data in it.
Will not remove this file.
$
```

`-f` 测试可以检查文件是否存在。如果存在，就使用 `-s` 测试来判断该文件是否为空。
空文件会被删除。你可以从 `ls -sh` 的输出中看出 sentinel 并不是空文件（4.0 K），因此脚本并不会删除它。


**检查是否可写**

`-w` 测试可以检查是否对文件拥有可写权限。

```bash
#!/bin/bash
# Check if a file is writable
#
item_name=$HOME/sentinel
echo
echo "Checking if you can write to $item_name..."
#
# Check if file exists and is a file.
#
if [ -f $item_name ]
then 
    # File does exist. Check if can write to it.
    #
    if [ -w $item_name ]
    then
        echo "Writing current time to $item_name"
        date +%H%M >> $item_name
        #
    else
        echo "Sorry, write access to $item_name is denied."
    fi
    #
else
    echo "Sorry, the $item_name does not exist"
    echo "or is not a file."
fi
```

运行这个脚本时，会产生如下输出：

```
$ ./22-testing-a-file-is-writable

Checking if you can write to /home/hexu/sentinel...
Writing current time to /home/hexu/sentinel
```

变量 item_name 被设置成了 `$HOME/sentinel`，该文件允许用户写入。
因此，运行该脚本时，`-w` 测试会返回值为 0 的退出状态码，然后执行 then 代码块，将时间戳写入文件 sentinel 中。

如果使用 chmod 去掉文件 sentinel 的用户写入权限，那么 `-w` 测试会返回非 0 的退出状态码，时间戳则不会被写入文件：

```
$ chmod u-w $HOME/sentinel
$ ls -o $HOME/sentinel
-r--rw-r-- 1 hexu 48 9月  25 17:13 /home/hexu/sentinel
$ ./22-testing-a-file-is-writable

Checking if you can write to /home/hexu/sentinel...
Sorry, write access to /home/hexu/sentinel is denied.
```

chmod 命令还可以再次将写权限授予用户。这又能使得 `-w` 测试返回退出状态码 0，允许写入文件。


**检查文件是否可以执行**

`-x` 测试可以方便地判断文件是否有执行权限。虽然可能大多数命令用不到它，但如果想在shell 脚本中运行大量程序，那就得靠它了：

```bash
#!/bin/bash
# Check if you can run a file
#
current_file_dir=$( dirname ${BASH_SOURCE[0]} )
item_name=${current_file_dir}/22-testing-a-file-is-writable
echo
echo "Checking if you can run $item_name..."
#
# Check if file is executable.
#
if [ -x $item_name ]
then
    echo "You can run $item_name."
    echo "Running $item_name..."
    $item_name
    #
else
    echo "Sorry, you cannot run $item_name."
    #
fi
```

运行这个脚本时，会产生如下输出：

```
$ ./25-testing-if-a-file-is-executable

Checking if you can run ./22-testing-a-file-is-writable...
You can run ./22-testing-a-file-is-writable.
Running ./22-testing-a-file-is-writable...

Checking if you can write to /home/hexu/sentinel...
Writing current time to /home/hexu/sentinel
$
$ chmod -x ./22-testing-a-file-is-writable 
$ ./25-testing-if-a-file-is-executable

Checking if you can run ./22-testing-a-file-is-writable...
Sorry, you cannot run ./22-testing-a-file-is-writable.
$
```

这段 shell 脚本使用 `-x` 测试来检查是否有权限执行 22-testing-a-file-is-writable  脚本。
如果有权限，就运行该脚本。在首次成功运行 22-testing-a-file-is-writable 脚本后，更改文件权限。
这次，`-x` 测试失败了，因为你已经没有 22-testing-a-file-is-writable 脚本的执行权限了。


**检查所有权**

`-O` 测试可以轻松地检查你是否是文件的属主：

```bash
#!/bin/bash
# Check if you own a file
#
if [ -O /etc/passwd ]
then
    echo "You are the owner of the /etc/passwd file."
    #
else
    echo "Sorry, you are NOT /etc/passwd file's owner."
    #
fi 
```

运行这个脚本时，会产生如下输出：

```
$ whoami
hexu
$ ls -o /etc/passwd
-rw-r--r-- 1 root 2771 11月 14  2023 /etc/passwd
$ ./23-testing-ownership
Sorry, you are NOT /etc/passwd file's owner.
$
```

该脚本使用 `-O` 测试来检查运行脚本的用户是否是 `/etc/passwd` 文件的属主。
由于脚本是以普通用户身份运行的，因此测试失败了。


**检查默认属组关系**

`-G` 测试可以检查文件的属组，如果与用户的默认组匹配，则测试成功。
`-G` 只会检查默认组而非用户所属的所有组，这会让人有点儿困惑。来看一个例子：

```bash
#!/bin/bash
# Compare file and script user's default groups
#
if [ -G $HOME/TestGroupFile ]
then
    echo "You are in the same default group as"
    echo "the $HOME/TestGroupFile file's group."
    #
else
    echo "Sorry, your default group and $HOME/TestGroupFile"
    echo "file's group are different."
    #
fi
```

运行这个脚本时，会产生如下输出：

```
$ touch $HOME/TestGroupFile
$ ls -g $HOME/TestGroupFile
-rw-rw-r-- 1 hexu 0 9月  25 17:36 /home/hexu/TestGroupFile
$ ./24-check-file-group
You are in the same default group as
the /home/hexu/TestGroupFile file's group.
$
$ groups
hexu adm cdrom sudo dip plugdev lpadmin sambashare docker jtop
$ chgrp adm $HOME/TestGroupFile
$ ls -g $HOME/TestGroupFile
-rw-rw-r-- 1 adm 0 9月  25 17:36 /home/hexu/TestGroupFile
$ ./24-check-file-group
Sorry, your default group and /home/hexu/TestGroupFile
file's group are different.
$
```

第一次运行脚本时，`$HOME/TestGroupFile` 文件属于 christine 组，所以通过了 `-G` 比较。
接下来，组被改成了 adm 组，用户也是其中的一员。但 `-G` 比较失败了，因为它只会比较默认组，不会比较其他的组。


**检查文件日期**

最后一组测试用来比较两个文件的创建日期。这在编写软件安装脚本时非常有用。有时，你可不想安装一个比系统中已有文件还要旧的文件。
`-nt` 测试会判定一个文件是否比另一个文件更新。如果文件较新，那意味着其文件创建日期更晚。
`-ot` 测试会判定一个文件是否比另一个文件更旧。如果文件较旧，则意味着其文件创建日期更早：

```bash
#!/bin/bash
# Compare two file's creation dates/times
#
if [ $HOME/Downloads/games.rpm -nt $HOME/software/games.rpm ]
then
    echo "The $HOME/Downloads/games.rpm file is newer"
    echo "than the $HOME/software/games.rpm file."
    #
else
    echo "The $HOME/Downloads/games.rpm file is older"
    echo "than the $HOME/software/games.rpm file."
    #
fi
```

运行这个脚本时，会产生如下输出：

```
$ mkdir ~/Downloads
$ touch ~/Downloads/games.rpm
$ mkdir ~/software
$ touch ~/software/games.rpm
$ ls -l ~/Downloads/games.rpm ~/software/games.rpm
-rw-rw-r-- 1 hexu hexu 0 9月  25 17:44 /home/hexu/Downloads/games.rpm
-rw-rw-r-- 1 hexu hexu 0 9月  25 17:45 /home/hexu/software/games.rpm
$ ./26-testing-file-dates
The /home/hexu/Downloads/games.rpm file is older
than the /home/hexu/software/games.rpm file.
```

在脚本中，这两种测试都不会先检查文件是否存在。这是一个问题。试试下面的测试：

```
$ rm $HOME/Downloads/games.rpm
$ ./26-testing-file-dates
The /home/hexu/Downloads/games.rpm file is older
than the /home/hexu/software/games.rpm file.
```

这个小示例展示了如果有其中一个文件不存在，那么 `-nt` 测试返回的信息就不正确。
在 `-nt` 或 `-ot` 测试之前，务必确保文件存在。


### 参考资料:
- 《Linux命令行与shell脚本编程大全（第4版）》: 12.4.3 文件比较

