## 利用type 来知道这个指令怎么来的

```
[root@node1 /]# type ll
ll is aliased to `ls -l --color=auto'
[root@node1 /]# type rm
rm is aliased to `rm -i'
[root@node1 /]# type -a ls
ls is aliased to `ls --color=auto'
ls is /usr/bin/ls
```

## 利用 \ 转义 【Enter】

```
[root@node1 /]# echo aa\
> bb
aabb
```

## 指令组合键盘

```
ctrl+u ctrl+k 分别从光标向前及向后删除命令串
ctrl+a ctrl+e 分别让光标回到命令串最前及最后
ctrl+d 相当于exit
```

## 输出自己的进程号

```
[root@node1 /]# echo $$
72942
```

## 上一条命令的返回值

```
[root@node1 /]# echo $?
0
```

## 查询语言体系

```
locale -a

cat /etc/locale.conf

[root@node1 /]# locale
LANG=en_US.UTF-8
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=
```

## linux限制资源

```
ulimit
```

## 设置变量别名

```
alias rm='rm -i' 
unalias
```

## linux登陆打印信息

```
[root@node1 /]# cat /etc/issue
\S
Kernel \r on an \m

/d  本地端时间的日期
/l  显示第几个终端机接口
/m  显示硬件的等级（i386/i686...）
/n  显示主机的网络名称
/o  显示 domain name
/r  显示操作系统的版本/t  显示本地端时间的时间
/s  显示操作系统的名称
/v  显示操作系统的版本

```

## bash 默认读取的环境配置

### login

需要输入用户名密码

```
/etc/profile

