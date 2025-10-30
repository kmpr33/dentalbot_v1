# syntax=docker/dockerfile:1.4

FROM python:3.11-slim AS base

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

# Instalare pachete de sistem necesare
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Creează un user non-root
RUN adduser --disabled-password --gecos "" appuser
USER appuser

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY app ./app
COPY templates ./templates
COPY static ./static
COPY scripts ./scripts
COPY start.sh /start.sh

EXPOSE 8000
ENTRYPOINT ["/bin/bash","/start.sh"]