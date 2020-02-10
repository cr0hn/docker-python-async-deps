FROM python:3.8-alpine as base

FROM base as builder

RUN apk update && \
    apk upgrade && \
    apk add --no-cache build-base git && \
    apk --no-cache --update add python py-pip openssl ca-certificates bash

RUN mkdir /install
RUN pip install --no-cache-dir -U pip && \
    pip wheel --no-cache-dir --wheel-dir=/root/wheels uvloop sanic aioredis sanic_envconfig aio-pika aiohttp aiodocker

FROM base
COPY --from=builder /root/wheels /root/wheels
RUN pip install --no-cache --no-index --find-links=/root/wheels uvloop sanic aioredis sanic_envconfig aio-pika aiohttp aiodocker