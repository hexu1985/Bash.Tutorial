### 数组的赋值

有很多不同的方法可以为数组赋值。尽管有些比较类似，但是有三种主要方法可以分配值，
分别为 “一次一个”，“一次全部” 或介于两者之间的“按索引”。
还可以从各种来源（包括通配符扩展和程序输出）为数组赋值。

如果数组是通过 “一次一个” 或 “一次全部” 方法声明的，则 shell 会自动检测是否有数组正在被声明。
另外，语句 `declare -a myarray` 可以用来向 shell 声明此变量将被视为数组。

设置数组值的最简单、最直接的方法是每次对一个元素进行赋值。就像常规变量一样，在赋值值时不使用美元（`$`）符号，
只再引用时才使用。在变量名称后面的索引号要使用方括号括起来：

```bash
numberarray[0]=zero
numberarray[1]=one
numberarray[2]=two
numberarray[3]=three
```

除了简单明了之外，这种方式的另一个优点是可以定义稀疏数组。在下面的示例中，数组中没有第3项 （“two”） ：

```bash
numberarray[0]=zero
numberarray[1]=one
numberarray[3]=three
```

与常规变量一样，在值中可以包含空格，但需要用引号括起来，或反斜杠将空格转义：

```bash
country[0]=”United States of America”
country[1]=United\ Kingdom
country[2]=Canada
country[3]=Australia
```

分配数组的更有效方法是在单个命令中列出所有值。可以通过以下方式执行此操作，
只需在以空格分隔的列表中列出值，并用括号括起来：

```bash
students=( Dave Jennifer Michael Alistair Lucy Richard Elizabeth )
```

这样做的一个缺点是不能以这种方式创建稀疏数组。另一个缺点是必须预先知道要赋的值，
并能够将它们硬编码到脚本中或由脚本自行计算它们。

IFS 中的任何字符都可用于分隔元素，包括换行符。将数组定义拆分为多行是完全合法的。
您甚至可以用注释结束这一行。
在下面的代码中，students 被分成单独的几行，每行以一个注释结束，每行的按列表子集表示每组学生代表的那个年份。

```bash
#!/bin/bash

students=( Dave Jennifer Michael    # year 1
  Alistair Lucy Richard Elizabeth   # year 2
  Albert Roger Dennis James Roy     # year 3
  Rory Jim Andi Elaine Clive        # year 4
  )

for name in ${students[@]}
do
  echo -en "$name "
done
echo
```

运行这个脚本时，会产生如下输出：


```
$ ./studentarray.sh 
Dave Jennifer Michael Alistair Lucy Richard Elizabeth Albert Roger Dennis James Roy Rory Jim Andi Elaine Clive 
```

也可以通过指定各个值的索引，将值赋给特定元素，
这种方法是“一次一个”方法的简写版本，或者把它看成是“一次全部” 方法的更明确版本。
这种方法要在一组括号中，说明索引和值。这主要在创建稀疏数组时有用，但也可以作为一种明确元素索引位置的方法，
而无需使用冗长的 “一次一个” 方法，该方法需要每次都提供变量的名称。

此方法在使用关联数组时也特别有用。
以下代码段分配了前 32 个 ASCII 字符的名称添加到数组中。
这对于确认名称是否位于正确的位置非常有用。
例如你可以很容易地看到 CR 位于索引 13 处，而不必从开头数它的索引位置。

```bash
nonprinting=([0]=NUL [1]=SOH [2]=STX [3]=ETX [4]=EOT [5]=ENQ
 [6]=ACK [7]=BEL [8]=BS [9]=HT [10]=LF [11]=VT [12]=FF [13]=CR
 [14]=SO [15]=SI [16]=DLE [17]=DC1 [18]=DC2 [19]=DC3 [20]=DC4
 [21]=NAK [22]=SYN [23]=ETB [24]=CAN [25]=EM [26]=SUB [27]=ESC
 [28]=FS [29]=GS [30]=RS [31]=US)
```

括号的内容可以由 shell 本身提供，无论是通过文件名扩展还是任何命令或函数的输出。
要读取进程状态表中的数值，将每个值分配给数组中的一个元素，只需调用
`( $(cat /proc/$$/stat) )`。输出中的每个项都将分配给数组的一个元素。

