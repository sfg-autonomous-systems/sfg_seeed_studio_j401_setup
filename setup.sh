#!/usr/bin/env bash
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Source all scripts.
for SCRIPT in "${SCRIPT_DIR}/scripts"/*.sh; do
    source "${SCRIPT}"
done

echo -e "${BOLD_GREEN}>>> Starting with setup.${RESET}"

check_environment "${@}" || exit 1
fix_intel_ax210
update_packages
install_dependencies "${1}"
disable_wifi_power_management

echo -e "${BOLD_GREEN}<<< Done with setup. Rebooting in 5 seconds.${RESET}"
sleep 5
set_power_mode
