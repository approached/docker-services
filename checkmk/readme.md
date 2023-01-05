# Checkmk

# bash

```
docker container exec -it -u cmk checkmk bash
```

## Add agent

Install agent:
```sh
cd /tmp/
wget https://monitoring.example.com/cmk/check_mk/agents/check-mk-agent_2.1.0p18-1_all.deb
apt install /tmp/check-mk-agent_2.1.0p18-1_all.deb
```

Register agent:
```sh
cmk-agent-ctl register --hostname new_cool_server.example.com \
    --server monitoring.example.com --site cmk \
    --user automation --password 'CHANGE_ME'
```

## Add docker

https://docs.checkmk.com/latest/en/monitoring_docker.html?lquery=docker
