#!/usr/bin/env bash
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "${SCRIPT_DIR}/common.sh"

fix_intel_ax210() {
    # Fix Intel AX210 WiFi chip not working. This approach is based on
    #     - https://forum.seeedstudio.com/t/j4012-jetpack-6-no-wifi/279748/11
    echo -e "${BOLD_GREEN}> Fixing Intel AX210 firmware.${RESET}"
    rm /lib/modules/$(uname -r)/build
    ln -s /usr/src/linux-headers-$(uname -r)-ubuntu22.04_aarch64/3rdparty/canonical/linux-jammy/kernel-source/ \
        /lib/modules/$(uname -r)/build
    apt install -y --no-install-recommends iwlwifi-modules
    echo -e "${BOLD_GREEN}< Done fixing Intel AX210 firmware.${RESET}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
    source "${SCRIPT_DIR}/common.sh"
    check_environment "${@}" || exit 1
    fix_intel_ax210
fi
