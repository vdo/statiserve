FROM debian:bullseye-slim

ARG IPFS_VERSION=v0.5.1

ENV IPFS_TMPDIR /tmp/ipfs

RUN apt-get update && apt-get install -y \
    libssl-dev \
    ca-certificates \
    supervisor \
    nginx \
    wget \
    gettext

RUN set -eux; \
    dpkgArch="$(dpkg --print-architecture)"; \
    case "${dpkgArch##*-}" in \
    "amd64" | "arm64") true ;;\
    *) echo >&2 "unsupported architecture: ${dpkgArch}"; exit 1 ;; \
    esac; \
    mkdir -p ${IPFS_TMPDIR} \
    && cd ${IPFS_TMPDIR} \
    && wget https://github.com/ipfs/go-ipfs/releases/download/${IPFS_VERSION}/go-ipfs_${IPFS_VERSION}_linux-${dpkgArch}.tar.gz -O $IPFS_TMPDIR/go-ipfs_${IPFS_VERSION}_linux-${dpkgArch}.tar.gz \
    && tar -xzvf go-ipfs_${IPFS_VERSION}_linux-${dpkgArch}.tar.gz \
    && cp go-ipfs/ipfs /usr/bin/ipfs

COPY init_ipfs /usr/bin/
COPY init_nginx /usr/bin/

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf.envsubst /etc/nginx/conf.d/default.conf.envsubst
COPY supervisord.conf /etc/supervisor/supervisord.conf

EXPOSE 80

CMD ["/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf"]