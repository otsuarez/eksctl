# FROM debian:buster-slim
FROM python:3.7.4-alpine3.10

ENV UNAME=Linux

ADD https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_${UNAME}_amd64.tar.gz .

RUN tar xfz eksctl_${UNAME}_amd64.tar.gz -C /tmp  && \
    mv /tmp/eksctl /usr/local/bin
RUN apk add --no-cache gcc openssl-dev libffi-dev make curl && \
    pip install --upgrade pip && \
    pip3 install awscli --upgrade
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl