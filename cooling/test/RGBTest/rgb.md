树莓派智能贴身管家需要正确插入到树莓派的GPIO口上，并且打开树莓派的I2C功能。
本次实验现象为设置所有RGB灯的颜色为绿色。

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
gcc -o rgb rgb.c -lwiringPi
 
其中，调用gcc编译器，-o表示生成文件，后面加生成的文件名，rgb.c是源程序，-lwiringPi是引用树莓派的wiringPi库。
3.运行程序
./rgb
 
此时可以看到三个RGB灯同时亮绿色。

三、代码解读
1.智能温控扩展上有三个RGB灯，所以定义灯的数量为3，声明setRGB和closeRGB函数。
 
2. void setRGB(int num, int R, int G, int B)函数：
设置RGB灯颜色，num指的是哪个灯，0为第一个灯，1为第二个灯，2为第三个灯，如果大于等于3，则所有灯同时设置。R，G，B值的取值范围都为0~255。
 

3.关闭RGB，根据协议可知，关闭RGB的寄存器为0x07，数据为0x00。
 
4.在main函数里初始化I2C配置。
 
5.先关闭RGB灯，再设置RGB灯，如果不先关闭的话，有时候会影响到显示的效果。setRGB的效果可以自己设置，这里以所有灯亮绿色为例。
