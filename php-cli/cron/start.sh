#!/bin/bash

env | sed -r "s/'/\\\'/gm" | sed -r "s/^([^=]+=)(.*)\$/\1'\2'/gm" >> /etc/environment
make -f /app/Makefile update-crontab

crond -f
