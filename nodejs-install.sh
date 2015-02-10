#!/bin/bash
# Script to do one-line non-root install of Node.js on Ubuntu and OSX
# Depends on curl which sometimes isn't preinstalled on Ubuntu, so do:
# sudo apt-get install curl

INSTALL_PATH=$HOME/.nodejs
N_VERSION=1.2.13

# Install n (Node.js versions manager)
cd /tmp
echo "Downloading n (Node.js versions manager)"
curl -L# https://github.com/tj/n/archive/v$N_VERSION.tar.gz | tar -xz
mkdir -p "$INSTALL_PATH/bin"
mv n-$N_VERSION/bin/* "$INSTALL_PATH/bin/"
rm -r n-$N_VERSION
cd

# Set $PATH and n folder environment variables
if [ `env | grep ^PATH= | sed "s|.*\(:$INSTALL_PATH/bin\).*|\1|"` != ":$INSTALL_PATH/bin" ]
  then
    echo "export PATH=\$PATH:$INSTALL_PATH/bin" >> $HOME/.profile
    export PATH=$PATH:$INSTALL_PATH/bin
fi
if [ "`grep "N_PREFIX" "$HOME/.profile"`" != "export N_PREFIX=$INSTALL_PATH" ]
  then
    echo "export N_PREFIX=$INSTALL_PATH" >> $HOME/.profile
    export N_PREFIX=$INSTALL_PATH
fi

# Install latest stable version of Node.js
echo "Installing latest stable Node.js"
n stable

# Check installation
echo "Node.js version installed:"
node -v
echo "NPM (Node Package Manager) version installed:"
npm -v
