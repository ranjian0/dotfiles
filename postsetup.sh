#!/bin/bash

# Install programming languages with their various managers
# -- python
uv python install

# -- nodejs
LATEST_STABLE_NODE=$(nvm ls-remote | grep "Latest LTS" | tail -n 1 | awk {'print $1'})

nvm install ${LATEST_STABLE_NODE}
