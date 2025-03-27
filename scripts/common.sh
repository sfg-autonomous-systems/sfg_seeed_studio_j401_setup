#!/usr/bin/env bash
BOLD_RED="\e[1;31m"
BOLD_GREEN="\e[1;32m"
RESET="\e[0m"

check_environment() {
    local USERNAME="${1}"

    if [[ -z "${USERNAME}" ]]; then
        echo -e "${BOLD_RED}Invalid invocation.${RESET}"
        echo -e "${BOLD_RED}Usage: $0 <username>${RESET}"
        echo -e "${BOLD_RED}Example: $0 ${USER}${RESET}"
        return 1
    fi

    if ! getent passwd "${USERNAME}" >/dev/null 2>&1; then
        echo -e "${BOLD_RED}User '${USERNAME}' does not exist on the system.${RESET}"
        return 1
    fi

    if [ ! -f "/proc/device-tree/model" ] || ! grep -qi "nvidia jetson" "/proc/device-tree/model"; then
        echo -e "${BOLD_RED}This script is only meant to be executed on an NVIDIA Jetson platform.${RESET}"
        return 1
    fi

    if ! dpkg-query -s nvidia-jetpack | grep -q "Version: 6.1"; then
        echo -e "${BOLD_RED}This script is only meant to be executed on JetPack version 6.1.${RESET}"
        return 1
    fi

    if [ "$(whoami)" != "root" ]; then
        echo "${BOLD_RED}Please run as root.${RESET}"
        return 1
    fi

    return 0
}
