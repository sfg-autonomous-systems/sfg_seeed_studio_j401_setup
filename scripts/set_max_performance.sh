#!/usr/bin/env bash

set_max_performance() {
    echo -e "${BOLD_GREEN}> Setting max performance.${RESET}"
    # Set max performance as decribed in
    #     - https://nvidia-isaac-ros.github.io/getting_started/hardware_setup/compute/index.html#jetson-platforms
    jetson_clocks
    nvpmodel --force --wait "${1}" --mode 0
    echo -e "${BOLD_GREEN}< Done setting max performance.${RESET}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
    source "${SCRIPT_DIR}/common.sh"
    check_environment "${@}" || exit 1
    set_max_performance 0
fi
