FROM alpine:3.12
ARG ANSIBLE_VERSION=2.9.10

RUN set -x && \
    \
    echo "==> Adding build-dependencies..." && \
    apk --update add --virtual build-dependencies \
        gcc \
        musl-dev \
        libffi-dev \
        openssl-dev \
        python3-dev \
        && \
    \
    echo "==> Upgrading apk and system..." && \
    apk update && apk upgrade && \
    \
    echo "==> Adding Python runtime..." && \
    apk add --no-cache \
        bash \
        curl \
        tar \
        openssh-client \
        sshpass \
        git \
        python3 \
        py3-boto3 \
        py3-dateutil \
        py3-httplib2 \
        py3-jinja2 \
        py3-paramiko \
        py3-pip \
        py3-wheel \
        py3-yaml \
        ca-certificates \
        && \
    \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir python-keyczar docker && \
    \
    echo "==> Installing Ansible..." && \
    pip install --no-cache-dir "ansible==${ANSIBLE_VERSION}" && \
    \
    echo "==> Cleaning up..." && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/* && \
    \
    echo "==> Adding hosts for convenience..." && \
    mkdir -p /etc/ansible /ansible/library /ansible/playbooks && \
    echo -ne '[local]\nlocalhost\n' >> /etc/ansible/hosts

# https://docs.ansible.com/ansible/latest/reference_appendices/config.html#environment-variables
ENV ANSIBLE_GATHERING=smart \
    ANSIBLE_HOST_KEY_CHECKING=False \
    ANSIBLE_RETRY_FILES_ENABLED=False \
    ANSIBLE_SSH_PIPELINING=True \
    ANSIBLE_ROLES_PATH=/ansible/playbooks/roles \
    ANSIBLE_LIBRARY=/ansible/library

WORKDIR /ansible/playbooks
