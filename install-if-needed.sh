#!/bin/bash

set -e

function install_if_needed {
  if [ ! -d "/Applications/$1.app" ]; then
    echo "🚩 We're missing $1; Install via $2"
  fi
}

# Paranoid stuff
install_if_needed "LuLu" "https://objective-see.com/products/lulu.html"
install_if_needed "TaskExplorer" "https://objective-see.com/products/taskexplorer.html"
install_if_needed "OverSight" "https://objective-see.com/products/oversight.html"
install_if_needed "KnockKnock" "https://objective-see.com/products/knockknock.html"

# Basic human needs
install_if_needed "Dropbox" "https://1password.com/"
install_if_needed "1Password 7" "https://1password.com/"
install_if_needed "Alfred 3" "https://www.alfredapp.com/"
install_if_needed "BetterSnapTool" "focking AppStore"
install_if_needed "The Unarchiver" "focking AppStore"
install_if_needed "Firefox" "https://www.mozilla.org"
install_if_needed "iStat Menus" "https://bjango.com/mac/istatmenus/"
install_if_needed "Slack" "https://slack.com"
install_if_needed "Spotify" "https://www.spotify.com"

# Tools
install_if_needed "Visual Studio Code" "https://code.visualstudio.com/download"
install_if_needed "xScope" "focking AppStore"
install_if_needed "Xcode" "focking AppStore"


