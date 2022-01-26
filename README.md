# Docker Services

## Traefik local

Create cert (https://github.com/FiloSottile/mkcert):
```
brew install mkcert
brew install nss # only if you use Firefox
mkcert -install # Setup the local Root CA
mkcert -cert-file certs/local.crt -key-file certs/local.key "traefik.test" "whoami.test" "heimdall.test" "dejavu.test" "elasticsearch.test"
```

Start:
```
docker-compose up -d --force-recreate
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


# Dejavu

Start:
```
docker-compose up -d --force-recreate
```

Go to https://dejavu.test/
