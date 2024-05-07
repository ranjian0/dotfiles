#!/bin/bash

# Install programming languages with their various managers
# -- python
LATEST_PY_310=$(pyenv install -l | grep -E "^  3.10.[0-9]+" | tail -n 1 | xargs)
LATEST_PY_311=$(pyenv install -l | grep -E "^  3.11.[0-9]+" | tail -n 1 | xargs)
LATEST_PY_312=$(pyenv install -l | grep -E "^  3.12.[0-9]+" | tail -n 1 | xargs)
GLOBAL_DEFAULT=LATEST_PY_312

pyenv install ${LATEST_PY_310}
pyenv install ${LATEST_PY_311}
pyenv install ${LATEST_PY_312}

pyenv global ${GLOBAL_DEFAULT}

pip install virtualenv

# -- nodejs
LATEST_STABLE_NODE=$(nvm ls-remote | grep "Latest LTS" | tail -n 1 | awk {'print $1'})

nvm install ${LATEST_STABLE_NODE}

# -- nim
LATEST_STABLE_NIM=$(choosenim versions | grep -E "[0-9].[0-9].[0-9]+$" | head -n 1 | xargs)

choosenim ${LATEST_STABLE_NIM}
