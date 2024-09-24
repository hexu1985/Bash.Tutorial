### 变量扩展修饰符

我们可以使用一些特殊修饰符测试和修改变量。修饰符提供一个快捷的条件测试，
用于检查是否已设置变量，然后基于测试结果给变量赋一个。如下表：

| 修饰符                      | 值                                                           |
| --------------------------- | ------------------------------------------------------------ |
| `${variable:–word}`         | 如果变量variable已被设置且非空，则代入它的值。否则，代入word |
| `${variable:=word}`         | 如果变量variable已被设置且非空，就代入它的值。否则，将variable的值设为word。始终代入variable的值。位置参数不能用这种方式赋值 |
| `${variable:+word}`         | 如果变量variable已被设置且非空，代入word。否则，什么都不代入（代入空值） |
| `${variable:?word}`         | 如果变量variable已被设置且非空，则代入它的值。否则，输出word并且从shell退出。如果省略了word，就会显示信息：parameter null or not set |
| `${variable:offset}`        | 获取变量variable值中位置从offset开始的子串，偏移为从0到串的末尾 |
| `${variable:offset:length}` | 获取变量variable值中位置从offset开始长度为length的子串       |

将冒号与任何修饰符 （ `–` 、 `=` 、 `+` 、 `？` ） 一起使用可检查变量是否尚未设置或值为空；
如果没有冒号，则设置为空的变量被视为已设置。


**示例1：临时替换默认值**

```
1 $ fruit=peach
2 $ echo ${fruit:-plum}
  peach
3 $ echo ${newfruit:-apple}
  apple
4 $ echo $newfruit
5 $ echo $EDITOR # More realistic example
6 $ echo ${EDITOR:-/bin/vi}
  /bin/vi
7 $ echo $EDITOR
8 $ name=
  $ echo ${name-Joe}
9 $ echo ${name:-Joe}
  Joe
```

1. 变量 fruit 被分配了值 peach。
2. 特殊修饰符将检查是否已设置变量 fruit。如果有，该值被打印出来；否则，将 plum 替换为 fruit 并打印其值。
3. 尚未设置变量 newfruit。值 apple 将暂时替换 newfruit。
4. 第3行的设置只是暂时的。因此，变量 newfruit 仍未被设置。
5. 尚未设置环境变量 EDITOR。
6. 修饰符 `:-` ，值 /bin/vi 将暂时替换 EDITOR 。
7. 编辑器从未设置过。什么都没有打印。
8. 变量 name 设置为空。如果不在修饰符前加上冒号，则认为变量已设置，即使为空，
   并且不会把新值 Joe 分配（临时）给变量 name。
9. 冒号使修饰符检查变量是否未设置或为空。在任一情况下，值 Joe 都将暂时替换 name。


**示例2：永久替换默认值**

```
1 $ name=
2 $ echo ${name:=Peter}
  Peter
3 $ echo $name
  Peter
4 $ echo ${EDITOR:=/bin/vi}
  /bin/vi
5 $ echo $EDITOR
  /bin/vi
```

1. 为变量 name 分配空值。
2. 特殊修饰符 `:=` 将检查是否已设置变量 name。如果它已设置且不为空，则不会更改；
   如果值为空或未设置，则将为其分配值（等号右边的值）。Peter 被赋值为 name，因为变量是设置但为空值。该设置是永久性的。
3. 变量 name 的值仍是 Peter。
4. 变量 EDITOR 的值设置为 /bin/vi。
5. 显示变量 EDITOR 的值。


**示例3：临时替换值**

```
1 $ foo=grapes
2 $ echo ${foo:+pears}
  pears
3 $ echo $foo
  grapes
  $
```

1. 变量 foo 被分配了值 grapes。
2. 特殊修饰符 `:+` 将检查变量是否已设置。如果已经设置且非空，pears 将暂时替换 foo；否则，返回空值。
3. 变量 foo 的值还是原来的值。


**示例4：基于默认值创建错误信息**

```
1 $ echo ${namex:?"namex is undefined"}
  namex: namex is undefined
2 $ echo ${y?}
  y: parameter null or not set
```

1. 特殊修饰符 `:?` 将检查是否已设置变量。如果尚未设置该变量，就把问号右边的信息打印在标准错误输出上。
   如果位于一个脚本中，则脚本退出。
2. 如果在 `?` 后未提供报错信息，则 shell 就会向标准错误输出发送默认的消息。


**示例5：创建子串**

```
1 $ var=notebook
2 $ echo ${var:0:4}
  note
3 $ echo ${var:4:4}
  book
4 $ echo ${var:0:2}
  no
```

1. 为变量分配值 notebook。
2. var 的子字符串从偏移量 0 （即 notebook 中的 n）开始，长度为 4 个字符，以 e 结束。
3. var 的子字符串从偏移量 4 （即 notebook 中的 b）开始，长度为 4 个字符，以 k 结束。
4. var 的子字符串从偏移量 0 （即 notebook 中的 n）开始，长度为 2 个字符，以 o 结束。


### 参考资料:
- 《UNIX Shell范例精解（第4版）》: 13.10.8 变量扩展修饰符
