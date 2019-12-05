FROM debian:buster-slim

ENV UNAME=Linux

ADD https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_${UNAME}_amd64.tar.gz .

RUN tar xfz eksctl_${UNAME}_amd64.tar.gz -C /tmp  && \
    mv /tmp/eksctl /usr/local/bin && \
    rm eksctl*_amd64.tar.gz

RUN apt update && \
    apt install -y --no-install-recommends python3-pip python3-setuptools curl && \
    pip3 install wheel --upgrade && \
    pip3 install awscli --upgrade

RUN curl -s "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb" && \
    dpkg -i session-manager-plugin.deb && \
    rm session-manager-plugin.deb

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

RUN curl -s https://api.github.com/repos/kubernetes-sigs/kustomize/releases |\
    grep browser_download |\
    grep download/kustomize |\
    grep -m 1 linux |\
    cut -d '"' -f 4 |\
    xargs curl -O -L && \
    tar xzf ./kustomize_v*_linux_amd64.tar.gz && \
    mv ./kustomize /usr/local/bin/kustomize && \
    rm kustomize_*_linux_amd64.tar.gz

