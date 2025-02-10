#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "Error: This script must be run as root (use sudo)"
    exit 1
fi

# Function to display help message
usage() {
    echo "=================================="
    echo "  User Management Script"
    echo "=================================="
    echo "Usage: $0 [OPTION]"
    echo "Options:"
    echo "  -c, --create    Create a new user account"
    echo "  -d, --delete    Delete an existing user account"
    echo "  -r, --reset     Reset password for an existing user account"
    echo "  -l, --list      List all user accounts with their UIDs"
    echo "  -h, --help      Display this help message"
    echo "  -q, --quit      Quit"
    echo "=================================="
}

# Function to create a new user
create_user() {
    read -p "Enter new username: " username
    if id "$username" &>/dev/null; then
        echo "Error: Username '$username' already exists."
        return
    fi
    read -s -p "Enter password: " password
    echo
    sudo useradd -m -s /bin/bash "$username" 
    echo "$username:$password" | sudo chpasswd
    echo "User '$username' has been created successfully."
}

# Function to delete a user
delete_user() {
    read -p "Enter username to delete: " username
    if ! id "$username" &>/dev/null; then
        echo "Error: Username '$username' does not exist."
        return
    fi
    sudo userdel -r "$username"
    echo "User '$username' has been deleted successfully."
}

# Function to reset user password
reset_password() {
    read -p "Enter username to reset password: " username
    if ! id "$username" &>/dev/null; then
        echo "Error: Username '$username' does not exist."
        return
    fi
    read -s -p "Enter new password: " password
    echo
    echo "$username:$password" | sudo chpasswd
    echo "Password for user '$username' has been updated successfully."
}

# Function to list users
list_users() {
    echo "List of user accounts:"
    awk -F: '{ print "Username: "$1", UID: "$3 }' /etc/passwd
}

# Main script loop
while true; do
    usage
    read -p "Enter your choice: " choice

    case "$choice" in
        -c|--create)
            create_user
            ;;
        -d|--delete)
            delete_user
            ;;
        -r|--reset)
            reset_password
            ;;
        -l|--list)
            list_users
            ;;
        -h|--help)
            usage
            ;;
        -q|--quit)
            echo "Exiting script."
            exit 0
            ;;
        *)
            echo "Invalid option: $choice"
            usage
            ;;
    esac
    read -p "Press Enter to continue..."  # Pause before refreshing menu
done
