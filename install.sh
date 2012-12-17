#!/usr/bin/env sh

endpath="."

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}


echo "Thanks for installing spf13-vim"

# Backup existing .vim stuff
echo "backing up current vim config"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done


echo "setting up symlinks"
cp $endpath/.vimrc $HOME/.vimrc
cp $endpath/.vimrc.bundles $HOME/.vimrc.bundles

if [ ! -e $HOME/.vim/bundle/vundle ]; then
echo "Installing Vundle"
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi

echo "update/install plugins using Vundle"
vim -u $endpath/.vimrc.bundles +BundleInstall! +BundleClean +qall
