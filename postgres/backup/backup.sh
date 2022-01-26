#!/bin/sh

docker exec --user postgres postgres pg_dump craft > craft_simple.sql


docker exec --user postgres postgres pg_dump --if-exists --clean --no-owner --no-privileges --no-acl --schema=public --column-inserts --exclude-table-data 'public.assetindexdata' --exclude-table-data 'public.assettransformindex' --exclude-table-data 'public.sessions' --exclude-table-data 'public.templatecaches' --exclude-table-data 'public.templatecachequeries' --exclude-table-data 'public.templatecacheelements' --exclude-table-data 'public.cache' --exclude-table-data 'public.templatecachecriteria' craft > craft_clean.sql
