# Seeed Studio J401 Setup

**Disclaimer: The provided setup scripts only work with JetPack version 6.1!**

To set up your Seeed Studio J401 carrier board, flash it first by following the [official documentation by Seeed Studio](https://wiki.seeedstudio.com/reComputer_J4012_Flash_Jetpack/#flash-jetpack) up until you reach the initial configuration setup on the board itself.

During the initial configuration setup on the board itself, ensure you have internet access via tha LAN interface and configure the OS as in the table below. Note that any options that are not specifically listed in the table either have an obvious choice or are irrelevant.

| Setting | Value |
| -------- | ------- |
| Language | `English` |
| Your name | `SFG Agent` |
| Your computer's name | Should start with `sfg-` followed by a descriptive string, e.g. `sfg-go2-01` if it's the board mounted on the first Unitree Go2. |
| Pick a username | `sfg-agent` |
| Choose a password | Choose a safe, unique password. |
| Log in automatically | `yes` |
| APP partition size | Leave blank to use the maximum available size. |
| Install Chromium Browser | `yes` |

Next, when presented with the desktop environment, click through the initial window popup, opting out of everything. If you are presented with the software updater dialog, **do not update/upgrade any packages**.

To set up this repository you can do one of the following:

- If you have access to https://gitlab.hs-esslingen.de, you can simply execute the following inside a terminal:

    ```bash
    REPOSITORY_URL=https://gitlab.hs-esslingen.de/smart-factory-grids/autonomous-systems/tools/seeed-studio-j401-setup.git; \
    REPOSITORY_PATH=~/Documents/seeed_studio_j401_setup; \
    git clone "${REPOSITORY_URL}" "${REPOSITORY_PATH}" && \
    sudo "${REPOSITORY_PATH}/setup.sh "${USER}"
    ```

- If you do not have access to https://gitlab.hs-esslingen.de, you may transfer the repository via a USB stick and run the included `setup.sh` script with sudo privileges manually.


Once the setup has finished, the device will automatically reboot. Note that it might be the case that during reboot the bootloader's boot order might attempt to first boot via IPv4 or IPv6. In that case you may change the boot order to boot from the SSD as described [here](https://docs.nvidia.com/jetson/archives/r34.1/DeveloperGuide/text/SD/Bootloader/UEFI.html#boot-order-selection).

Once you are back in the desktop environment you should be able to connect to the WiFi of your choice and manage the device remotely via SSH.