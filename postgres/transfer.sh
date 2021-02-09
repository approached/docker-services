#!/bin/sh

rm -rf backup/
scp -r root@116.202.31.190:/opt/postgres/ backup

