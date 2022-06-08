#!/bin/bash

#############################################################################
# Name:         Autodesk Fusion 360 - Launcher (Linux)                      #
# Description:  With this file you run Autodesk Fusion 360 on your system.  #
# Author:       Steve Zabka                                                 #
# Author URI:   https://cryinkfly.com                                       #
# License:      MIT                                                         #
# Copyright (c) 2020-2022                                                   #
# Time/Date:    21:20/07.06.2022                                            #
# Version:      1.8 -> 1.9                                                  #
#############################################################################

# Path: /$HOME/.fusion360/bin/launcher.sh

#################################
# Open Autodesk Fusion 360 now! #
#################################

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

# This feature will check if there is a new version of Autodesk Fusion 360.
function setupact-check-fusion360 {
  mkdir -p /tmp/fusion360
  wget -N -P /tmp/fusion360 https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/build-version.txt  
  online_build_version=`cat /tmp/fusion360/build-version.txt | awk 'NR == 1'`
  online_build_insider_version=`cat /tmp/fusion360/build-version.txt | awk 'NR == 2'`
  echo "Online Build-Version: $online_build_version"
}

function setupact-config-update {
  system_build_version=`cat $WP_BOX/drive_c/users/$USER/AppData/Roaming/Autodesk/Autodesk\ Fusion\ 360/API/version.txt`
  echo "System Build-Version: $system_build_version"
  if [ "$online_build_version" = "$system_build_version" ] || [ "$online_build_insider_version" = "$system_build_version" ]; then
    echo "Do nothing!"
    GET_UPDATE=0
  else
    # A value of 0 means that there is no update and a value of 1 will notify the user that there is an update.
    GET_UPDATE=1
  fi 
}

###############################################################################################################################################################

# You must change the first part ($HOME/.wineprefixes/fusion360) and the last part (WINEPREFIX="$HOME/.wineprefixes/fusion360") when you have installed Autodesk Fusion 360 into another directory!
function setupact-open-fusion360 {
  launcher="$(find $WP_BOX -name Fusion360.exe -printf "%T+ %p\n" | sort -r 2>&1 | head -n 1 | sed -r 's/.+0000000000 (.+)/\1/')" && WINEPREFIX="$WP_BOX" wine "$launcher"
}

###############################################################################################################################################################
# THE PROGRAM IS STARTED HERE:                                                                                                                                #
###############################################################################################################################################################

setupact-check-fusion360
setupact-config-update
# This path you must change if you installed a custom installation of Autodesk Fusion 360! For example: $HOME/.config/fusion-360/bin/update-usb.sh 
. $HOME/.fusion360/bin/update.sh 
setupact-open-fusion360
