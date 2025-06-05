FROM ubuntu:22.04

# מונע אינטראקציה (שאלות) בהתקנות של apt
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Jerusalem

# התקנת כלים נדרשים כולל tzdata בצורה לא אינטראקטיבית
RUN apt-get update && \
    apt-get install -y \
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
    ca-certificates \
    tzdata && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

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

# בדיקות גרסאות
RUN vault --version && terraform --version && aws --version && jq --version
