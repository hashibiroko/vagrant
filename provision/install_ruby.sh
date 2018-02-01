#!/bin/bash

echo "Ruby Installation for Ubuntu16.04"

if ! [[ -s /usr/bin/git ]]; then
    echo "Installing git"
    sudo apt-get update
    sudo apt-get install -y git
fi

if ! [[ -s ${HOME}/.rbenv ]]; then
    echo "Installing rbenv"
    git clone https://github.com/rbenv/rbenv.git ${HOME}/.rbenv
    cd ${HOME}/.rbenv && src/configure && make -C src && cd ${HOME}
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
    cat << EOF >> ${HOME}/.profile

# for rbenv
if [ -s \${HOME}/.rbenv ]; then
    export PATH=\${HOME}/.rbenv/bin:\${PATH}
    eval "\$(rbenv init -)"
fi
EOF
    source ${HOME}/.profile
else
    echo "rbenv is already installed."
fi

if ! [[ -s ${HOME}/.rbenv/plugins/ruby-build ]]; then
    echo "Installing ruby-build"
    mkdir -p ${HOME}/.rbenv/plugins
    git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
else
    echo "ruby-build is already installed."
fi

if ! [[ -s ${HOME}/.rbenv/versions/2.4.3 ]]; then
    sudo apt-get update
    sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev
    rbenv install 2.3.4
    rbenv global 2.3.4
    rbenv rehash
fi
