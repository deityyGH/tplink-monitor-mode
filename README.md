# TPLink-WN722N WiFi Adapter Monitor Mode Fix Script
This Bash script is designed to enable monitor mode for TP-Link WiFi adapters, specifically those that may encounter issues when switching to monitor mode due to driver conflicts. The script automatically unloads and reloads the rtl8xxxu driver, helping the adapter function properly in monitor mode.

## Features
- Checks for root privileges, as root access is required to manage network interfaces and drivers.
- Unloads and reloads the rtl8xxxu driver to address potential issues with TP-Link adapters.
- Lists available wireless interfaces for selection.
- Configures the selected wireless interface to operate in monitor mode, which is essential for tasks such as network monitoring and packet capturing.

## Usage
1. **Install the driver**\
  To ensure compatibility with TP-Link WiFi adapters, follow these steps to install the necessary headers and drivers:
    ```bash
    # Update and upgrade system packages
    sudo apt update
    sudo apt upgrade
    sudo apt install linux-headers-$(uname -r)
    sudo apt dist-upgrade 
    ```
    ```bash
    # Install the RTL8188EUS driver with DKMS support
    sudo apt install -y realtek-rtl8188eus-dkms
    ```
    ```bash
    # Alternatively, clone and install the driver from the aircrack-ng repository
    git clone https://github.com/aircrack-ng/rtl8188eus
    cd rtl8188eus
    make
    sudo make install
    ```
3. **Run the Script as Root**\
  To execute this script, you need root privileges. Run the following command in your terminal:
    ```bash
    sudo ./EnableMon.sh
    ```
3. **Select the Interface**\
  The script will display a list of available wireless interfaces. Enter the name of the interface you want to set to monitor mode when prompted.
4. **Monitor Mode Activation**\
  The script will automatically bring down the interface, set it to monitor mode, and then bring it back up. Successful activation will be confirmed with a message.


## Important Notes
- This script specifically addresses issues with TP-Link adapters that use the rtl8xxxu driver. For other adapters or drivers, adjustments may be necessary.
- Ensure that no other network processes are using the adapter before running the script to avoid conflicts.


## Troubleshooting
- **Adapter Not Entering Monitor Mode**\
  If the adapter fails to enter monitor mode, try rebooting the system. Immediately after the reboot, stop the Network Manager to prevent interference:
  ```bash
  sudo systemctl stop NetworkManager
  ```
  Afterward, repeat the process from **Step 3** in the **Usage** section.
- **Persistent Issues with Monitor Mode**\
  If issues continue, manually restart the driver using the following commands:
  ```bash
  sudo wifite --kill
  sudo modprobe -r rtl8xxxu
  sudo modprobe rtl8xxxu
  ```
  Then, try running wifite to check if monitor mode is now enabled:
  ```bash
  sudo wifite
  ```






