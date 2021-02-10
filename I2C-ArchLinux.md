# Setup I2C on Raspberry Pi 4 Model B using Arch Linux

This article introduces procedures to set up your I2C environment on RPi using Arch Linux. The demonstration is based on RPi 4B on Manjaro-ARM. The procedures may vary based on every environment.

```txt
Version INFO
    KDE Plasma Version: 5.20.5
KDE Frameworks Version: 5.78.0
            Qt Version: 5.15.2
        Kernel Version: 5.4.83-1-MANJARO-ARM
               OS Type: 64-bit
```

## Basics

For those who are new to Linux (or Arch Linux), there are a few things that you need to know. If you are experienced, skip this part.

First is about `sudo`, which allow us to manage permissions easier, they are quite like `Run As Administrator` in Windows system. 

Second is about `pacman`, a package manager, which is like AppStore, centralizing the packages (or software for understanding) for users to install at one command.

## Getting Started

At this point, I assume you have gone through the bare-bone stage, and have installed `sudo`, if not, try `pacman -S sudo` to install `sudo`.

Let's get started by updating with `pacman`.

```shell
$ sudo pacman -Syu # Update package libraries and system
```

## Installing Dependencies

Install the following packages. 

```shell
$ sudo pacman -S gcc git i2c-tools base-devel
$ sudo pacman -S binutils make pkg-config fakeroot # makepkg dependencies
$ sudo pacman -S xorg-xrandr libnewt
```

In my case I use C to work with I2C, so no more dependency is needed. But if you are using Python driver scripts (for instance Python2), execute the following additional script.

```shell
$ sudo pacman python2 python2-pip python2-distribute
$ sudo pip2 install RPI.GPIO
```

## Enable I2C via Raspi-config

Install Raspi-config with:

```shell
$ git clone https://aur.archlinux.org/raspi-config.git
$ cd raspi-config
$ makepkg -i
```

Then open Raspi-config and use it to enable I2C.

```shell
$ sudo raspi-config
```

Then in the menu, find `Interfacing Options` - `I2C`, enable it. *\[Note: use Tab to change focus, Enter to confirm selected\]* and hit `Finished` to exit.

It is fine if you receive some warning like:

```txt
/usr/bin/raspi-config: line 997: warning: command substitution: ignored null byte in input
\* Failed to read active DTB
```

## Reboot

Reboot RPi to take effect. Using:

```shell
sudo reboot
```

## Test I2C

```shell
$ sudo i2cdetect -y 1
```

The output should be something like:

```txt
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --
```

## Use case: What can I2C do?

Well in my case, my RPi is connect to a 128x32 pixel screen to show the IP, and a fan turning on/off automatically when temperature reaches some threshold.

Of course, usage of I2C is far beyond that, I wrote this purely to inspire you guys.

## References
RPi Zero W I2C Arch Linux Setup Guide [https://ladvien.com/arch-linux-i2c-setup/](https://ladvien.com/arch-linux-i2c-setup/)