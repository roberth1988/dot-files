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
    # call custom helper for different topics
    git_setup
    font_setup
    zsh_setup
}

common_setup() {
    # create vim directory
    mkdir -p ~/.vim/colors

    # copy theme
    cp "$PKG_PATH/files/vim/solarized.vim" ~/.vim/colors

    # copy screen stats
    cp "$PKG_PATH/files/screen/screen-stats.awk" /usr/local/bin/screen-stats.awk
    chmod + /usr/local/bin/screen-stats.awk
}

git_setup() {
    git config --global user.name "Robert Hoppe"
    git config --global user.email "robert.hoppe@nodemash.com"
    git config --global github.user "roberth1988"
}

font_setup() {
    # install fonts
    git clone https://github.com/powerline/fonts.git /tmp/powerline-fonts
    cd /tmp/powerline-fonts; $1 ./install.sh
    rm -fr /tmp/powerline-fonts
}

zsh_setup() {
    # get current version of prezto
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

    # run zsh
    /usr/local/bin/zsh

    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done
}
