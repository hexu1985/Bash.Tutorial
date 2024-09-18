### 变量扩展修饰符

| 修饰符                      | 值                                                           |
| --------------------------- | ------------------------------------------------------------ |
| `${variable:–word}`         | 如果变量variable已被设置且非空，则代入它的值。否则，代入word |
| `${variable:=word}`         | 如果变量variable已被设置且非空，就代入它的值。否则，将variable的值设为word。始终代入variable的值。位置参数不能用这种方式赋值 |
| `${variable:+word}`         | 如果变量variable已被设置且非空，代入word。否则，什么都不代入（代入空值） |
| `${variable:?word}`         | 如果变量variable已被设置且非空，则代入它的值。否则，输出word并且从shell退出。如果省略了word，就会显示信息：parameter null or not set |
| `${variable:offset}`        | 获取变量variable值中位置从offset开始的子串，偏移为从0到串的末尾 |
| `${variable:offset:length}` | 获取变量variable值中位置从offset开始长度为length的子串       |

示例1：临时替换默认值

```
$ fruit=peach
$ echo ${fruit:-plum}
peach
$ echo ${newfruit:-apple}
apple
$ echo $newfruit

$ echo $EDITOR # More realistic example

$ echo ${EDITOR:-/bin/vi}
/bin/vi
$ echo $EDITOR

$ name=
$ echo ${name-Joe}

$ echo ${name:-Joe}
Joe
$
```

示例2：永久替换默认值

```
$ name=
$ echo ${name:=Peter}
Peter
$  echo $name
Peter
$ echo ${EDITOR:=/bin/vi}
/bin/vi
$ echo $EDITOR
/bin/vi
$
```

示例3：临时替换值

```
$ foo=grapes
$ echo ${foo:+pears}
pears
$ echo $foo
grapes
$
```

示例4：基于默认值创建错误信息

```
$ echo ${namex:?"namex is undefined"}
bash: namex: namex is undefined
$ echo ${y?}
bash: y: parameter null or not set
$ echo ${y:?}
bash: y: parameter null or not set
```

示例5：创建子串

```
$ var=notebook
$ echo ${var:0:4}
note
$ echo ${var:4:4}
book
$ echo ${var:0:2}
no
$
```

### 参考资料:
- 《UNIX Shell范例精解（第4版）》: 13.10.8 变量扩展修饰符
