#!/usr/bin/env bash
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Source all scripts.
for SCRIPT in "${SCRIPT_DIR}/scripts"/*.sh; do
    source "${SCRIPT}"
done

check_environment "${@}" || exit 1
update_packages
install_dependencies "${1}"
fix_intel_ax210
disable_wifi_power_management
