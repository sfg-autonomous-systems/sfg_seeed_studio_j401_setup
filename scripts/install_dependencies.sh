#!/usr/bin/env bash

install_git_lfs() {
    echo -e "${BOLD_GREEN}> Installing Git LFS.${RESET}"
    apt-get install -y git-lfs
    git lfs install --skip-repo
    echo -e "${BOLD_GREEN}< Done installing Git LFS.${RESET}"
}

install_docker() {
    # Install Docker as described in 
    #     - https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository.
    echo -e "${BOLD_GREEN}> Installing Docker.${RESET}"
    apt-get update
    apt-get install -y ca-certificates curl
    install -m 0755 -d "/etc/apt/keyrings"
    curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" -o "/etc/apt/keyrings/docker.asc"
    chmod a+r "/etc/apt/keyrings/docker.asc"

    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by="/etc/apt/keyrings/docker.asc"] "https://download.docker.com/linux/ubuntu" \
        $(. "/etc/os-release" && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" |
        tee "/etc/apt/sources.list.d/docker.list" >"/dev/null"
    apt-get update

    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    groupadd docker
    usermod -aG docker "${1}"
    echo -e "${BOLD_GREEN}< Done installing Docker.${RESET}"
}

install_dependencies() {
    install_git_lfs
    install_docker "${1}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
    source "${SCRIPT_DIR}/common.sh"
    check_environment "${@}" || exit 1
    install_dependencies "${1}"
fi
