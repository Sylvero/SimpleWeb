# Specify a base image
FROM node:alpine

WORKDIR /usr/app

# Install some depenendencies
COPY ./package.json ./
RUN npm install
COPY ./ ./

# Default command
# syntax=docker/dockerfile:experimental
FROM alpine
# install ssh client and git
WORKDIR /usr/app
RUN apk add --no-cache openssh-client git
# clone our private repository
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts
RUN --mount=type=ssh git clone git@github.com:Sylvero/SimpleWeb.git /usr/app
