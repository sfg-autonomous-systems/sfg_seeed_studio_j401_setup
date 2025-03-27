#!/usr/bin/env bash

disable_wifi_power_management() {
    # Disable power management for wireless interfaces. This should basically only be one interface.
    # This is done because it could be an issue as mentioned here:
    #     - https://www.snbforums.com/threads/asus-xt8-latency-on-local-wifi-network-between-hosts.86123/
    echo -e "${BOLD_GREEN}> Disabling power managment for wireless interfaces.${RESET}"

    if grep -q "^wifi\.powersave" "/etc/NetworkManager/conf.d/default-wifi-powersave-on.conf"; then
        sed -i "s/^wifi\.powersave = .*/wifi.powersave = 2/" "/etc/NetworkManager/conf.d/default-wifi-powersave-on.conf"
    else
        echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a "/etc/NetworkManager/conf.d/default-wifi-powersave-on.conf" >/dev/null
    fi

    echo -e "${BOLD_GREEN}< Done disabling power managment for wireless interfaces.${RESET}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
    source "${SCRIPT_DIR}/common.sh"
    check_environment "${@}" || exit 1
    disable_wifi_power_management
fi
