#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

BOLD_RED="\e[1;31m"
BOLD_GREEN="\e[1;32m"
RESET="\e[0m"

if [ ! -f "/proc/device-tree/model" ] || ! grep -qi "nvidia jetson" "/proc/device-tree/model"; then
    echo -e "${BOLD_RED}This script is only meant to be executed on an NVIDIA Jetson platform.${RESET}"
    exit 1
fi

if [ "$(whoami)" != "root" ] ; then
    echo "Please run as root"
    exit 1
fi

# Keep apt from upgrading L4T packages and then update, upgrade, and autoremove packages as described here:
#     - https://www.forecr.io/blogs/bsp-development/how-to-apply-distro-upgrade-apt-upgrade-on-jetson-modules
echo -e "${BOLD_GREEN}Updating apt packages.${RESET}"
apt-mark hold 'nvidia-l4t-*'
apt-get update
apt-get upgrade -y
apt-get autoremove -y
echo -e "${BOLD_GREEN}Done updating apt packages.${RESET}"

# Fix Intel AX210 WiFi chip not working. This approach is based on
#     - https://www.forecr.io/blogs/bsp-development/how-to-use-intel-ax210ngw-adapter-on-jetpack-5-0
# but ported to jetpack 6.0 through "trial-and-error".
echo -e "${BOLD_GREEN}Fixing Intel AX210 firmware.${RESET}"
rm "/lib/firmware/iwlwifi-ty-a0-gf-a0.pnvm"
rm "/lib/firmware/iwlwifi-ty-a0-gf-a0-66.ucode"
cp "${SCRIPT_DIR}/../drivers/intel/ax210/iwlwifi-ty-a0-gf-a0-66.ucode" "/lib/firmware"
echo -e "${BOLD_GREEN}Done fixing Intel AX210 firmware.${RESET}"

# Disable Bluetooth on Intel AX210 WiFi chip. Based on the same approach as above.
echo -e "${BOLD_GREEN}Disabling Bluetooth on Intel AX210.${RESET}"
echo -e "blacklist btusb\nblacklist bluetooth" > "/etc/modprobe.d/bluetooth.conf"
echo -e "${BOLD_GREEN}Done disabling Bluetooth on Intel AX210.${RESET}"

# Disable power management for wireless interfaces. This should basically only be one interface.
# This is done because it could be an issue as mentioned here:
#     - https://www.snbforums.com/threads/asus-xt8-latency-on-local-wifi-network-between-hosts.86123/
echo -e "${BOLD_GREEN}Disabling power managment for wireless interfaces.${RESET}"
INTERFACES=$(iwconfig 2>/dev/null | grep '^[a-zA-Z0-9]' | awk '{print $1}')

for INTERFACE in ${INTERFACES}; do
    echo -e "Disabling power management for ${INTERFACE}"
    iwconfig ${INTERFACE} power off
done

echo -e "${BOLD_GREEN}Done disabling power managment for wireless interfaces.${RESET}"