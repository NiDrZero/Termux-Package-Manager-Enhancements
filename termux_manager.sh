#!/bin/bash

# Termux Package Manager Enhancements

# Function to check if a package is installed
is_installed() {
    dpkg -s "$1" &> /dev/null
}

# Function to install a package with dependency management
install_with_dependencies() {
    local package="$1"
    if is_installed "$package"; then
        echo "$package is already installed."
    else
        echo "Installing $package with dependencies..."
        pkg install -y "$package"
    fi
}

# Function to ensure termux-cron is installed
ensure_cron_installed() {
    if ! is_installed "termux-cron"; then
        echo "termux-cron is not installed. Installing..."
        pkg install -y termux-cron
    fi
}

# Function to schedule automatic updates
schedule_updates() {
    local cron_schedule="$1"
    ensure_cron_installed
    mkdir -p ~/.termux/cron
    echo "$cron_schedule pkg upgrade -y" > ~/.termux/cron/updater
    crontab ~/.termux/cron/updater
    termux-cron start
    echo "Automatic updates scheduled."
}

# Function to backup installed packages and configurations
backup_packages() {
    local backup_dir="$1"
    mkdir -p "$backup_dir"
    dpkg --get-selections > "$backup_dir/termux-packages-backup.txt"
    echo "Package list backed up to $backup_dir/termux-packages-backup.txt"
    tar -czvf "$backup_dir/termux-config-backup.tar.gz" ~/.termux
    echo "Configuration files backed up to $backup_dir/termux-config-backup.tar.gz"
}

# Function to restore packages and configurations from backup
restore_packages() {
    local backup_dir="$1"
    if [ -f "$backup_dir/termux-packages-backup.txt" ]; then
        dpkg --set-selections < "$backup_dir/termux-packages-backup.txt"
        apt-get dselect-upgrade -y
        echo "Packages restored from backup."
    else
        echo "Package backup file not found."
    fi

    if [ -f "$backup_dir/termux-config-backup.tar.gz" ]; then
        tar -xzvf "$backup_dir/termux-config-backup.tar.gz" -C ~/
        echo "Configuration files restored from backup."
    else
        echo "Configuration backup file not found."
    fi
}

# Function to display help information
show_help() {
    echo "Usage: $0 {install|update|backup|restore|help}"
    echo
    echo "Commands:"
    echo "  install <package>    Install a package with dependency management"
    echo "  update <schedule>    Schedule automatic updates (e.g., \"0 2 * * *\" for 2 AM daily)"
    echo "  backup <directory>   Backup installed packages and configurations to the specified directory"
    echo "  restore <directory>  Restore packages and configurations from the specified backup directory"
    echo "  help                 Display this help message"
}

# Main script logic
if [ $# -eq 0 ]; then
    echo "Error: No command provided."
    show_help
    exit 1
fi

case "$1" in
    install)
        if [ -z "$2" ]; then
            echo "Error: No package specified."
            show_help
            exit 1
        else
            install_with_dependencies "$2"
        fi
        ;;
    update)
        if [ -z "$2" ]; then
            echo "Error: No schedule specified."
            show_help
            exit 1
        else
            schedule_updates "$2"
        fi
        ;;
    backup)
        if [ -z "$2" ]; then
            echo "Error: No backup directory specified."
            show_help
            exit 1
        else
            backup_packages "$2"
        fi
        ;;
    restore)
        if [ -z "$2" ]; then
            echo "Error: No backup directory specified."
            show_help
            exit 1
        else
            restore_packages "$2"
        fi
        ;;
    help)
        show_help
        ;;
    *)
        echo "Error: Invalid command."
        show_help
        exit 1
        ;;
esac