```
$ cat /proc/$$/stat
31092 (bash) S 25803 31092 25803 34826 14039 4194304 143828 20331698 0 13877 380 112 49371 16178 20 0 1 0 252264599 30076928 2092 18446744073709551615 94425525321728 94425526383688 140735765404768 0 0 0 65536 3670020 1266777851 1 0 0 17 7 0 0 9 0 0 94425528483216 94425528530276 94425559605248 140735765413687 140735765413692 140735765413692 140735765417966 0
$ stat=( $(cat /proc/$$/stat) )
$ echo ${stat[1]}
(bash)
$ echo ${stat[2]}
S
$ echo ${stat[34]}
1
$ echo ${stat[23]}
2092
$
```

要逐行读入文件，请将 IFS 设置为换行符并将其读入。
这一技术在将文本文件读入内存时特别有用。

```bash
#!/bin/bash
oIFS=$IFS

IFS="
"

hosts=( `cat /etc/hosts` )
for hostline in "${hosts[@]}"
do
  echo line: $hostline
done

# always restore IFS or insanity will follow...
IFS=$oIFS
```

运行这个脚本时，会产生如下输出：

```
$ readhosts.sh
line: 127.0.0.1	localhost
line: 127.0.1.1	hexu-Lenovo-Legion-Y7000P2020H
line: # The following lines are desirable for IPv6 capable hosts
line: ::1     ip6-localhost ip6-loopback
line: fe00::0 ip6-localnet
line: ff00::0 ip6-mcastprefix
line: ff02::1 ip6-allnodes
line: ff02::2 ip6-allrouters
line: 185.199.110.133 raw.githubusercontent.com
$
```

source 也可以是通配符扩展中的文件列表。
在下面的代码中，每个匹配模式 `*.mp3` 添加到 mp3s 数组中：

```
$ mp3s=( *.mp3 )
$ for mp3 in "${mp3s[@]}"
> do
>   echo "MP3 File: $mp3"
> done
MP3 File: 01 - The MC5 - Kick Out The Jams.mp3
MP3 File: 02 - Velvet Underground - I’m Waiting For The Man.mp3
MP3 File: 03 - The Stooges - No Fun.mp3
MP3 File: 04 - The Doors - L.A. Woman.mp3
MP3 File: 05 - The New York Dolls - Jet Boy.mp3
MP3 File: 06 - Patti Smith - Gloria.mp3
MP3 File: 07 - The Damned - Neat Neat Neat.mp3
MP3 File: 08 - X-Ray Spex - Oh Bondage Up Yours!.mp3
MP3 File: 09 - Richard Hell & The Voidoids - Blank Generation.mp3
MP3 File: 10 - Dead Boys - Sonic Reducer.mp3
MP3 File: 11 - Iggy Pop - Lust For Life.mp3
MP3 File: 12 - The Saints - This Perfect Day.mp3
MP3 File: 13 - Ramones - Sheena Is A Punk Rocker.mp3
MP3 File: 14 - The Only Ones - Another Girl, Another Planet.mp3
MP3 File: 15 - Siouxsie & The Banshees - Hong Kong Garden.mp3
MP3 File: 16 - Blondie - One Way Or Another.mp3
MP3 File: 17 - Magazine - Shot By Both Sides.mp3
MP3 File: 18 - Buzzcocks - Ever Fallen In Love (With Someone You Shouldn’t’ve).mp3
MP3 File: 19 - XTC - This Is Pop.mp3
MP3 File: 20 - Television - Marquee Moon.mp3
MP3 File: 21 - David Bowie - ‘Heroes’.mp3
$
```

在使用 `-a` 标志调用 bash shell 内置命令 read 可以将元素读入数组。
无论是从用户输入还是从文件，这是定义数组的一种非常简单的方法。

```
$ read -a dice
4 2 6
$ echo "you rolled ${dice[0]} then ${dice[1]} then ${dice[2]}"
you rolled 4 then 2 then 6
$
```

read -a 命令在很多情况下都非常有用，而与 IFS 变量结合使用时更加有用。
以下示例告诉 shell IFS 不同于它的默认值 `<space><tab><newline>`，
因为 /etc/passwd 的每行的字段用冒号分隔，要读取它只需在 read 命令之前设置 `IFS=:` 即可。
请注意，最好尽可能在您希望修改 IFS 的命令所在的同一行中使用 `IFS=`语句，
这样它仅影响 read 命令，而不影响循环中的其他命令。

