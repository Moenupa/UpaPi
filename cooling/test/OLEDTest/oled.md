树莓派智能贴身管家需要正确插入到树莓派的GPIO口上，并且打开树莓派的I2C功能。
本次实验现象为OLED显示树莓派的CPU占用率、CPU温度、运行内存占用率、磁盘占用率和IP地址等信息。

一、文件传输（已经有文件可以忽略此步骤）
1. 电脑端安装WinSCP工具，连接树莓派后把资料中下载的temp_control.zip压缩包传到树莓派的pi目录下。树莓派与win电脑传输文件的方法请参考：
https://www.yahboom.com/build.html?id=2631&cid=308
 
2.解压文件
打开树莓派的终端，找到刚刚传进树莓派的temp_control.zip文件
 
输入以下命令解压
unzip temp_control.zip
 

二、编译和运行程序
1.进入文件夹并查看当前文件夹下的文件
cd temp_control/
ls
 
2.编译程序文件
gcc -o oled oled.c ssd1306_i2c.c -lwiringPi
 
其中，调用gcc编译器，-o表示生成文件，后面加生成的文件名，oled.c和ssd1306_i2c.c是源程序，-lwiringPi是引用树莓派的wiringPi库。
3.运行程序
./oled
 
此时可以看到oled屏上显示树莓派的CPU占用率、CPU温度、运行内存占用率、磁盘占用率和IP地址等信息。

三、代码解读
1.导入wiringPi/I2C库、oled显示屏库、文件控制库、读取IP库和读取磁盘库。
 
2.定义温度、CPU使用率、系统信息、磁盘信息、IP等相关的参数. 
 
3.初始化oled显示器，并从终端输出初始化成功信息。
 
4.读取系统信息，如果失败则在oled上显示sysinfo-Error，并等待0.5秒重新读取：
 
5.读取CPU占用率，首先需要打开的文件是/proc/stat，这个文件保存CPU的活动信息，该文件的所有值都是从系统启动开始累计到当前时刻的。
在终端输入cat /proc/stat即可查到CPU的活动数据：
 
我们要计算CPU的使用率，只需要用到最上面一行数据就可以，下面我也只解释这一行数据代表的意义。
（jiffies是内核中的一个全局变量，用来记录自系统启动以来产生的节拍数，在linux中，一个节拍大致可理解为操作系统进程调度的最小时间片，不同linux内核可能值有不同，我们可以认为：1 jiffies = 10ms）
参数	解析（单位：jiffies）
user(969)	从系统启动开始累计到当前时刻，处于用户态的运行时间，不包含 nice值为负进程。
nice(0)	从系统启动开始累计到当前时刻，nice值为负的进程所占用的CPU时间
system(1557)	从系统启动开始累计到当前时刻，处于核心态的运行时间
idle(20390)	从系统启动开始累计到当前时刻，除IO等待时间以外的其它等待时间
iowait(623)	从系统启动开始累计到当前时刻，IO等待时间
irq(0)	从系统启动开始累计到当前时刻，硬中断时间
softirq(10)	从系统启动开始累计到当前时刻，软中断时间
stealstolen(0)	在虚拟环境中运行时，在其他操作系统中花费的时间是多少
guest(0)	在Linux内核控制下运行来宾操作系统的虚拟CPU的时间是多少
总的CPU时间的计算公式（累加的值）：
totalTime = user+nice+system+idle+iowait+irq+softirq+stealstolen+guest
我们需要通过读取以上内容的参数，来计算当前CPU的占用率，由于是从系统启动开始累计到当前时刻的，所以通过短时间（1秒）间隔采集的两个参数的差值，就可以算出CPU时间总量total，再以相同的方法计算出空闲时间idle，最后CPU使用率usage=100*(total-idle)/total.
另外：其实在树莓派终端也可以直接输入命令查看当前CPU的使用率，主要输入以下代码就可以显示CPU使用率：
cat <(grep 'cpu ' /proc/stat) <(sleep 1 && grep 'cpu ' /proc/stat) | awk -v RS="" '{print ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5) "%"}'
 
程序代码：
 
要先打开/proc/stat文件，并且用fgets函数读取数据，sscanf函数是把读取的参数保存到对应的变量里，然后再计算出第一次读取的total_1和idle_1；接着延迟1秒，并清除变量数据，已经测试过时间小于1秒会出现读取数据失效的问题；第二次读取数据保存到total_2和idle_2里；最后再计算出CPU使用率usage的值，并且存入CPUInfo中。
6.读取运行内存占用率，读取出的数据是以b为单位的，为了方便显示，需要转化成Mb，数值右移20位即可完成，也可以写成以下方式：unsigned long totalRam = sys_info.totalram / 1024 / 1024;
 
7.读取IP地址，可以显示网线和WiFi网络的IP地址，优先显示网线的IP地址。
 
8.读取温度。
 
9.读取磁盘空间
 
10.设置在oled上要显示的内容

其中ssd1306_drawText(int x, int y, char *str)函数是设置oled上显示的内容，第一个参数为x，控制左右偏移量，第二个参数为y，控制上下偏移量，第三个是字符串指针，也就是要显示的内容。
最后要运行ssd1306_display()函数才会刷新显示。
