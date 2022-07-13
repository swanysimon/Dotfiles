#!/usr/bin/env bash

set -ex

if [[ "$(uname)" != "Darwin" ]]; then
    echo "Cannot set MacOS defaults" 1>&2
    exit 1
fi

####
# setup
####

# prevent any GUI from overriding changes
osascript -e 'tell application "System Preferences" to quit'

# get a password up front, and keep the timestamp active for the remainder of this script
sudo -v
while : ; do
    sudo -n true
    sleep 30
    kill -0 "$$" || exit
done &>/dev/null &

####
# system
####

# set system colors and highlighting
defaults write NSGlobalDomain AppleAquaColorVariant -int 1
defaults write NSGlobalDomain AppleHighlightColor -string "1.000000 0.937255 0.690196" # yellow

# always use 24 hour time
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true

# quitting applications closes windows
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# slightly less smoothing than the default
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# screenshots saved as PNGs to Downloads by default
defaults write com.apple.screencapture location -string "${HOME}/Downloads"
defaults write com.apple.screencapture type -string "jpg"

####
# control center
####

defaults write com.apple.controlcenter "NSStatusItem Visible AccessibilityShortcuts" -bool false
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible BentoBox" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible Clock" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible Display" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible DoNotDisturb" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible NowPlaying" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible Sound" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible WiFi" -bool true

####
# dock
####

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -int 0
defaults write com.apple.dock autohide-time-modifier -float 0.25
defaults write com.apple.dock largesize -int 100
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock mineffect -string "genie"
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock tilesize -int 50
defaults write com.apple.dock trash-full -bool true

####
# finder
####

defaults write com.apple.finder NewWindowTargetPath -string "$HOME"
defaults write com.apple.finder ShowPathBar -bool true
defaults write com.apple.finder ShowSidebar -bool true

# show external devices on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# don't use tags
defaults write com.apple.finder ShowRecentTags -bool false

####
# keyboard and mouse
####

# key repeat is preferred to the press-and-hold
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# faster key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# configure system typing substitions
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool true
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool true
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool true
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool true

defaults write NSGlobalDomain AppleShowScrollBars -string "Automatic"

# use "natural" scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

####
# audio
####

# disable system boot sound effects
sudo nvram SystemAudioVolume=" "

# system alert settings
defaults write NSGlobalDomain com.apple.sound.beep.flash -bool false
defaults write NSGlobalDomain com.apple.sound.beep.sound -string "/System/Library/Sounds/Pop.aiff";
defaults write NSGlobalDomain com.apple.sound.beep.volume -float 0.5
defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -bool true

# bluetooth audio needs some configuring
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Max (editable)" -int 80
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 48
defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool (editable)" -int 80
defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool Min (editable)" -int 48
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Max" -int 80
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Min" -int 48
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool" -int 53

####
# rectangle (window manager)
####

defaults write com.knollsoft.Rectangle SUEnableAutomaticChecks -bool false
defaults write com.knollsoft.Rectangle allowAnyShortcut -bool true
defaults write com.knollsoft.Rectangle alternateDefaultShortcuts -bool true
defaults write com.knollsoft.Rectangle hideMenubarIcon -bool true
defaults write com.knollsoft.Rectangle launchOnLogin -bool true
defaults write com.knollsoft.Rectangle subsequentExecutionMode -int 0
defaults write com.knollsoft.Rectangle windowSnapping -bool true

# shortcut overrides
defaults write com.knollsoft.Rectangle almostMaximize '{keyCode = 34; modifierFlags = 1703936;}'
defaults write com.knollsoft.Rectangle center '{keyCode = 34; modifierFlags = 1572864;}'
defaults write com.knollsoft.Rectangle bottomHalf '{}'
defaults write com.knollsoft.Rectangle bottomLeft '{}'
defaults write com.knollsoft.Rectangle bottomRight '{}'
defaults write com.knollsoft.Rectangle larger '{}'
defaults write com.knollsoft.Rectangle maximize '{}'
defaults write com.knollsoft.Rectangle nextDisplay '{}'
defaults write com.knollsoft.Rectangle restore '{}'
defaults write com.knollsoft.Rectangle smaller '{}'
defaults write com.knollsoft.Rectangle topHalf '{}'
defaults write com.knollsoft.Rectangle topLeft '{}'
defaults write com.knollsoft.Rectangle topRight '{}'