以下面例子为例：

```
#!/bin/bash

while IFS=: read -a userdetails
do
  unset user
  gecos=${userdetails[4]%%,*}
  username=${userdetails[0]}
  user=${gecos:-$username}
  if [ -d "${userdetails[5]}" ]; then
    echo "${user}'s directory ${userdetails[5]} exists"
  else
    echo "${user}'s directory ${userdetails[5]} doesn't exist"
  fi
done < /etc/passwd
```

运行这个脚本时，会产生如下输出：

```
root's directory /root exists
daemon's directory /usr/sbin exists
bin's directory /bin exists
sys's directory /dev exists
sync's directory /bin exists
games's directory /usr/games exists
man's directory /var/cache/man exists
lp's directory /var/spool/lpd doesn't exist
mail's directory /var/mail exists
news's directory /var/spool/news doesn't exist
uucp's directory /var/spool/uucp doesn't exist
proxy's directory /bin exists
www-data's directory /var/www exists
backup's directory /var/backups exists
Mailing List Manager's directory /var/list doesn't exist
ircd's directory /var/run/ircd doesn't exist
Gnats Bug-Reporting System (admin)'s directory /var/lib/gnats doesn't exist
nobody's directory /nonexistent doesn't exist
systemd Network Management's directory /run/systemd/netif exists
systemd Resolver's directory /run/systemd/resolve exists
syslog's directory /home/syslog doesn't exist
messagebus's directory /nonexistent doesn't exist
_apt's directory /nonexistent doesn't exist
uuidd's directory /run/uuidd exists
Avahi autoip daemon's directory /var/lib/avahi-autoipd exists
usbmux daemon's directory /var/lib/usbmux doesn't exist
dnsmasq's directory /var/lib/misc exists
RealtimeKit's directory /proc exists
user for cups-pk-helper service's directory /home/cups-pk-helper doesn't exist
Speech Dispatcher's directory /var/run/speech-dispatcher doesn't exist
whoopsie's directory /nonexistent doesn't exist
Kernel Oops Tracking Daemon's directory / exists
saned's directory /var/lib/saned doesn't exist
Avahi mDNS daemon's directory /var/run/avahi-daemon exists
colord colour management daemon's directory /var/lib/colord exists
HPLIP system user's directory /var/run/hplip doesn't exist
geoclue's directory /var/lib/geoclue exists
PulseAudio daemon's directory /var/run/pulse doesn't exist
gnome-initial-setup's directory /run/gnome-initial-setup/ doesn't exist
Gnome Display Manager's directory /var/lib/gdm3 exists
hexu's directory /home/hexu exists
sshd's directory /run/sshd exists
postfix's directory /var/spool/postfix exists
NetworkManager OpenConnect plugin's directory /var/lib/NetworkManager exists
MySQL Server's directory /nonexistent doesn't exist
mosquitto's directory /var/lib/mosquitto exists
redis's directory /var/lib/redis exists
```

bash shell 内置命令 readarray 以比如前面的读取 /etc/hosts 脚本更灵活的方式读取文本文件。
可以指定初始索引值（`-O`），以及要读取的最大行数 （`-n`）。也可以从输入的开头跳过几行（`-s`）。

```
$ readarray -n 4 -s 2 food
porridge
black pudding
apples
bananas
cucumbers
burgers
eggs
$ printf "%s" "${food[@]}"
apples
bananas
cucumbers
burgers
$
```

由于 `-s 2` 参数，前两项被跳过。尽管这意味着总共读取了 6 个参数，但因为参数 `-n 4`，实际读取的参数只有4个，
所以数组的大小为 4。输入中的第 7 项根本不会被读取。

显示数组项的一种常见方法是 `printf "%sn" "${food[@]}"` 表示法，这将遍历数组的值，将每个值打印为字符串后跟换行符。
因为结尾换行符已添加到数组的元素中，在前面的示例中不需要 `\n`。
readarray 的 `-t` 标志会去除这些结尾换行符。


### 参考资料:
- 《Shell脚本编程诀窍 适用于Linux、Bash等》: 9.1 数组的赋值

