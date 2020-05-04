FROM python:3.8-alpine as base

RUN apk update && \
    apk upgrade && \
    apk --no-cache --update add git python py-pip openssl ca-certificates bash

FROM base as builder

RUN mkdir /install
RUN apk add --no-cache build-base gcc musl-dev python3-dev libffi-dev openssl-dev
RUN pip install --no-cache-dir -U pip && \
    pip wheel --no-cache-dir --wheel-dir=/root/wheels uvloop sanic aioredis sanic_envconfig aio-pika aiohttp aiodocker cryptography lxml

FROM base
COPY --from=builder /root/wheels /root/wheels
RUN pip install --no-cache --no-index --find-links=/root/wheels uvloop sanic aioredis sanic_envconfig aio-pika aiohttp aiodocker cryptography lxml
