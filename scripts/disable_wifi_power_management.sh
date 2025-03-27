#!/usr/bin/env bash

disable_wifi_power_management() {
    # Disable power management for wireless interfaces. This should basically only be one interface.
    # This is done because it could be an issue as mentioned here:
    #     - https://www.snbforums.com/threads/asus-xt8-latency-on-local-wifi-network-between-hosts.86123/
    echo -e "${BOLD_GREEN}> Disabling power managment for wireless interfaces.${RESET}"
    echo 'ACTION=="add", SUBSYSTEM=="net", KERNEL=="wlan*", RUN+="/sbin/iw dev %k set power_save off"' | tee /etc/udev/rules.d/99-disable-wifi-powersave.rules > /dev/null
    echo -e "${BOLD_GREEN}< Done disabling power managment for wireless interfaces.${RESET}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
    source "${SCRIPT_DIR}/common.sh"
    check_environment || exit 1
    disable_wifi_power_management
fi
