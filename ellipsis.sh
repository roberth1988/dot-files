#!/usr/bin/env bash
#
# roberth1988/files
#
# Dotfiles for various common bsd/unix utilities.

pkg.link() {
    fs.link_files common

    case $(os.platform) in
        osx)
            fs.link_files platform/osx
            ;;
        linux)
            fs.link_files platform/linux
            ;;
    esac
}

git-configured() {
    for key in user.name user.email github.user; do
        if [ -z "$(git config --global $key | cat)"  ]; then
            return 1
        fi
    done
    return 0
}

pkg.install() {
    # Backup existing configuration
    fs.backup ~/.vimrc
    fs.backup ~/.wgetrc
    fs.backup ~/.screenrc
    fs.backup ~/.zsh

    git config --global user.name "Robert Hoppe"
    git config --global user.email "robert.hoppe@nodemash.com"
    git config --global github.user "roberth1988"

    # install fonts
    git clone https://github.com/powerline/fonts.git /tmp/powerline-fonts
    cd /tmp/powerline-fonts; $1 ./install.sh
    rm -fr /tmp/powerline-fonts

    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
}
