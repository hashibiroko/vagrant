#!/bin/bash

global_version=1.9.3

echo "Golang Installation for Ubuntu16.04"

if ! [[ -s /usr/bin/git ]]; then
    echo "Installing git"
    sudo apt-get update
    sudp apt-get install -y git
fi

if ! [[ -s ${HOME}/.goenv ]]; then
    echo "Installing goenv"
    git clone https://github.com/syndbg/goenv.git ${HOME}/.goenv
    cat << EOF >> ${HOME}/.profile

# for goenv
if [ -s \${HOME}/.goenv ]; then
    export GOENV_ROOT=\${HOME}/.goenv
    export PATH=\${GOENV_ROOT}/bin:\${PATH}
    eval "\$(goenv init -)"
fi
EOF
    source ${HOME}/.profile
else
    echo "goenv is already installed"
fi

if ! [[ -s ${GOENV_ROOT}/versions/${global_version} ]]; then
    goenv install ${global_version}
    goenv global ${global_version}
    goenv rehash
fi
