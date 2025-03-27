#!/usr/bin/env bash

disable_wifi_power_management() {
    # Disable power management for wireless interfaces. This should basically only be one interface.
    # This is done because it could be an issue as mentioned here:
    #     - https://www.snbforums.com/threads/asus-xt8-latency-on-local-wifi-network-between-hosts.86123/
    echo -e "${BOLD_GREEN}> Disabling power managment for wireless interfaces.${RESET}"
    INTERFACES=$(iwconfig 2>/dev/null | grep '^[a-zA-Z0-9]' | awk '{print $1}')

    for INTERFACE in ${INTERFACES}; do
        echo -e "Disabling power management for ${INTERFACE}"
        iwconfig ${INTERFACE} power off
    done

    echo -e "${BOLD_GREEN}< Done disabling power managment for wireless interfaces.${RESET}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
    source "${SCRIPT_DIR}/common.sh"
    check_environment || exit 1
    disable_wifi_power_management
fi
