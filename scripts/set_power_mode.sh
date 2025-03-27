#!/usr/bin/env bash

set_power_mode() {
    echo -e "${BOLD_GREEN}> Setting power mode to MAXN.${RESET}"
    nvpmodel --force --mode 0
    echo -e "${BOLD_GREEN}< Done setting power mode to MAXN.${RESET}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
    source "${SCRIPT_DIR}/common.sh"
    check_environment || exit 1
    set_power_mode
fi
