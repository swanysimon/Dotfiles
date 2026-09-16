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

# AIDEV: macOS moved most Control Center items into a serialized config blob;
# only these still expose plain "VisibleCC" booleans on the real domain (no underscore).
defaults write com.apple.controlcenter "NSStatusItem VisibleCC Battery" -bool true
defaults write com.apple.controlcenter "NSStatusItem VisibleCC Clock" -bool true
defaults write com.apple.controlcenter "NSStatusItem VisibleCC WiFi" -bool true

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

# remap Caps Lock to Right Control on the built-in keyboard only. Looks up its
# vendor/product id rather than hardcoding one: this reports "0-0-0" on Apple
# Silicon, but Touch Bar MacBooks expose the built-in keyboard as a real USB
# device with nonzero ids. External keyboards always have their own nonzero
# ids, so this key never matches them.
remap_builtin_capslock_to_control() {
    local builtin_keyboard keyboard_vendor keyboard_product caps_lock right_control

    builtin_keyboard="$(hidutil list --ndjson --matching '{"PrimaryUsagePage":1,"PrimaryUsage":6,"IOPropertyMatch":{"Built-In":true}}' | head -1)"
    keyboard_vendor="$(echo "$builtin_keyboard" | jq -r '.VendorID // 0')"
    keyboard_product="$(echo "$builtin_keyboard" | jq -r '.ProductID // 0')"
    # HID Usage Page 0x07 (Keyboard/Keypad); Usage 0x39 Caps Lock, 0xE4 Right Control
    caps_lock=$(( (0x07 << 32) | 0x39 ))
    right_control=$(( (0x07 << 32) | 0xE4 ))

    # AIDEV: trailing "-0" is the legacy ADB keyboard-type component; every
    # built-in keyboard checked so far reports 0 here, unverified on Touch Bar hardware
    defaults -currentHost write NSGlobalDomain "com.apple.keyboard.modifiermapping.${keyboard_vendor}-${keyboard_product}-0" "(
        {
            HIDKeyboardModifierMappingSrc = ${caps_lock};
            HIDKeyboardModifierMappingDst = ${right_control};
        }
    )"
}
remap_builtin_capslock_to_control

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

