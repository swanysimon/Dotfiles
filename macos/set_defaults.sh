#!/usr/bin/env bash

set -ex

prepare () {
    # prevent any GUI from overriding changes
    osascript -e 'tell application "System Preferences" to quit'

    # get a password up front, and keep the timestamp active for the remainder of this script
    sudo -v
    while : ; do
        sudo -n true
        sleep 30
        kill -0 "$$" || exit
    done &>/dev/null &
}

configure_system () {
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
    defaults write com.apple.screencapture type -string "png"
}

configure_dock () {
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock largesize -int 100
    defaults write com.apple.dock magnification -bool true
    defaults write com.apple.dock mineffect -string "genie"
    defaults write com.apple.dock minimize-to-application -bool true
    defaults write com.apple.dock tilesize -int 50
    defaults write com.apple.dock trash-full -bool true
}

configure_finder () {
    defaults write com.apple.finder ShowSidebar -bool true

    # show external devices on the desktop
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

    # don't use tags
    defaults write com.apple.finder ShowRecentTags -bool false
}

configure_keyboard () {
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
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true
    defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool true
    defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool true
}

configure_mouse () {
    defaults write NSGlobalDomain AppleShowScrollBars -string "Automatic"

    # use "natural" scrolling
    defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true
}

configure_system_audio () {
    # disable system boot sound effects
    sudo nvram SystemAudioVolume=" "

    # system alert settings
    defaults write NSGlobalDomain com.apple.sound.beep.flash -bool false
    defaults write NSGlobalDomain com.apple.sound.beep.sound -string "/System/Library/Sounds/Pop.aiff";
    defaults write NSGlobalDomain com.apple.sound.beep.volume -float 0.5
    defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -bool true
}

configure_bluetooth_audio () {
    defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Max (editable)" -int 80
    defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 48
    defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool (editable)" -int 80
    defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool Min (editable)" -int 48
    defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Max" -int 80
    defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Min" -int 48
    defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool" -int 53
}

configure_rectangle () {
    defaults write com.knollsoft.Rectangle alternateDefaultShortcuts -bool false
    defaults write com.knollsoft.Rectangle subsequentExecutionMode -int 0
}

prepare
configure_system
configure_dock
configure_finder
configure_keyboard
configure_mouse
configure_system_audio
configure_bluetooth_audio
configure_rectangle
