#!/bin/sh
# File  : setup.sh
# Author: lchannng <l.channng@gmail.com>
# Date  : 2020/05/02 19:13:02

cwd=`pwd`

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

if [ ! -x "$(command -v node)" ]; then
    echo "Please install nodejs."
    exit -1
fi

coc_extensions_dir=~/.config/coc/extensions

echo ${coc_extensions_dir}

# Install extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi

# Change extension names to the extensions you need
npm install coc-json --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
npm install coc-python --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
npm install coc-explorer --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

mkdir -p ~/.vim && cp -v ${cwd}/coc-settings.json ~/.vim/coc-settings.json
