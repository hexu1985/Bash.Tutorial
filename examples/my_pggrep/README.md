### 根据名称查找进程组ID（PGID）的命令

命令格式：my_pggrep.sh cmd_pattern

返回结果： 进程的PGID

示例：
```
$ ./test.sh &
$ ps ajx | head -1
 PPID   PID  PGID   SID TTY      TPGID STAT   UID   TIME COMMAND 
$ ps ajx | grep test.sh
18134  4044  4044 18134 pts/4     4073 S     1000   0:00 /bin/bash ./test.sh
18134  4074  4073 18134 pts/4     4073 S+    1000   0:00 grep --color=auto test.sh
$ ./my_pggrep.sh test.sh
$ 4044
```

