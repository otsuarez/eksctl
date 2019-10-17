FROM debian:buster-slim

ENV UNAME=Linux

ADD https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_${UNAME}_amd64.tar.gz .

RUN tar xfz eksctl_${UNAME}_amd64.tar.gz -C /tmp  && \
    mv /tmp/eksctl /usr/local/bin

RUN apt update && \
    apt install -y --no-install-recommends python3-pip python3-setuptools curl && \
    pip3 install wheel --upgrade && \
    pip3 install awscli --upgrade

RUN curl -s "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb" && \
    dpkg -i session-manager-plugin.deb

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

