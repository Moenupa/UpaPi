# I2C

## 一、树莓派打开I2C设置

PS：树莓派智能贴身管家与树莓派的控制方式是通过 I2C 来操作的，所以我们先使能树莓派的 I2C 服务。

```shell
$ sudo raspi-config
```

选择第五项 Interfacing Options

![RPi_front][4]

选择 P5 I2C,再选择 YES 确认。

![RPi_front][5]
![RPi_front][6]

## 二、安装wiringPi 

PS：一般树莓派官方 raspbian 系统默认会自带 wiringPi，可以运行 `gpio –v` 查看版本，如果有则跳过此步骤。

```shell
$ cd ~
$ git clone git://git.drogon.net/wiringPi #如果此步骤下载不了，请使用以下命令下载非官方的wiringPi镜像：
$ #git clone https://github.com/WiringPi/WiringPi.git
$ cd WiringPi
$ sudo ./build
```

## 三、安装gcc

PS：树莓派官方 raspbian 带桌面软件版本系统有自带，可以运行 `gcc –v` 查看版本，如果有则跳过此步骤。

```shell
$ sudo apt-get install gcc
```

## 四、oled显示屏驱动

只需要把 oled 驱动库的三个驱动文件 `ssd1306_i2c.c` / `ssd1306_i2c.h` / `oled_fonts.h`，放在要运行的源码同一个文件夹下，使用 gcc 编译就可以。

例如：编译 `oled.c`

```shell
$ gcc -o oled oled.c ssd1306_i2c.c -lwiringPi
$ ./oled
```

[4]: ./Picture4.png
[5]: ./Picture5.png
[6]: ./Picture6.png