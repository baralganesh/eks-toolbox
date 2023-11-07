FROM ubuntu:22.04

ARG EKSCTL_VER=v0.95.0
ARG HELM_VER=v3.9.0
ARG KUBECTL_VER=v1.24.16
ARG KUBENT_VER=0.7.0
ARG TERRAFORM_VER=1.0.9

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York

WORKDIR /tmp

# install dependencies/tools
RUN apt-get update && apt-get install -y \
  ca-certificates \
  curl \
  dnsutils \
  git \
  gnupg \
  groff \
  iputils-ping \
  jq \
  less \
  lsb-release \
  unzip \
  vim
  # && rm -rf /var/lib/apt/lists/*

# docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
  && echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
  && apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

# aws-cli2
RUN curl -sL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip \
  && unzip -q awscliv2.zip \
  && aws/install \
  && rm -rf aws awscliv2.zip

#eksctl
RUN curl -sL "https://github.com/weaveworks/eksctl/releases/download/${EKSCTL_VER}/eksctl_$(uname -s)_amd64.tar.gz" | tar xz \
  && mv eksctl /usr/local/bin

#helm3
RUN curl -sL "https://get.helm.sh/helm-${HELM_VER}-linux-amd64.tar.gz" | tar xz \
  && mv linux-amd64/helm /usr/local/bin \
  && rm -rf linux-amd64

#kubectl
RUN curl -sLO "https://dl.k8s.io/release/${KUBECTL_VER}/bin/linux/amd64/kubectl" \
  && chmod +x kubectl \
  && mv kubectl /usr/local/bin

#kubent
RUN curl -sL "https://github.com/doitintl/kube-no-trouble/releases/download/${KUBENT_VER}/kubent-${KUBENT_VER}-linux-amd64.tar.gz" | tar xz \
  && chmod +x kubent \
  && mv kubent /usr/local/bin

#terraform
RUN curl -sL "https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip" -o terraform.zip \
  && unzip -q terraform.zip \
  && mv terraform /usr/local/bin \
  && rm -rf terraform.zip

WORKDIR /root


