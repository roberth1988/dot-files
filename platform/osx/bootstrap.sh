#
# Bootstrap File for Mac Installations
#
# copyright Robert Hoppe - nodemash.com
#

# lets call xcode first
xcode-select --install

# install first homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# export paths
export PATH=/usr/local/bin:$PATH

brew install \
    git \
    vim \
    wget \
    python \
    tree \
    sshuttle \
    watch \
    mongodb \
    redis \
    libxml2 \
    libyaml \
    mysql \
    node \
    openssl \
    pcre \
    speedtest_cli

brew tap homebrew/services
brew install zsh --disable-etcdir

# install necessary pip modules
pip install progressbar \
    pyOpenSSL \
    requests \
    dnspython \
    lxml \
    pydns \
    regex \
    csvkit \
    pyaml \
    Flask \
    awesome-slugify \
    beautifulsoup4 \
    vatnumber \
    PyExecJS \
    suds \
    futures \
    Sphinx \
    chardet \
    redis \
    deepdiff \
    fuzzywuzzy \
    python-Levenshtein \
    MySQL-python \
    tldextract \
    raven \
    microdata \
    ngram \
    pyparsing \
    statsd \
    blinker \
    pycountry \
    simplejson

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# setup default shell to zsh
sudo -s 'echo /usr/local/bin/zsh >> /etc/shells' && chsh -s /usr/local/bin/zsh

# switch now to zsh
/usr/local/bin/zsh

# setup computer name
sudo scutil --set ComputerName "robsmac"
sudo scutil --set HostName "robsmac"
sudo scutil --set LocalHostName "robsmac"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "robsmac"

# Key Repeating
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 20
defaults write -g KeyRepeat -int 1

# Mission Control
defaults write com.apple.dock expose-animation-duration -float 0.15
killall Dock

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# Restart automatically if the computer freezes
systemsetup -setrestartfreeze on

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Turn off keyboard illumination when computer is not used for 5 minutes
defaults write com.apple.BezelServices kDimTime -int 300

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Don’t group windows by application in Mission Control
# (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool false

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Disable game center cruft
defaults write com.apple.gamed Disabled -bool true

# Dotfiles
curl -L ellipsis.sh | sh
