FROM ruby:3.3.5-alpine

WORKDIR /app

RUN apk update && apk add build-base

COPY app/. .
