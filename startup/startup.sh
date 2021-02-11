#!/bin/sh

##/etc/rc.local.d/
# Create Start-up Service for sh script under /etc/rc.local.d/
sudo touch "/etc/systemd/system/rc-local.service"
sudo cat > "/etc/systemd/system/rc-local.service" << EOF
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
EOF
## Link to Shell Script
sudo touch "/etc/rc.local"
sudo cat > "/etc/rc.local" << EOF 
#!/bin/sh
if test -d /etc/rc.local.d; then
	for rcscript in /etc/rc.local.d/\*.sh; do
		test -r "${rcscript}" && sh ${rcscript}
	done
	unset rcscript
fi
EOF
## Enable the service
sudo chmod 755 "/etc/rc.local"
sudo mkdir "/etc/rc.local.d"
sudo systemctl enable rc-local.service
