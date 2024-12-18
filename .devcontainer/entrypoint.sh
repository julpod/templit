#!/bin/bash
set -e

# Bring user configuration from otuside the container
[ -s "/opt/.ssh" ] && cp -r /opt/.ssh ~/
[ -s "/workspace/.devcontainer/etc/.zshrc" ] && cp -r /workspace/.devcontainer/etc/.zshrc ~/.zshrc

# Solve `detected dubious ownership in repository`
git config --global --add safe.directory /var/www

exec "$@"