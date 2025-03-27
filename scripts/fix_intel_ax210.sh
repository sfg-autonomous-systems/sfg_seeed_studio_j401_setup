#!/usr/bin/env bash
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "${SCRIPT_DIR}/common.sh"

fix_intel_ax210() {
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
    echo -e "blacklist btusb\nblacklist bluetooth" >"/etc/modprobe.d/bluetooth.conf"
    echo -e "${BOLD_GREEN}Done disabling Bluetooth on Intel AX210.${RESET}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
    source "${SCRIPT_DIR}/common.sh"
    check_environment || exit 1
    disable_wifi_power_management
fi
