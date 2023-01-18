# Zabbix

## Webinterface

Default login:
username: Admin
password: zabbix

## Add agent

Ubuntu 22:
```
cd /tmp
wget https://repo.zabbix.com/zabbix/6.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.2-4%2Bubuntu22.04_all.deb
sudo dpkg -i zabbix-release_6.2-4+ubuntu20.04_all.deb
apt-get update
apt-get install zabbix-agent2
```

Add Docker:
```
usermod -aG docker zabbix
```
