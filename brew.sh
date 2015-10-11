#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

brew install nmap
brew install git
brew install htop-osx
brew install ccache
brew install imagemagick
brew install httpie
brew install jq
brew install ffmpeg
brew install cowsay
brew install fortune
brew install youtube-dl
brew install vim
brew install mercurial
brew install mpd
brew install pandoc
brew install pidcat
brew install protobuf
brew install python
brew install sqlite
brew install terminal-notifier
brew install vim
brew install watch
brew install wget
brew install eck
brew install dark-modei

# Remove outdated versions
brew cleanup
