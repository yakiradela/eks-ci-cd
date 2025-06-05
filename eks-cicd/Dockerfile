FROM ubuntu:22.04

# התקנת כלים נדרשים
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    jq \
    gnupg \
    wget \
    git \
    awscli \
    software-properties-common \
    sudo \
    nano \
    lsb-release \
    ca-certificates

# התקנת Terraform
RUN wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip && \
    unzip terraform_1.6.6_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_1.6.6_linux_amd64.zip

# התקנת Vault
RUN wget https://releases.hashicorp.com/vault/1.15.2/vault_1.15.2_linux_amd64.zip && \
    unzip vault_1.15.2_linux_amd64.zip && \
    mv vault /usr/local/bin/ && \
    rm vault_1.15.2_linux_amd64.zip

# בדיקות
RUN vault --version && terraform --version && aws --version && jq --version
