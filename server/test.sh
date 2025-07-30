rm -rf /root/autoclear.sh* && echo > /root/autoclear.sh

#!/bin/bash
cat > /root/autoclear.sh<<EOF
echo > ./.bash_history
EOF

chmod +x /root/autoclear.sh

if [ ! -f "/var/spool/cron/root" ];then
   echo > /var/spool/cron/root
   else
   echo -e "\033[1;34m file already exists \033[0m"
  fi

sed -i 's/.*ntpdate.*//' /var/spool/cron/root

echo '*/1 * * * * /usr/sbin/ntpdate pool.ntp.org > /dev/null 2>&1' | cat - /var/spool/cron/root > temp && echo y | mv temp /var/spool/cron/root

sed -i 's/.*.acme.sh.*//' /var/spool/cron/root

echo '29 0 * * * "/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" > /dev/null' | cat - /var/spool/cron/root > temp && echo y | mv temp /var/spool/cron/root

sed -i 's/.*autoclear.sh.*//' /var/spool/cron/root

echo '*/1 * * * * sh /root/autoclear.sh' | cat - /var/spool/cron/root > temp && echo y | mv temp /var/spool/cron/root

sed -i '/^$/d' /var/spool/cron/root

sudo chown root:root /etc/crontab

sudo chmod 644 /etc/crontab

service crond reload

sudo /etc/init.d/crond restart

ls /etc/crontab -lh

crontab -l

echo :wq | sudo crontab -e

/usr/sbin/sestatus -v

sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config

reboot
