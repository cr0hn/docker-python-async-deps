FROM python:3.8-alpine as base

RUN apk update && \
    apk upgrade && \
    apk --no-cache --update add git python py-pip openssl ca-certificates bash

FROM base as builder

RUN mkdir /install
RUN apk add --no-cache build-base gcc musl-dev python3-dev libffi-dev openssl-dev libxml2-dev libxslt-dev
RUN pip install --no-cache-dir -U pip && \
    pip wheel --no-cache-dir --wheel-dir=/root/wheels uvloop sanic aioredis sanic_envconfig aio-pika aiohttp aiodocker cryptography lxml

FROM base
COPY --from=builder /root/wheels /root/wheels

# lxml binary dependencies
COPY --from=builder /usr/lib/libxslt.so.1 /usr/lib/libxslt.so.1
COPY --from=builder /usr/lib/libexslt.so.0 /usr/lib/libexslt.so.0
COPY --from=builder /usr/lib/libxml2.so.2 /usr/lib/libxml2.so.2
COPY --from=builder /usr/lib/libgcrypt.so.20 /usr/lib/libgcrypt.so.20
COPY --from=builder /usr/lib/libgpg-error.so.0 /usr/lib/libgpg-error.so.0

RUN pip install --no-cache --no-index --find-links=/root/wheels uvloop sanic aioredis sanic_envconfig aio-pika aiohttp aiodocker cryptography lxml
