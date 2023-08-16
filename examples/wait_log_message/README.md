### 等待日志文件消息

命令格式：wait_log_message.sh -f logfile_path -p message_pattern [-t timeout_sec]
- f: 日志文件路径
- p：等待消息内容（支持正则表达式）
- t：等待超时时间（单位秒）

返回结果：
- 0：检测到匹配的日志文件消息
- 非0：等待超时

示例1：
```
$ echo "" > test.txt
$ ./wait_log_message.sh -f test.txt -p ready
process_count: 0
process_count: 0
process_count: 0
not found ready
```

示例2：
```
# tty1
$ echo "" > test.txt
$ sleep 10 && echo "ready" > test.txt &
$ $ ./wait_log_message.sh -f test.txt -p ready -t 40
count: 0
count: 0
count: 0
count: 0
count: 0
count: 0
count: 0
count: 0
count: 0
count: 1
found ready, count 1
```
