# Create Start-up Service

## Write Service 

```shell
$ sudo vim /etc/systemd/system/rc-local.service
```

```shell
[Unit]
Description="/etc/rc.local Compatibility"

[Service]
Type=oneshot
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardInput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target
```

## Link to Shell Script

```shell
$ sudo vim /etc/rc.local
```

```shell
#!/bin/sh
# /etc/rc.local
if test -d /etc/rc.local.d; then
	for rcscript in /etc/rc.local.d/\*.sh; do 
		test -r "${rcscript}" && sh ${rcscript} 
	done 
	unset rcscript 
fi
```

## Enable the service

```shell
$ sudo chmod a+x /etc/rc.local
$ sudo mkdir /etc/rc.local.d
$ sudo systemctl enable rc-local.service
```

## AUTOSTARTUP!

THEN EVERY `sh` file UNDER `/etc/rc.local.d/` WILL AUTOSTARTUP

## Reference
[https://blog.csdn.net/u014025444/article/details/90142558](https://blog.csdn.net/u014025444/article/details/90142558)