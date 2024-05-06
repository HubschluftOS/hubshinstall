#!/bin/bash

if ! command -v dialog &>/dev/null; then
    echo "Please install 'dialog' to run this script."
    exit 1
fi

welcome_message() {
    dialog --backtitle "HubshluftOS Installer" \
    --title "Welcome!" \
    --msgbox "Welcome to the HubshluftOS Installer. This script will guide you through the installation process." 10 60
    clear
}

function installer_menu() {

PS3='Please enter your choice: '
options=(1 "Installation" 
    2 "News" 
    3 "Quit")

while true; do
    opt=$(dialog --clear \
                --backtitle "Title" \
                --title "Menu" \
                --menu "$PS3" 15 60 4 \
                "${options[@]}" \
                2>&1 >/dev/tty)

    case $opt in
        1)
            dialog --msgbox "You chose choice 1" 10 30
            ;;
        2)
            result=$(curl -s https://hubschluftos.github.io/db/news.xml | awk -F'[<>]' '/webMaster/{print $3}')
            dialog --msgbox "$result" 10 60
            ;;
        3)
			clear
            exit
            ;;
        *) 
            dialog --msgbox "Invalid option" 10 30
            ;;
    esac
done
}

main(){
    welcome_message
    installer_menu
}

main
