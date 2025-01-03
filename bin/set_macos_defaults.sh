#!/usr/bin/env bash


trap 'killall Dock ; killall Finder' EXIT


set -exuo pipefail


####
# Appearance
####

chflags nohidden ~/Library

defaults write NSGlobalDomain AppleAquaColorVariant -int 1
defaults write NSGlobalDomain AppleFontSmoothing -bool true
defaults write NSGlobalDomain AppleHighlightColor -string "1.000000 0.937255 0.690196" # yellow
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true


####
# Screenshot Behavior
####

defaults write com.apple.screencapture location -string "${HOME}/Downloads"
defaults write com.apple.screencapture type -string png


####
# Control Center
####


defaults write com.apple.control_center "NSStatusItem Visible AccessibilityShortcuts" -bool false
defaults write com.apple.control_center "NSStatusItem Visible AudioVideoModule" -bool false
defaults write com.apple.control_center "NSStatusItem Visible Battery" -bool true
defaults write com.apple.control_center "NSStatusItem Visible BentoBox" -bool true
defaults write com.apple.control_center "NSStatusItem Visible Bluetooth" -bool true
defaults write com.apple.control_center "NSStatusItem Visible Clock" -bool true
defaults write com.apple.control_center "NSStatusItem Visible Display" -bool true
defaults write com.apple.control_center "NSStatusItem Visible DoNotDisturb" -bool true
defaults write com.apple.control_center "NSStatusItem Visible FaceTime" -bool false
defaults write com.apple.control_center "NSStatusItem Visible FocusModes" -bool true
defaults write com.apple.control_center "NSStatusItem Visible NowPlaying" -bool true
defaults write com.apple.control_center "NSStatusItem Visible ScreenMirroring" -bool true
defaults write com.apple.control_center "NSStatusItem Visible Sound" -bool true
defaults write com.apple.control_center "NSStatusItem Visible StageManager" -bool false
defaults write com.apple.control_center "NSStatusItem Visible WiFi" -bool true

####
# Dock
####


defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -int 0
defaults write com.apple.dock autohide-time-modifier -float 0.25
defaults write com.apple.dock expose-group-apps -bool true
defaults write com.apple.dock largesize -int 100
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock mineffect -string genie
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mru_spaces -bool false
defaults write com.apple.dock orientation -string left
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock tilesize -int 50
defaults write com.apple.dock trash-full -bool true


####
# Finder
####


defaults write com.apple.finder NewWindowTargetPath -string "$HOME"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowRecentTags -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowSidebar -bool true


####
# Keyboard
####

# key repeat is preferred to the press-and-hold
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# faster key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 12

# configure system typing substitions
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool true
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool true
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticTextCompletionCollapsed -bool true
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool true
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool true

####
# Mouse
####

defaults write NSGlobalDomain AppleShowScrollBars -string "Automatic"

# use "natural" scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true


####
# Audio
####


# system alert settings
defaults write NSGlobalDomain com.apple.sound.beep.flash -bool false
defaults write NSGlobalDomain com.apple.sound.beep.sound -string "/System/Library/Sounds/Pop.aiff";
defaults write NSGlobalDomain com.apple.sound.beep.volume -float 0.5
defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -bool true

# bluetooth audio sometimes acts strange; add to bitpool
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Max (editable)" -int 80
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 48
defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool (editable)" -int 80
defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool Min (editable)" -int 48
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Max" -int 80
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Min" -int 48
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool" -int 53

