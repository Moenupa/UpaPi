#!/bin/sh

##/etc/rc.local.d/
# Create Start-up Service for sh script under /etc/rc.local.d/
sudo touch /etc/systemd/system/rc-local.service
sudo printf "[Unit]\nDescription="/etc/rc.local Compatibility"\n[Service]\nType=oneshot\nExecStart=/etc/rc.local start\nTimeoutSec=0\nStandardInput=tty\nRemainAfterExit=yes\nSysVStartPriority=99\n[Install]\nWantedBy=multi-user.target\n" > /etc/systemd/system/rc-local.service
## Link to Shell Script
sudo touch /etc/rc.local
sudo printf "#!/bin/sh\nif test -d /etc/rc.local.d; then\n\tfor rcscript in /etc/rc.local.d/\*.sh; do test -r "${rcscript}" && sh ${rcscript}; done\n\tunset rcscript\nfi\n" > /etc/rc.local
## Enable the service
sudo chmod 755 /etc/rc.local
sudo mkdir /etc/rc.local.d
sudo systemctl enable rc-local.service