#!/usr/bin/env bash

set_up_vpi() {
    # Set up VPI as described in
    #     - https://nvidia-isaac-ros.github.io/getting_started/hardware_setup/compute/jetson_vpi.html
    nvidia-ctk cdi generate --mode=csv --output=/etc/cdi/nvidia.yaml

    apt-get update
    apt-get install software-properties-common
    apt-key adv --fetch-key https://repo.download.nvidia.com/jetson/jetson-ota-public.asc
    add-apt-repository -y 'deb https://repo.download.nvidia.com/jetson/common r36.4 main'
    apt-get update
    apt-get install -y pva-allow-2
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
    source "${SCRIPT_DIR}/common.sh"
    check_environment "${@}" || exit 1
    set_up_vpi
fi
