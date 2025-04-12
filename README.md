# Termux Package Manager Enhancements

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Status](https://img.shields.io/badge/status-active-brightgreen)

## NOTE: Script is only slightly modified for my personal desire & needs testing! 

## Overview

Termux Package Manager Enhancements is a script designed to improve the package management capabilities of Termux. It provides advanced dependency management, automatic updates and upgrade scheduling, a user-friendly command-line interface, and backup and restore functionality for packages and configurations.

## Features

- **Advanced Dependency Management**
  - Automatically resolve and install package dependencies.
  - Detect and warn about package conflicts.

- **Automatic Updates and Upgrade Scheduling**
  - Schedule automatic package updates.
  - Notification options before updates.
  - Rollback functionality for updates.

- **User-friendly Command-line Interface Enhancements**
  - Intuitive commands for managing packages and configurations.
  - Interactive prompts for critical actions.
  - Comprehensive help and documentation.

- **Backup and Restore Functionality**
  - Backup installed packages and their configurations.
  - Restore packages and configurations from backups.

## Installation

To install the script, follow these steps:

1. **Clone The Repo:**
   ```sh
   git clone https://github.com/NiDrZero/Termux-Package-Manager-Enhancements.git
   ```
2. **Make the Script Executable:**
   ```sh
   chmod +x termux_manager.sh
   ```
3. **Move the Script to a Directory in Your PATH:**
   ```sh
   mv termux_manager.sh ~/.local/bin/termux_manager
   ```
## Usage
**Install a Package with Dependencies**
   ```sh
   termux_manager install <package_name>
   ```
**Schedule Automatic Updates**
  ```sh
  termux_manager update "<cron_schedule>"
  ```
Example:
  ```sh
  termux_manager update "0 2 * * *"  # Schedule updates at 2 AM daily
  ```
**Backup Packages and Configurations**
  ```sh
  termux_manager backup /path/to/backup_directory
  ```
**Restore Packages and Configurations**
  ```sh
  termux_manager restore /path/to/backup_directory
  ```
**Display Help**
  ```sh
  termux_manager Help
  ```
**Search For Packages**
  ```sh
  termux_manager search <package name>
  ```

**Examples**

1. Install a Package:
  ```sh
  termux_manager install vim
  ```

2. Schedule Automatic Updates at 3 AM Every Day:
  ```sh
  termux_manager update "0 3 * * *"
  ```

3. Backup to a Directory:
  ```sh
  termux_manager backup ~/termux_backup
  ```

4. Restore from a Backup:
  ```sh
  termux_manager restore ~/termux_backup
  ```
5. Search For A Package:
  ```sh
  termux_manager search vim

## Contributing

We welcome contributions! Please open an issue or submit a pull request on GitHub.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Contact
For any inquiries or feedback, please contact code.crafting.eagle@gmail.com
