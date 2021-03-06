#!/usr/bin/env bash
#
# roberth1988/files
#
# Dotfiles for various common bsd/unix utilities.

pkg.link() {
    fs.link_files common

#    case $(os.platform) in
#        osx)
#            fs.link_files platform/osx
#            ;;
#        linux)
#            fs.link_files platform/linux
#            ;;
#    esac
}

pkg.install() {
    # call custom helper for different topics
    common_setup
    git_setup
    zsh_setup
    font_setup
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

zsh_setup() {
    # get current version of prezto
    git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto

    # do manual linking
    ln -s ~/.zprezto/runcoms/zlogin ~/.zlogin
    ln -s ~/.zprezto/runcoms/zlogout ~/.zlogout
    ln -s ~/.zprezto/runcoms/zprofile ~/.zprofile
    ln -s ~/.zprezto/runcoms/zshenv ~/.zshenv

    # copy custom agnoster theme
    cp "$PKG_PATH/files/zsh/myagnoster.zsh-theme" ~/.zprezto/modules/prompt/functions/prompt_myagnoster_setup
}

git_setup() {
    git config --global user.name "Robert Hoppe"
    git config --global user.email "robert.hoppe@nodemash.com"
    git config --global github.user "roberth1988"
    git config --global core.editor vi
    git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)&lt;%an&gt;%Creset' --abbrev-commit"
}

font_setup() {
    # install fonts
    git clone https://github.com/powerline/fonts.git /tmp/powerline-fonts
    cd /tmp/powerline-fonts; $1 ./install.sh
    rm -fr /tmp/powerline-fonts
}
