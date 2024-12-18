#!/bin/bash

# Read Project specific environment variables.
. ./.devcontainer/.env

# Download docker-compose services stack.
curl --fail-with-body -L \
  -H "Authorization: Bearer ${GH_TOKEN}" \
  -o ".devcontainer/services.yml" \
  https://raw.githubusercontent.com/awkbit/.github/main/.devcontainer/services.yml

curl --fail-with-body -L \
  -H "Authorization: Bearer ${GH_TOKEN}" \
  -o ".devcontainer/etc/.zshrc" \
  https://raw.githubusercontent.com/awkbit/.github/main/.devcontainer/etc/.zshrc
