# Docker Services

## WikiJS

```
cd wikijs
docker-compose up
```

Go to http://127.0.01:.test/

## Traefik local

Create cert (https://github.com/FiloSottile/mkcert):
```sh
brew install mkcert
brew install nss # only if you use Firefox
mkcert -install # Setup the local Root CA
mkcert -cert-file traefik-local/certs/local.crt -key-file traefik-local/certs/local.key "traefik.test" "whoami.test" "heimdall.test" "dejavu.test" "elasticsearch.test" "metabase.test" "wikijs.test" "hasura.test" "keycloak.test" "checkmk.test" "zabbix.test" "invoiceninja.test"
```

Start:
```
docker-compose -f traefik-local/docker-compose.yml up -d --force-recreate
```

Stop:
```
docker-compose -f traefik-local/docker-compose.yml down
```

Go to https://traefik.test/

## Heimdall

Start:
```
docker-compose up -d --force-recreate
```

Go to https://heimdall.test/

## Elasticsearch

Start:
```
docker-compose up -d --force-recreate
```

Go to https://elasticsearch.test/


## Dejavu

Start:
```
docker-compose up -d --force-recreate
```

Go to https://dejavu.test/


## Metabase

Start:
```
docker-compose up -d --force-recreate
```

Go to https://metabase.test/


## WikiJS

Required: Traefik, Postgres

Create database:
```
./postgres/join.sh

create database wikijs;
create user wikijs with encrypted password 'wikijs';
grant all privileges on database wikijs to wikijs;
```

Start:
```
docker-compose -f wikijs/docker-compose.yml up -d --force-recreate
```

Go to https://wikijs.test/


## Postgres

Start:
```
docker-compose -f postgres/docker-compose.yml up -d --force-recreate
```

Stop:
```
docker-compose -f postgres/docker-compose.yml down
```

## Hasura

Start:
```
docker-compose -f traefik-local/docker-compose.yml up -d --force-recreate
docker-compose -f hasura/docker-compose.yml up -d --force-recreate
```

Stop:
```
docker-compose -f hasura/docker-compose.yml down
```

Go to https://hasura.test/
