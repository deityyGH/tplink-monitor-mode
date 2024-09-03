# TPLink-WN722N-to-monitor-mode
TP Link WN722N monitor mode setup on Linux

sudo apt update
sudo apt upgrade

# Optional
sudo apt install linux-headers-$(uname -r)
sudo apt dist-upgrade 


sudo apt install -y realtek-rtl8188eus-dkms
Use this if the driver above does not work
https://github.com/aircrack-ng/rtl8188eus


sudo wifite --kill
sudo modprobe -r rtl8xxxu
sudo modprobe rtl8xxxu

# Now this should work
sudo wifite



