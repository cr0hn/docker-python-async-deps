Python Async deps
=================

This repo contains a Docker file ready for building in dockerhub with te most common Python asyncio libraries that needs to be compiled. The goal of this Dockerfile / Docker Image is to avoid waste time when try to create Docker with these dependencies.

Dependencies
------------

This Docker contains these dependencies:

**OS**

- Base OS: Alpine
- Python 3.8
- build-base (Core development and building tools)
- git
- pip 20.x

**Python**

- uvloop
- sanic
- aioredis
- sanic_envconfig
- aio-pika
- aiohttp
- aiodocker

Usage
-----

.. code-block:: console

    FROM cr0hn/docker-python-async-deps

    [your code here]

