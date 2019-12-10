FROM debian:buster-slim

ENV UNAME=Linux

ADD https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_${UNAME}_amd64.tar.gz .

RUN apt update && \
    apt install -y --no-install-recommends python3-pip python3-setuptools curl git jq vim && \
    pip3 install wheel --upgrade && \
    pip3 install awscli --upgrade

RUN tar xfz eksctl_${UNAME}_amd64.tar.gz -C /tmp  && \
    mv /tmp/eksctl /usr/local/bin && \
    rm eksctl*_amd64.tar.gz

RUN curl -fSs "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb" && \
    dpkg -i session-manager-plugin.deb && \
    rm session-manager-plugin.deb

RUN curl -fSsLO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

RUN curl -fSs https://api.github.com/repos/kubernetes-sigs/kustomize/releases | \
    jq -r '[ .[].assets[] | select(.name | startswith("kustomize")) | select(.name | endswith("linux_amd64.tar.gz")).browser_download_url ][0]' | \
    xargs curl -fSsOL && \
    tar xzf ./kustomize_v*_linux_amd64.tar.gz && \
    mv ./kustomize /usr/local/bin/kustomize && \
    rm kustomize_*_linux_amd64.tar.gz

RUN curl -fSso aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x ./aws-iam-authenticator && \
    mv aws-iam-authenticator /usr/local/bin/aws-iam-authenticator

COPY [ "files/cluster-actions.sh", "/usr/local/bin/cluster-actions" ]
COPY [ "files/cluster-test.sh", "/usr/local/bin/cluster-test" ]
