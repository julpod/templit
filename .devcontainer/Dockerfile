FROM node:22-alpine

# Install base dependencies
RUN apk add --no-cache \
      git \
      bash \
      curl \
      g++ \
      make \
      python3 \
      openssh-client \
      py3-pip \
      xdg-utils

# Install Mkcert
ENV MKCERT_VERSION=v1.4.4
RUN ARCH=$([ "$(uname -m)" = "aarch64" ] && echo "arm64" || [ "$(uname -m)" = "x86_64" ] && echo "amd64" || uname - m) \
    && curl -sLO https://github.com/FiloSottile/mkcert/releases/download/${MKCERT_VERSION}/mkcert-v1.4.4-linux-${ARCH} \
    && chmod +x mkcert-${MKCERT_VERSION}-linux-${ARCH} \
    && mv mkcert-${MKCERT_VERSION}-linux-${ARCH} /usr/local/bin/mkcert

# Trust mkcert certificates
ENV CAROOT="/etc/mkcert"
RUN mkdir -p $CAROOT
COPY etc/mkcert/rootCA.pem $CAROOT/rootCA.pem
RUN /usr/local/bin/mkcert -install

# Install Minio client
RUN ARCH=$([ "$(uname -m)" = "aarch64" ] && echo "arm64" || [ "$(uname -m)" = "x86_64" ] && echo "amd64" || uname -m) \
    && curl -sLO https://dl.min.io/client/mc/release/linux-${ARCH}/mc \
    && chmod +x ./mc \
    && mv ./mc /usr/local/bin/mc

# Install additional node packages
RUN set -e \
  && npm install --location=global n \
  && npm install --location=global nx \
  && npm install --location=global pm2

# Setup entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Expose default ports
EXPOSE 3000

# Set default user
USER node

# Set default working folder
WORKDIR /workspace

# Keep container always running
CMD ["sleep", "infinity"]