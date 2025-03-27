#!/usr/bin/env bash

update_packages() {
    # Keep apt from upgrading L4T packages and then update, upgrade, and autoremove packages as described here:
    #     - https://www.forecr.io/blogs/bsp-development/how-to-apply-distro-upgrade-apt-upgrade-on-jetson-modules
    echo -e "${BOLD_GREEN}> Updating apt packages.${RESET}"
    apt-mark hold 'nvidia-l4t-*'
    apt-get update
    apt-get upgrade -y
    apt-get autoremove -y
    echo -e "${BOLD_GREEN}< Done updating apt packages.${RESET}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
    source "${SCRIPT_DIR}/common.sh"
    check_environment || exit 1
    update_packages
fi
