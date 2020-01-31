FROM python:3.8-alpine

RUN apk update && \
    apk upgrade && \
    apk add --no-cache build-base git && \
    apk --no-cache --update add python py-pip openssl ca-certificates

RUN pip install -U pip && \
    pip install uvloop sanic aioredis sanic_envconfig aio-pika aiohttp
