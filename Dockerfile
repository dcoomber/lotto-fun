FROM ruby:2.7-alpine

WORKDIR /app

RUN apk update && apk add build-base

COPY app/. .
