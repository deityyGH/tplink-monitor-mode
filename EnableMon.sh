#!/bin/bash

check_root(){
        if [ "$(id -u)" -ne 0 ]; then
                echo "[!] This script must be run as root."
                exit 1
        fi
}

activate_driver(){
        echo "[*] Unloading rtl8xxxu driver."
        if ! modprobe -r rtl8xxxu; then
                echo "[!] Failed to unload rtl8xxxu driver."
                exit 1
        fi

        echo "[*]Activating rtl8xxxu driver."
        if ! modprobe rtl8xxxu; then
                echo "[!] Failed to load rtl8xxxu driver."
                exit 1
        fi
}

show_interfaces(){
        echo "Available wireless interfaces:"
        iwconfig 2>/dev/null | grep 'IEEE' | awk '{print $1}'
}

set_monitor_mode(){
        local interface="$1"

        echo "[*] Bringing down the interface $interface..."
        if ! ip link set "$interface" down; then
                echo "[!] Failed to bring down the interface $interface" 
                exit 1
        fi
        echo "[*] Setting $interface to monitor mode..."
        if ! iwconfig "$interface" mode monitor; then
                echo "[!] Failed to set $interface to monitor mode"
                exit 1
        fi

        echo "[*] Bringing up the interface $interface..."
        if ! ip link set "$interface" up; then
                echo "[!] Failed to bring up the interface $interface"
                exit 1
        fi
        echo "[+] $interface is now in monitor mode.\n"
}

check_root
show_interfaces

read -p "Enter the interface you want to set to monitor mode: " interface

set_monitor_mode "$interface"

iwconfig "$interface"
