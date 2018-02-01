#!/bin/bash

global_version=2.7.14

echo "Python Installation for Ubuntu16.04"

if ! [[ -s /usr/bin/git ]]; then
    echo "Installing git"
    sudo apt-get update
    sudo apt-get install -y git
fi

if ! [[ -s ${HOME}/.pyenv ]]; then
    echo "Installing pyenv"
    git clone git://github.com/yyuu/pyenv.git ${HOME}/.pyenv
    cat << EOF >> ${HOME}/.profile

# for pyenv
export PYENV_ROOT=\${HOME}/.pyenv
export PATH=\${PYENV_ROOT}/bin:\${PATH}
eval "\$(pyenv init -)"
EOF
    source ${HOME}/.profile
else
    echo "pyenv is already installed"
fi

if ! [[ -s ${PYENV_ROOT}/versions/${global_version} ]]; then
    sudo apt-get update
    sudo apt-get install -y \
        zlib1g-dev \
        libbz2-dev \
        libreadline6 \
        libreadline6-dev \
        libsqlite3-dev \
        libssl-dev
    pyenv install ${global_version}
    pyenv global ${global_version}
fi
