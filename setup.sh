#!/usr/bin/env bash
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Set up SSH authentication.
"${SCRIPT_DIR}/ssh_authentication/setup.sh"

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
set_up_vpi

WAIT=5
echo -e "${BOLD_GREEN}<<< Done with setup. Rebooting in ${WAIT} seconds.${RESET}"
set_max_performance "${WAIT}" >/dev/null 2>&1
