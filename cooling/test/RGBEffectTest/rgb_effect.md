树莓派智能贴身管家需要正确插入到树莓派的GPIO口上，并且打开树莓派的I2C功能。
本次实验现象为所有RGB灯亮紫色的呼吸灯效果。

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
gcc -o rgb_effect rgb_effect.c -lwiringPi
 
其中，调用gcc编译器，-o表示生成文件，后面加生成的文件名，rgb_effect.c是源程序，-lwiringPi是引用树莓派的wiringPi库。
3.运行程序
./rgb_effect
 
此时可以看到三个RGB灯同时亮紫色呼吸灯效果。

三、代码解读
1.智能贴身管家板子上有三个RGB灯，所以定义灯的数量为3，定义寄存器地址：RGB_Effect为0x04, RGB_Speed为0x05, RGB_Color为0x06。声明需要使用到的函数。
 
2. void setRGB(int num, int R, int G, int B)函数：
设置RGB灯颜色，num指的是哪个灯，0为第一个灯，1为第二个灯，2为第三个灯，如果大于等于3，则所有灯同时设置。R，G，B值的取值范围都为0~255。
 
3.关闭RGB，根据协议可知，关闭RGB的寄存器为0x07，数据为0x00。
 
4. void setRGBEffect(int effect)函数：
首先判断输入的值，和协议对应，总共有五种特效可以选择，0流水灯，1呼吸灯,2跑马灯，3彩虹灯，4炫彩灯。
 
5. void setRGBSpeed(int speed)函数：
修改以上模式的RGB灯切换速度。1低速，2中速（默认），3高速，如果不设置默认为中速。
 
6. void setRGBColor(int color)函数：
设置RGB灯特效中流水灯和呼吸灯的颜色，0红色，1绿色（默认），2蓝色，3黄色，4紫色，5青色，6白色。如果不设置默认为绿色。
 
7.初始化I2C配置
 
8.这里以设置亮高速的紫色呼吸灯为例。
