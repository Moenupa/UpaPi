# 树莓派智能贴身管家单片机I2C通讯协议（I2C地址：0x0d）

## 协议表

||Register|数据值|备注|
|:--|:--|:--|:--|
|RGB|`0x00`|`0x00-0x02,0xff`|选择灯No.1/No.2/No.3/全选|
||`0x01`|`0x00-0xff`|R|
||`0x02`|`0x00-0xff`|G|
||`0x03`|`0x00-0xff`|B|
||`0x04`|`0x00-0x04`|模式：`0x00`流水灯，`0x01`呼吸灯,`0x02`跑马灯，`0x03`彩虹灯，`0x04`炫彩灯|
||`0x05`|`0x00-0x03`|速度：`0x01`低/`0x02`中（默认）/`0x03`高|
||`0x06`|`0x00-0x06`|流水/呼吸模式颜色：`0x00`红/`0x01`绿（默认）/`0x02`蓝/`0x03`黄/`0x04`紫/`0x05`青/`0x06`白|
||`0x07`|`0x00`|`0x00`关闭RGB灯|
|FAN|`0x08`|`0x00-0x09`|速度：`0x00`=OFF/`0x01`=全速/`0x02`=20%/`0x03`=30%/.../`0x09`=90%|

## 示例代码

```c
#include <stdio.h>
// 导入wiringPi/I2C库
#include <wiringPi.h>
#include <wiringPiI2C.h>

int main(void)
{
	int state = 0;
	// 定义I2C相关参数
	int fd_i2c;
	wiringPiSetup();
	fd_i2c = wiringPiI2CSetup(0x0d);
	if (fd_i2c < 0) { fprintf(stderr, "fail to init I2C\n"); return -1; }
	// 循环让state自加1，每次加1都发一个命令调节调节风扇的速度
	while (1)
	{
		switch (state)
		{
			case 0: wiringPiI2CWriteReg8(fd_i2c, 0x08, 0x00); break;
			case 1: wiringPiI2CWriteReg8(fd_i2c, 0x08, 0x02); break;
			case 2: wiringPiI2CWriteReg8(fd_i2c, 0x08, 0x03); break;
			case 3: wiringPiI2CWriteReg8(fd_i2c, 0x08, 0x04); break;
			case 4: wiringPiI2CWriteReg8(fd_i2c, 0x08, 0x05); break;
			case 5: wiringPiI2CWriteReg8(fd_i2c, 0x08, 0x06); break;
			case 6: wiringPiI2CWriteReg8(fd_i2c, 0x08, 0x07); break;
			case 7: wiringPiI2CWriteReg8(fd_i2c, 0x08, 0x08); break;
			case 8: wiringPiI2CWriteReg8(fd_i2c, 0x08, 0x09); break;
			case 9: wiringPiI2CWriteReg8(fd_i2c, 0x08, 0x01); break;
			default: break;
		}
		if (state == 0) delay(1000);
		state++;
		if (state > 9)
		{
			delay(1000);
			state = 0;
		}
		delay(1000);
	}
	return 0;
}
```
