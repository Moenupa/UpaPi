树莓派开机自启动的方式有多种，这里选择其中一种（新建.desktop文件）作为示范。
一、添加开机自启动
1.新建启动脚本start.sh
nano /home/pi/temp_control/start.sh
输入以下内容：
#!/bin/sh
sleep 5s
cd /home/pi/ temp_control /
./ temp_control
 
按ctrl+X，按Y保存，再按回车键。

2.新建开机启动程序
输入以下命令打开.config文件夹
cd /home/pi/.config
新建autostart文件夹，如果已经已有请忽略此步骤。
mkdir autostart
进入autostart文件夹
cd autostart
新建自启动快捷方式
nano start.desktop
然后输入以下内容
[Desktop Entry]
Type=Application
Exec=sh /home/pi/cpu_show_v3/start.sh
按ctrl+X，按Y保存，再按回车键。
其中Exec=启动命令。
由于这个自启动方法需要桌面启动后才可以启动的，所以启动会比较慢，如果发现添加后无法自启动，请检查一下/boot/config.txt文件里的hdmi_force_hotplug=1前面是否有个#号，如果有#号请删除#号。以图片中为准。
 

二、重启树莓派
在终端输入以下命令重启树莓派，重启后temp_control程序会自动启动，风扇、RGB灯和oled屏都会有对应的响应。
sudo reboot

三、退出程序
由于自启动的程序是在后台运行的，我们在打开的终端无法直接退出程序。如果需要修改程序，但是后台进程干扰了我们的调试结果，怎么办呢？当然是要查看后台程序的进程号（PID），然后结束该进程。
1.在终端输入top打开进程列表
 
有时候可能需要等待一会，系统会把占用CPU资源比较高的进程排到上面。从图片中我们可以看到开机自启动的程序temp_control，其PID为718，所以我们把这个进程号kill掉，temp_control程序就不会再后台运行了。
按Ctrl+C退出top。
2.结束进程
sudo kill -9 PID
例如：以上情况，我们运行sudo kill -9 718命令，就可以结束掉后台运行的temp_control进程。如果再次运行会提示进程不存在。
 
3.重新开启后台运行
如果我们已经结束后台运行的进程，但是又不想重新启动后台程序，方法一是重启树莓派，但是这显得有点浪费时间，一寸光阴一寸金。所以我们使用第二个方法：在运行的程序后面加一个&符号。
例如我们还是后台运行temp_control程序：
先进入目标文件夹（根据个人存的文件位置来定）
cd ~/temp_control
在命令结尾增加&符号表示后台运行
./temp_control &
 
此时系统会提示此进程的PID（1015）。
再次按一下Ctrl+C。可以看到终端可以输入其他命令，程序也在后台运行了。
