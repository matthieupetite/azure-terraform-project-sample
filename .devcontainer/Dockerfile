FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

LABEL maintainer="alexandre.saker@orange.com"

ARG USERNAME=vscode
ARG TF_VERSION=1.5.6-1
ARG NODE_MAJOR=20
ARG TFDOCS_VERSION=0.16.0
ARG TFSEC_VERSION=1.28.0
ARG AZCLI_VERSION=2.40.0
ARG POWERSHELL_VERSION=7.3.6-1.deb
ARG INFRACOST_API_KEY
ARG GIT_SSL_NO_VERIFY=true

#Proxy setup: please use the --build-arg=HTTP_PROXY="http://my.proxy:port" if needed
ARG HTTP_PROXY
ARG HTTPS_PROXY

ENV INFRACOST_API_KEY=${INFRACOST_API_KEY}
ENV HTTP_PROXY=${HTTP_PROXY}
ENV HTTPS_PROXY=${HTTPS_PROXY}
ENV GIT_SSL_NO_VERIFY=${GIT_SSL_NO_VERIFY}
ARG WORKSPACE="/home/$USERNAME/workspace"
WORKDIR ${WORKSPACE}
VOLUME ${WORKSPACE}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN echo ${HTTP_PROXY} && echo ${HTTPS_PROXY} \
    && export http_proxy=${HTTP_PROXY} \
    && export https_proxy=${HTTPS_PROXY} \
    && apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends git \
    ca-certificates \
    curl \
    apt-transport-https \
    lsb-release \
    tree \
    sudo \
    figlet \
    gnupg \
    git \
    software-properties-common \
    vim \
    gawk \
    unzip \
    zsh \
    && curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - \
    && apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    && apt-get -y update \ 
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    python3-pip \
    python-is-python3 \
    && pip install mdformat-gfm 
  



# Add Terraform
RUN  apt-get -y install --no-install-recommends \
     terraform=$TF_VERSION 


# Add Az Cli 
RUN pip install --upgrade pip \
    && pip install azure-cli==$AZCLI_VERSION

# Add Terraform Docs
RUN curl -sLo ./terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v${TFDOCS_VERSION}/terraform-docs-v${TFDOCS_VERSION}-$(uname)-amd64.tar.gz \
    && tar -xzf terraform-docs.tar.gz \
    && chmod +x terraform-docs \
    && rm terraform-docs.tar.gz \
    && mv terraform-docs /usr/local/bin/terraform-docs

# Add Tfsec
RUN curl -sLo tfsec.tar.gz https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec_${TFSEC_VERSION}_linux_amd64.tar.gz \
    && tar -xzf tfsec.tar.gz \
    && mv tfsec /usr/local/bin/tfsec \
    && rm tfsec*

# Add Repo
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo \
    && chmod a+x /usr/local/bin/repo 


# Add Node.js
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && NODE_MAJOR=${NODE_MAJOR} \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get -y update \
    && apt-get -y install --no-install-recommends nodejs

# Add dotnet 
RUN apt-get -y install --no-install-recommends dotnet-sdk-7.0
    
# Install Infracost
# Downloads the CLI based on your OS/arch and puts it in /usr/local/bin
RUN curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh

# Install Powershell
RUN curl -fsSL "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb" -o packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y --no-install-recommends powershell=$POWERSHELL_VERSION


# Add Terraform Sentinel
RUN curl -fsSL "https://releases.hashicorp.com/sentinel/0.22.1/sentinel_0.22.1_linux_amd64.zip" -o sentinel_0.22.1_linux_amd64.zip \
    && unzip sentinel_0.22.1_linux_amd64.zip \
    && rm sentinel_0.22.1_linux_amd64.zip \
    && chmod a+x sentinel \
    && mv sentinel /usr/local/bin/

# Clean Apt get list
RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/*
