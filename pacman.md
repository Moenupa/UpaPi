# arch/Manjaro 添加国内源以及社区源

## 添加国内源

1. 添加之前首先备份原文件

    ```shell
    cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    ```

2. 编辑/etc/pacman.d/mirrorlist配置文件

    ```shell
    vim /etc/pacman.d/mirrorlist
    ```

3. 添加manjaro稳定源

    ```shell
    ## 中科大
    Server = https://mirrors.ustc.edu.cn/manjaro/stable/$repo/$arch
    
    ##  清华大学
    Server = https://mirrors.tuna.tsinghua.edu.cn/manjaro/stable/$repo/$arch
    
    ## 上海交通大学
    Server = https://mirrors.sjtug.sjtu.edu.cn/manjaro/stable/$repo/$arch
    
    ## 浙江大学
    Server = https://mirrors.zju.edu.cn/manjaro/stable/$repo/$arch
    ```

4. 添加archlinux源
   
    ```shell
    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch 
    Server = http://mirrors.163.com/archlinux/$repo/os/$arch 
    Server = http://mirrors.aliyun.com/archlinux/$repo/os/$arch
    ```

5. 注意：使用顺序，从上往下优先级越来越低，越靠上，优先级越高

## 中文社区仓库

1. 备份原文件

    ```shell
    cp /etc/pacman.conf /etc/pacman.conf.backup
    ```

2. 编辑/etc/pacman.conf配置文件

    ```shell
    vim /etc/pacman.conf
    ```

3. 添加源

    ```shell
    [archlinuxcn]
    # The Chinese Arch Linux communities packages.
    # SigLevel = Optional TrustedOnly
    SigLevel = Optional TrustAll
    # 官方源
    Server   = http://repo.archlinuxcn.org/$arch
    # 163源
    Server = http://mirrors.163.com/archlinux-cn/$arch
    # 清华大学
    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
    ```

4. 注意：以上源，只能添加一个

5. 案例

    ```shell
    [archlinuxcn]
    # The Chinese Arch Linux communities packages.
    # SigLevel = Optional TrustedOnly
    SigLevel = Optional TrustAll
    # 清华大学
    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
    ```

## 添加AUR源 - yaourt 用户

1. 添加之前首先备份原文件

    ```shell
    cp /etc/yaourtrc /etc/yaourtrc.backup
    ```

1. 修改 /etc/yaourtrc配置文件

    ```shell
    vim /etc/yaourtrc
    ```

1. 去掉 `# AURURL` 的注释,并修改

    ```shell
    AURURL="https://aur.tuna.tsinghua.edu.cn"
    ```

## 添加AUR源 - yay 用户

1. 执行以下命令修改 aururl :

    ```shell
    yay --aururl “https://aur.tuna.tsinghua.edu.cn” --save
    ```

1. 修改的配置文件

    ```shell
    vim ~/.config/yay/config.json
    ```

1. 查看配置

    ```shell
    yay -P -g
    ```

## 手动更改源排名

```shell
sudo pacman-mirrors -i -c China -m rank
```