/etc/profile.d/*.sh

/etc/locale.conf

/usr/share/bash-completion/completions/*

3取1
~/.bash_profile
~/.bash_login
~/.profile

```

调用流程：

/etc/profile -> (~/.bash_profile | ~/.bash_login | ~/.profile) -> ~/.bashrc -> /etc/bashrc -> ~/.bash_logout

```
（1）/etc/profile： 此文件为系统的每个用户设置环境信息,当用户第一次登录时,该文件被执行. 并从/etc/profile.d目录的配置文件中搜集shell的设置。

（2）/etc/bashrc: 为每一个运行bash shell的用户执行此文件.当bash shell被打开时,该文件被读取。

（3）~/.bash_profile: 每个用户都可使用该文件输入专用于自己使用的shell信息,当用户登录时,该文件仅仅执行一次!默认情况下,他设置一些环境变量,执行用户的.bashrc文件。

（4）~/.bashrc: 该文件包含专用于你的bash shell的bash信息,当登录时以及每次打开新的shell时,该该文件被读取。

（5）~/.bash_logout:当每次退出系统(退出bash shell)时,执行该文件. 另外,/etc/profile中设定的变量(全局)的可以作用于任何用户,而~/.bashrc等中设定的变量(局部)只能继承/etc /profile中的变量,他们是”父子”关系。

（6）~/.bash_profile 是交互式、login 方式进入 bash 运行的~/.bashrc 是交互式 non-login 方式进入 bash 运行的通常二者设置大致相同，所以通常前者会调用后者。
```

### non-login

```

```

### 数据流定向

| 类型              | 默认位置  | 代码  | 符号 ｜
|-----------------|-------|-----|-------------------------|
| 标准输出（stdout）    | 屏幕    | 1   | > (1>)  or   >> or(1>>) |
| 标准错误输出（stderr）  | 屏幕    | 2   | 2>   or   2>>           |
| 标准输入（stdin）     | 键盘    | 0   | 0 <   or   <<           |

丢弃信息

```
 2 > /dev/null

```

## 抓取命令 grep

## 双向重定义 tee

## 划分文件 split

## 参数替换 xargs

## 利用- 来替换文件的参数值

## 表达式运算

### 数值计算

```
echo $(( 12 % 3 ))
```

### 小数点计算

```
echo "123.123*55.9" |bc
```

## 参数比较 test

```

-e	当路径存在时返回真
-f	当路径存在且为文件时返回真
-d	当路径存在且为文件夹时返回真

-z	当str为空时返回真
-n	当str为非空时返回真
=	两个字符串相等时返回真
==	两个字符串相等时返回真，同=
!=	两个字符串不相等时返回真


-eq	等于时返回真
-ne	不等于时返回真
-lt	小于时返回真
-le	小于等于时返回真
-gt	大于时返回真
-ge	大于等于时返回真

-a	逻辑与
-o	逻辑或
！	逻辑非
```

## 默认变量

```
$#：意思是传进文件传了几个参数，就像上面举的例子是两个参数

$*：由所有参数构成的用空格隔开的字符串，如上例为"$1 $2"

$@：每个参数分别用双引号括起来的字符串，如上例为"$1" "$2"

```

## 分支判断

```


if [] then;

elif

fi


case $1 in
 "aa") ;;
 "") ;;
 *) ;;
esac
```

## 循环

```
while []
do

done

util []
do

done

for i in $a
do
   echo $i
done


s=0
for ((i=1;i<=${nu};i=i+1))
do
    s=$((${s}+${i}))
done
echo $s
```

## shell 脚本的跟踪与调试

```
使用sh -nvx
sh [-nvx] xxx.sh

参数说明：

-n:不会执行该脚本，仅查询脚本语法是否有问题，并给出错误提示
-v:在执行脚本时，先将脚本的内容输出到屏幕上，然后执行脚本。如果有错误，也会给出错误提示。
-x:将执行的脚本内容及输出显示到屏幕上，这是对调试很有用的参数。



```

## linux 用户

 ```
/etc/password 存储用户
/etc/shadow 存储密码
```
## 暂停bash

```
ctrl + z

[root@node1 wgy]# vi aa.xml

[1]+  Stopped                 vi aa.xml
[root@node1 wgy]# jobs
[1]+  Stopped                 vi aa.xml
[root@node1 wgy]# fg %1
vi aa.xml
[root@node1 wgy]# bg %1

kill -9 %1

``` 

## 脱机管理 nohup
```
```
## 进程查看 
```
ps aux 查询所有系统运行的进程 
ps -l  查询当前bash相关进程
```
## top
显示
```
%us：表示用户空间程序的cpu使用率（没有通过nice调度）

%sy：表示系统空间的cpu使用率，主要是内核程序。

%ni：表示用户空间且通过nice调度过的程序的cpu使用率。

%id：空闲cpu

%wa：cpu运行时在等待io的时间

%hi：cpu处理硬中断的数量

%si：cpu处理软中断的数量

%st：被虚拟机偷走的cpu
```
参数
```
d : 改变显示的更新速度，或是在交谈式指令列( interactive command)按 s
q : 没有任何延迟的显示速度，如果使用者是有 superuser 的权限，则 top 将会以最高的优先序执行
c : 切换显示模式，共有两种模式，一是只显示执行档的名称，另一种是显示完整的路径与名称
S : 累积模式，会将己完成或消失的子进程 ( dead child process ) 的 CPU time 累积起来
s : 安全模式，将交谈式指令取消, 避免潜在的危机
i : 不显示任何闲置 (idle) 或无用 (zombie) 的进程
n : 更新的次数，完成后将会退出 top
b : 批次档模式，搭配 "n" 参数一起使用，可以用来将 top 的结果输出到档案内
p : 指定某个pid

```

## kill


```
1.重新加载系统配置文件
2.清空内存中的数据
3.清除内存中鼠标数据
9.强制结束进程（不能被拒绝）
15.正常关闭进程gedit 
18.  重新运行被暂停的进程
19.暂停（不会被阻塞，拒绝）
20.暂停（但会被阻塞）
```
## 查看哪些进程使用了哪些文件


```
fuser 

-c 包含 File的文件系统中关于任何打开的文件的报告。
-d 暗示使用了 -c 和 -x 标志。关于任何与文件系统（自父目录删除的）无链接的打开文件的报告。当与 -V 标志一起使用时，它也会报告被删除文件的节点号和大小。
-f 仅对文件
-k 将 SIGKILL 信号发送到每个本地进程。仅有 root 用户能终止另一用户的进程。
-u 为进程号后圆括号中的本地进程提供登录名。
-V 提供详细输出。
-x 与 -c 或 -f 连用，报告除标准 fuser 输出以外的可执行的和可载入的对象。

lsof

lsof filename 显示打开指定文件的所有进程
lsof -a 表示两个参数都必须满足时才显示结果
lsof -c string 显示COMMAND列中包含指定字符的进程所有打开的文件
lsof -u username 显示所属user进程打开的文件
lsof -g gid 显示归属gid的进程情况
lsof +d /DIR/ 显示目录下被进程打开的文件
lsof +D /DIR/ 同上，但是会搜索目录下的所有目录，时间相对较长
lsof -d FD 显示指定文件描述符的进程
lsof -n 不将IP转换为hostname，缺省是不加上-n参数
lsof -i 用以显示符合条件的进程情况
lsof -i[46] [protocol][@hostname|hostaddr][:service|port]


pidof 

-s 表示只返回1个 pid
-x 表示同时返回运行给定程序的 shell 的 pid
-o 表示告诉 piod 表示忽略后面给定的 pid ，可以使用多个 -o 。
```

### systemd 配置文件

```
①/etc/systemd/system：存放系统启动的默认级别及启动的unit的软连接，优先级最高。

②/run/systemd/system：系统执行过程中产生的服务脚本，优先级次之。

③/usr/lib/systemd/system：存放系统上所有的启动文件。优先级最低
```

unit分类：

unit的定义文件可以根据其后缀名称识别其定义的类型，可以使用systemctl -t help 查看。

```
#l	.servicre定义了系统服务的启动

#l	.target  定义了系统启动的级别标签，systemd 没有运行级别的概念，创建标签只是为了兼容老版本。

#l	.socket 定义了进程通信用到的套接字，套接字与进程是分离的

#l	.device 定义了系统启动时内核识别的文件，systemd提供了设备的管理功能，/dev 下的设备由/etc/udev/下的配置文件与.device共同定制

#l	.mount 定义了系统的文件系统的挂载点

#l	.snapshop 系统快照

#l	.swap 用于标识swap设备

#l	.automount 文件系统的自动挂载点

#l	.path用于定义文件系统中的一个文件或目录使用。常用于文件系统发生变化时，延迟激活服务。
```

### 

``````

```
```

```
```

``````

```
```

```
```

``````

```
```

```
```

```
