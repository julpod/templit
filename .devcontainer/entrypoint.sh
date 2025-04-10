#!/bin/bash
set -e

# Bring user configuration from otuside the container
[ -s "/opt/.ssh" ] && cp -r /opt/.ssh ~/
[ -s "/workspace/.devcontainer/etc/.zshrc" ] && cp -r /workspace/.devcontainer/etc/.zshrc ~/.zshrc

mkdir -p ~/.mc && cp -a /workspace/.devcontainer/etc/mc/* ~/.mc
# If the "myapp-bucket" minio bucket is already created, this will skip it.
mc mb local/myapp-bucket || true

# Solve `detected dubious ownership in repository`
git config --global --add safe.directory /var/www

# Initialize pm2 apps
pm2 start apps.config.yaml

exec "$@"