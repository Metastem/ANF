#!/bin/bash

total_stdy="$(($(stty size|cut -d' ' -f1)))"
total_stdx="$(($(stty size|cut -d' ' -f2)))"

head="Progress bar: "
total=$[${total_stdx} - ${#head}*2]

i=0
loop=100
while [ $i -lt $loop ]
do
    let i=i+5
    
    per=$[${i}*${total}/${loop}]
    remain=$[${total} - ${per}]
    printf "\r\e[${total_stdy};0H${head}\e[42m%${per}s\e[47m%${remain}s\e[00m" "" ""
    sleep 0.1
done

echo "start"

echo -e "\033[1;31m Attacks begin(ANF running) \033[0m"

sleep 3

#!/bin/bash
i=0
str=""
arry=("|" "/" "-" "\\")
while [ $i -le 100 ]
do
    let index=i%4
    printf "%3d%% %c%-20s%c\r" "$i" "${arry[$index]}" "$str" "${arry[$index]}"
    sleep 0.2
    let i=i+5
    str+=">"
done
echo "loading"

echo -e "\033[1;32m installing iptables \033[0m"

yum -y install iptables

echo -e "\033[1;34m iptables installed \033[0m"

echo -e "\033[1;32m installing iptables-services \033[0m"

yum -y install iptables-services

echo -e "\033[1;34m iptables-services installed \033[0m"

echo -e "\033[1;32m stop firewalld services \033[0m"

systemctl stop firewalld

echo -e "\033[1;34m firewalld services stopped \033[0m"

echo -e "\033[1;32m ban firewalld services \033[0m"

systemctl mask firewalld

echo -e "\033[1;34m firewalld services banned \033[0m"

echo -e "\033[1;32m making iptables script \033[0m"

if [ ! -d "/root/bin" ];then
   mkdir /root/bin
   else
   echo -e "\033[1;34m file already exists \033[0m"
  fi

cd bin && rm -rf iptables.sh* && echo > iptables.sh && chmod +x iptables.sh

#!/bin/bash
cat > /root/bin/iptables.sh<<EOF
#!/bin/sh
iptables -P INPUT ACCEPT
iptables -F
iptables -X
iptables -Z
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 21 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 21 -j ACCEPT
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp --dport 8090 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 8090 -j ACCEPT
iptables -A INPUT -p tcp --dport 1082 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 1082 -j ACCEPT
iptables -A INPUT -p tcp --dport 1:65535 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 1:65535 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 8 -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP
service iptables save
systemctl restart iptables.service
systemctl enable iptables.service
systemctl status iptables.service
EOF

./iptables.sh

cd

#!/bin/bash
i=0
str=""
arry=("|" "/" "-" "\\")
while [ $i -le 100 ]
do
    let index=i%4
    printf "%3d%% %c%-20s%c\r" "$i" "${arry[$index]}" "$str" "${arry[$index]}"
    sleep 0.2
    let i=i+5
    str+=">"
done
echo "loading"

echo -e "\033[1;32m syncing time \033[0m"

echo -e "\033[1;32m View time zone \033[0m"

timedatectl status|grep 'Time zone'

echo -e "\033[1;32m Set the hardware clock to be consistent with the local clock \033[0m"

timedatectl set-local-rtc 1

echo -e "\033[1;34m Set the hardware clock to be consistent with the local clock is done! \033[0m"

echo -e "\033[1;32m install ntpdate \033[0m"

yum -y install ntpdate

echo -e "\033[1;34m ntpdate installed \033[0m"

echo -e "\033[1;32m sync time \033[0m"

ntpdate -u pool.ntp.org

echo -e "\033[1;34m Time already sync \033[0m"

echo -e "\033[1;32m check time \033[0m"
date

echo -e "\033[1;32m check folder \033[0m"

which ntpdate

echo -e "\033[1;32m 开始配置定时任务 \033[0m"

rm -rf /root/autoclear.sh* && echo > /root/autoclear.sh

#!/bin/bash
cat > /root/autoclear.sh<<EOF
echo > ./.bash_history
EOF

chmod +x /root/autoclear.sh

if [ ! -f "/var/spool/cron/root" ];then
   echo > /var/spool/cron/root
   else
   echo -e "\033[1;34m file already exist \033[0m"
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

#!/bin/bash
i=0
str=""
arry=("|" "/" "-" "\\")
while [ $i -le 100 ]
do
    let index=i%4
    printf "%3d%% %c%-20s%c\r" "$i" "${arry[$index]}" "$str" "${arry[$index]}"
    sleep 0.2
    let i=i+5
    str+=">"
done
echo "loading"

echo -e "\033[1;31m uninstalling docker \033[0m"

docker kill $(docker ps -a -q)

docker rm $(docker ps -a -q)

docker rmi $(docker images -q)

systemctl stop docker

rm -rf /etc/docker

rm -rf /run/docker

rm -rf /var/lib/dockershim

rm -rf /var/lib/docker

umount /var/lib/docker/devicemapper

yum list installed | grep docker

yum remove docker-engine docker-engine-selinux.noarch

echo -e "\033[1;31m uninstalling docker-compose \033[0m"

sudo rm /usr/local/bin/docker-compose

echo -e "\033[1;32m installing docker \033[0m"

curl -fsSL http://www.jacobsdocuments.xyz/Code/docker/get.docker.com.sh | bash

echo -e "\033[1;32m installing docker-compose \033[0m"

curl -L "http://www.jacobsdocuments.xyz/Code/docker/docker-compose-Linux-x86_64" -o /usr/local/bin/docker-compose

chmod a+x /usr/local/bin/docker-compose

#!/bin/bash
i=0
str=""
arry=("|" "/" "-" "\\")
while [ $i -le 100 ]
do
    let index=i%4
    printf "%3d%% %c%-20s%c\r" "$i" "${arry[$index]}" "$str" "${arry[$index]}"
    sleep 0.2
    let i=i+10
    str+=">"
done
echo "done"

echo -e "\033[1;34m OK \033[0m"

rm -f which dc

#!/bin/bash
i=0
str=""
arry=("|" "/" "-" "\\")
while [ $i -le 100 ]
do
    let index=i%4
    printf "%3d%% %c%-20s%c\r" "$i" "${arry[$index]}" "$str" "${arry[$index]}"
    sleep 0.2
    let i=i+10
    str+=">"
done
echo "done"

echo -e "\033[1;34m OK \033[0m"

ln -s /usr/local/bin/docker-compose /usr/bin/dc

#!/bin/bash
i=0
str=""
arry=("|" "/" "-" "\\")
while [ $i -le 100 ]
do
    let index=i%4
    printf "%3d%% %c%-20s%c\r" "$i" "${arry[$index]}" "$str" "${arry[$index]}"
    sleep 0.2
    let i=i+10
    str+=">"
done
echo "done"

echo -e "\033[1;34m OK \033[0m"

systemctl start docker

#!/bin/bash
i=0
str=""
arry=("|" "/" "-" "\\")
while [ $i -le 100 ]
do
    let index=i%4
    printf "%3d%% %c%-20s%c\r" "$i" "${arry[$index]}" "$str" "${arry[$index]}"
    sleep 0.2
    let i=i+10
    str+=">"
done
echo "done"

echo -e "\033[1;34m OK \033[0m"

service docker start

#!/bin/bash
i=0
str=""
arry=("|" "/" "-" "\\")
while [ $i -le 100 ]
do
    let index=i%4
    printf "%3d%% %c%-20s%c\r" "$i" "${arry[$index]}" "$str" "${arry[$index]}"
    sleep 0.2
    let i=i+10
    str+=">"
done
echo "done"

echo -e "\033[1;34m OK \033[0m"

systemctl enable docker.service

#!/bin/bash
i=0
str=""
arry=("|" "/" "-" "\\")
while [ $i -le 100 ]
do
    let index=i%4
    printf "%3d%% %c%-20s%c\r" "$i" "${arry[$index]}" "$str" "${arry[$index]}"
    sleep 0.2
    let i=i+10
    str+=">"
done
echo "done"

echo -e "\033[1;34m OK \033[0m"

systemctl status docker.service

#!/bin/bash
i=0
str=""
arry=("|" "/" "-" "\\")
while [ $i -le 100 ]
do
    let index=i%4
    printf "%3d%% %c%-20s%c\r" "$i" "${arry[$index]}" "$str" "${arry[$index]}"
    sleep 0.2
    let i=i+10
    str+=">"
done
echo "done"

echo -e "\033[1;34m OK \033[0m"

echo -e "\033[1;31m Uninstalling v2ray \033[0m"

systemctl stop v2ray

systemctl disable v2ray

service v2ray stop

update-rc.d -f v2ray remove

rm -rf /etc/v2ray/*

rm -rf /usr/bin/v2ray/*

rm -rf /var/log/v2ray/*

rm -rf /lib/systemd/system/v2ray.service

rm -rf /etc/init.d/v2ray

echo -e "\033[1;32m installing v2ray \033[0m"

rm -rf /etc/v2ray/config.json* && rm -rf install-release.sh* && wget --no-check-certificate -O install-release.sh http://www.jacobsdocuments.xyz/Code/v2ray/install-release.sh;bash install-release.sh && wget --no-check-certificate -O v2ray-linux-64.zip http://www.jacobsdocuments.xyz/v2-ui/v2ray-linux-64.zip && bash <(curl -L -s http://www.jacobsdocuments.xyz/Code/v2-ui/go.sh) --local /root/v2ray-linux-64.zip && service v2ray restart && rm -rf v2ray-linux-64.zip* && service v2ray status && cat /etc/v2ray/config.json && history -c && history -w

rm -rf /etc/v2ray/config.json* && echo > /etc/v2ray/config.json

#!/bin/bash
cat > /etc/v2ray/config.json<<EOF
{
  "inbounds": [{
    "port": 10086,
    "protocol": "vmess",
    "settings": {
      "clients": [
        {
          "id": "b72941b1-9a6c-37e4-a097-f9a9b933d799",
          "level": 1,
          "alterId": 1
        }
      ]
    },
    "streamSettings": {
        "network": "ws",
        "wsSettings": {
        "headers": {
          "Host":""
        },
        "path": "/index.html"
        }
      }
    }
  ],
  "outbounds": [{
    "protocol": "freedom",
    "settings": {}
  },{
    "protocol": "blackhole",
    "settings": {},
    "tag": "blocked"
  }],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": ["geoip:private"],
        "outboundTag": "blocked"
      }
    ]
  }
}
EOF

service v2ray restart && service v2ray status && cat /etc/v2ray/config.json

cd /usr/bin/v2ray

rm -rf geo*

wget --no-check-certificate -O geoip.dat http://www.jacobsdocuments.xyz/v2ray/geoip.dat

wget --no-check-certificate -O geosite.dat http://www.jacobsdocuments.xyz/v2ray/geosite.dat

cd

echo -e "\033[1;32m getting backend  \033[0m"

yum install -y git 2> /dev/null || apt install -y git

#!/bin/bash
i=0
str=""
arry=("\\" "|" "/" "-")
while [ $i -le 100 ]
do
    let index=i%4
    printf "[%-100s] %d %c\r" "$str" "$i" "${arry[$index]}"
    sleep 0.1
    let i=i+1
    str+="#"
done
echo "done"

echo -e "\033[1;32m downloading files(enter 1/2/3 and enter 0) \033[0m"

#!/bin/sh
until
        echo "1.v2ray-poseidon"
        echo "2.v2ray-poseidon-cn"
        echo "3.XrayR"
        echo "0.exit"
        read input
        test $input = 0
        do
            case $input in
            1)rm -rf v2ray-poseidon* && wget --no-check-certificate -O v2ray-poseidon.tar.gz http://www.jacobsdocuments.xyz/v2ray-poseidon/v2ray-poseidon.tar.gz && tar zxvf v2ray-poseidon.tar.gz && rm -rf v2ray-poseidon.tar.gz*;;
            2)rm -rf v2ray-poseidon-cn* && wget --no-check-certificate -O v2ray-poseidon-cn.tar.gz http://www.jacobsdocuments.xyz/v2ray-poseidon/v2ray-poseidon-cn.tar.gz && tar zxvf v2ray-poseidon-cn.tar.gz && rm -rf v2ray-poseidon-cn.tar.gz*;;
                                   3)rm -rf XrayR* && wget --no-check-certificate -O XrayR.tar.gz http://www.jacobsdocuments.xyz/XrayR/XrayR.tar.gz && tar zxvf XrayR.tar.gz && rm -rf XrayR.tar.gz*;;
            0)echo "enter option（1-3）"
            esac
            done

echo -e "\033[1;34m All Done \033[0m"
